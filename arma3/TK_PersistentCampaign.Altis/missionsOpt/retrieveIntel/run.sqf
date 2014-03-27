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
_missionDirection = _missionOpt select 2;
private["_missionMarkerPosition"];
_missionMarkerPosition = _missionOpt select 3;
private["_missionMarkerRadius"];
_missionMarkerRadius = _missionOpt select 4;

/*---------------------------------------*/
/* Wenn notwendig die Clientside starten */
/*---------------------------------------*/
if (!isServer || !isDedicated) then
{
	[] spawn {
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
			_objects = nearestObjects [_missionPosition, ["Land_Suitcase_F"], 50];
			_counter = _counter - 1;
		};
		
		/* Action Menü zu den Objekten hinzufügen */
		{ _x addAction["Dokumente sicherstellen", "missionsOpt\_common\actionSecure.sqf"]; } foreach _objects;

		/*----------------------------------------*/
		/* Standart Missions verarbeitung starten */
		/*----------------------------------------*/
		private["_taskTitle"];
		_taskTitle = "Geheime Dokumente sicherstellen";
		private["_taskDescription"];
		_taskDescription = "Einer unserer Hubschrauber wurde abgeschossen und vom Feind gesichert. Leider befanden sich geheime Dokumente im Hubschrauber. Diese müssen von uns umgehend gesichert werden. Beginnen Sie mit der Suche an der Absturztstelle.";
		
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
	
	/*---------------------------*/
	/* Wrack und Intel erstellen */
	/*---------------------------*/
	private["_vehicle"];
	_vehicle = "Land_Wreck_Heli_Attack_01_F" createVehicle _missionPosition;
	private["_intel"];
	_intel = "Land_Suitcase_F" createVehicle _missionPosition;
	_vehicle setVectorUp  surfaceNormal (position _vehicle);
	_buildings = _buildings + [_vehicle];
	_buildings = _buildings + [_intel];

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
	_mineFieldCount = 1 + floor(random 2);
	for "_i" from 0 to _mineFieldCount do 
	{
		[_missionPosition, ["APERSMine"]] call PC_fnc_CreateMineFieldAtTarget;
	};

	/*--------------------------------------*/
	/* Warten bis die Mission erfüllt wurde */
	/*--------------------------------------*/
	waitUntil {(!alive _intel) || (pixZones_ActiveIndex == -1)};
	
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