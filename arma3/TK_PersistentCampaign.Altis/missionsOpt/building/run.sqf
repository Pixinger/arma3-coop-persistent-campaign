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
_missionDirection = _missionOpt select 2; /* Wird hier verwendet um den Gebäude Typen zu bestimmen */
private["_missionMarkerPosition"];
_missionMarkerPosition = _missionOpt select 3;
private["_missionMarkerRadius"];
_missionMarkerRadius = _missionOpt select 4;

/*---------------------------*/
/* Building Typen definieren */
/*---------------------------*/
private["_buildingClassnames"];
_buildingClassnames = ["Land_TTowerBig_1_F","Land_TTowerBig_2_F"];
private["_actionObjectClassname"];
_actionObjectClassname = "Land_PowerGenerator_F"; /*Land_dp_transformer_F Target_Rail_End_F*/

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
	[_missionPosition, _missionInfoIndex, _missionMarkerPosition, _missionMarkerRadius, _buildingClassname, _actionObjectClassname] spawn {
		/* Variablen übergeben */
		private["_missionPosition"];
		_missionPosition = _this select 0;
		private["_missionInfoIndex"];
		_missionInfoIndex = _this select 1;
		private["_missionMarkerPosition"];
		_missionMarkerPosition = _this select 2;
		private["_missionMarkerRadius"];
		_missionMarkerRadius = _this select 3;
		private["_buildingClassname"];
		_buildingClassname = _this select 4;
		private["_actionObjectClassname"];
		_actionObjectClassname = _this select 5;
		
		/*-------------------------*/
		/* Missions vorbereitungen */
		/*-------------------------*/
		/* Objekte suchen (warten bis erzeugt) */
		private["_counter"];
		_counter = 20;
		private["_objects"];
		_objects = [];
		while { (count _objects != 1) && (_counter > 0) } do
		{
			Sleep 0.5;
			_objects = nearestObjects [_missionPosition, [_actionObjectClassname], 50];
			_counter = _counter - 1;
		};

		/* Action Menü zu den Objekten hinzufügen */
		{ _x addAction["Sprengladung platzieren", "missionsOpt\building\actionPlaceCharge.sqf"]; } foreach _objects;

		/*----------------------------------------*/
		/* Standart Missions verarbeitung starten */
		/*----------------------------------------*/
		private["_taskTitle"];
		_taskTitle = "Funkturm zerstören";
		private["_taskDescription"];
		_taskDescription = "Der Feind hat einen für uns strategisch wichtigen Funkturm in Einsatzreichweite. Zerstören Sie diesen um jeden Preis";
		
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
	
	private["_building"];
	_building = _buildingClassname createVehicle _missionPosition;
	Sleep .3;
	_building allowDamage false;
	_building setdir _missionDirection;
	_building setPos _missionPosition;
	_building setVectorUp [0,0,1];
	_buildings = _buildings + [_building];


	private["_actionBuilding"];
	_actionBuilding = _actionObjectClassname createVehicle _missionPosition;
	Sleep .3;
	_actionBuilding allowDamage false;
	_actionBuilding setdir (getDir _building);
	_actionBuilding setPos (getPos _building);
	_actionBuilding setVectorUp [0,0,1];
	//_actionBuilding attachTo [_building, [0,0,0]];
	//_actionBuilding setVectorUp surfaceNormal (position _actionBuilding);
	_buildings = _buildings + [_actionBuilding];
	
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
		[_missionPosition, ["APERSTripMine"]] call PC_fnc_CreateMineFieldAtTarget;
	};

	/*--------------------------------------*/
	/* Warten bis die Mission erfüllt wurde */
	/*--------------------------------------*/
	waitUntil {(!alive _building) || (pixZones_ActiveIndex == -1)};
	
	/*--------------------------------------------------------*/
	/* Status auf beendet setzen und allen Clienten mitteilen */
	/*--------------------------------------------------------*/
	[_missionInfoIndex] call PC_fnc_FinishMissionStatus;

	/*-------------------------------------------------------------------------------------------------------------*/
	/* Warten bis Zone beendet. Dann nocheinmal zufällige Zeitverzögerung, damit nicht alle gleichzeitig aufräumen */
	/*-------------------------------------------------------------------------------------------------------------*/
	waitUntil {pixZones_ActiveIndex == -1 };
	sleep (random 60);
	[_groups, _vehicles, _buildings, true] call PC_fnc_CleanupMission;
};