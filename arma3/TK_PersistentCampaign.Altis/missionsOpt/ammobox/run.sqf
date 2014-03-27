private["_zoneIndex"];
_zoneIndex = _this select 0;
private["_missionInfoIndex"];
_missionInfoIndex = _this select 1;

/*----------------------------------*/
/* Die Missionsdaten herausarbeiten */
/*----------------------------------*/
private["_missionOpt"]; /* [missionIndex, missionPosition, missionDirection, markerPosition, markerRadius] */
_missionOpt = ((pvehPixZones_MissionInfos select 2) select _missionInfoIndex);
private["_missionPosition"];
_missionPosition = _missionOpt select 1;
private["_missionDirection"];
_missionDirection = _missionOpt select 2; /* hier nicht verwendet */
private["_missionMarkerPosition"];
_missionMarkerPosition = _missionOpt select 3;
private["_missionMarkerRadius"];
_missionMarkerRadius = _missionOpt select 4;

/*---------------------------*/
/* Building Typen definieren */
/*---------------------------*/
private["_buildingClassnames"];
_buildingClassnames = ["Box_East_WpsSpecial_F"];

/* Aus der zufälligen Richtung den Klassennamen errechnen */
private["_buildingClassnameIndex"];
_buildingClassnameIndex = floor (((count _buildingClassnames) / 360) * _missionDirection);
if (_buildingClassnameIndex < 0) then { _buildingClassnameIndex = 0;};
if (_buildingClassnameIndex >= count _buildingClassnames) then { _buildingClassnameIndex = (count _buildingClassnames) - 1;};

private["_buildingClassname"];
_buildingClassname = _buildingClassnames select _buildingClassnameIndex;


/*---------------------------------------*/
/* Wenn notwendig die Clientside starten */
/*---------------------------------------*/
if (!isServer || !isDedicated) then
{
	[] spawn {
		/*-------------------------*/
		/* Missions vorbereitungen */
		/*-------------------------*/
		/* Munitionskisten suchen (warten bis erzeugt) */
		private["_counter"];
		_counter = 20;
		private["_objects"];
		_objects = [];
		while { (count _objects != 2) && (_counter > 0) } do
		{
			Sleep 0.5;
			_objects = nearestObjects [_missionPosition, [_buildingClassname], 50];
			_counter = _counter - 1;
		};
		
		/* Action Menü zu den Objekten hinzufügen */
		{ _x addAction["Sprengladung platzieren", "missionsOpt\_common\actionPlaceExplosives.sqf"]; } foreach _objects;

		/*----------------------------------------*/
		/* Standart Missions verarbeitung starten */
		/*----------------------------------------*/
		private["_taskTitle"];
		_taskTitle = "Materialkisten zerstören";
		private["_taskDescription"];
		_taskDescription = "Unser Nachrichtendienst hat Informationen abgefangen die darauf hinweisen, dass im Zielgebiet eine neue Technologie getestet werden soll. Laut den Informationen der verdeckten Ermittler, handelt es sich dabei um Material welche in zwei Kisten transportiert wird. Prüfen und zerstören Sie diese Materialkisten. Es ist mit Feindlicher Infantrie zu rechnen, welche zur Bewachung abgestellt wurde.";
		private["_tmp"];
		_tmp = [_missionInfoIndex, _missionMarkerPosition, _missionMarkerRadius, _taskTitle, _taskDescription] execVM "missionsOpt\_common\runClient.sqf";	
	};
};

if (isServer) then
{
	private["_groups"];
	_groups = [];
	private["_vehicles"];
	_vehicles = [];
	private["_buildings"];
	_buildings = [];
	
	private["_ammobox1"];
	_ammobox1 = _buildingClassname createVehicle _missionPosition;
	_ammobox1 setdir random 360;
	_ammobox1 setVectorUp surfaceNormal (position _ammobox1);
	_ammobox1 allowDamage false;
	_buildings = _buildings + [_ammobox1];

	private["_ammobox2"];
	_ammobox2 = _buildingClassname createVehicle _missionPosition;
	_ammobox2 setdir random 360;
	_ammobox2 setVectorUp surfaceNormal (position _ammobox2);
	_ammobox2 allowDamage false;
	_buildings = _buildings + [_ammobox2];	

	/*----------------------------------------------------------------------------*/
	/* Anzahl der Spieler berechnen um den Schwierigkeitsgrad bestimmen zu können */
	/*----------------------------------------------------------------------------*/
	private["_patrolCount"];
	_patrolCount = ceil((call PC_fnc_GetPlayerCount) / 6);

	/*-------------------------*/
	/* Patroullierende Truppen */
	/*-------------------------*/
	for "_i" from 0 to _patrolCount do 
	{
		private["_groupInfos"];
		_groupInfos = [["OIA_InfSquad","OIA_InfTeam","OIA_InfTeam_AT","OIA_MotInf_Team","OIA_MotInf_AT"], _zoneIndex, _missionPosition, 600, 25] call PC_fnc_SpawnGroupPatrolObject;		
		if (count _groupInfos > 0) then
		{
			_groups = _groups + [(_groupInfos select 0)];
			_vehicles = _vehicles + (_groupInfos select 1);
		};
	};

	/*----------------------*/
	/* Verteidigungs Truppe */
	/*----------------------*/
	private["_groupInfos"];
	_groupInfos = [["OIA_InfSquad","OIA_InfTeam","OIA_InfTeam_AT","OIA_MotInf_Team","OIA_MotInf_AT","OIA_InfSentry"], _missionPosition] call PC_fnc_SpawnGroupGuardObject;
	if (count _groupInfos > 0) then
	{
		_groups = _groups + [(_groupInfos select 0)];
		_vehicles = _vehicles + (_groupInfos select 1);
	};

	/*-------------*/
	/* Minenfelder */
	/*-------------*/
	private["_mineFieldCount"];
	_mineFieldCount = 1 + floor(random 3);
	for "_i" from 0 to _mineFieldCount do 
	{
		[_missionPosition, ["APERSMine","APERSBoundingMine","APERSTripMine"]] call PC_fnc_CreateMineFieldAtTarget;
	};

	/*--------------------------------------*/
	/* Warten bis die Mission erfüllt wurde */
	/*--------------------------------------*/
	waitUntil {((!alive _ammobox1) && (!alive _ammobox2)) || (pixZones_ActiveIndex == -1)};
	
	/*--------------------------------------------------------*/
	/* Status auf beendet setzen und allen Clienten mitteilen */
	/*--------------------------------------------------------*/
	[_missionInfoIndex] call PC_fnc_FinishMissionStatus;

	/*-------------------------------------------------------------------------------------------------------------*/
	/* Warten bis Zone beendet. Dann nocheinmal zufäige Zeitverzögerung, damit nicht alle gleichzeitig aufräumen */
	/*-------------------------------------------------------------------------------------------------------------*/
	waitUntil {pixZones_ActiveIndex == -1 };
	sleep (random 60);
	[_groups, _vehicles, _buildings, true] call PC_fnc_CleanupMission;
};






