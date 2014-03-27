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
_missionDirection = _missionOpt select 2; /* Wird hier verwendet um den Fahrzeug Typen zu bestimmen */
private["_missionMarkerPosition"];
_missionMarkerPosition = _missionOpt select 3;
private["_missionMarkerRadius"];
_missionMarkerRadius = _missionOpt select 4;

/*---------------------------*/
/* Building Typen definieren */
/*---------------------------*/
private["_buildingClassnames"];
_buildingClassnames = ["O_APC_Wheeled_02_rcws_F", "O_MRAP_02_hmg_F", "O_MRAP_02_gmg_F"];

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
	/*----------------------------------------*/
	/* Standart Missions verarbeitung starten */
	/*----------------------------------------*/
	private["_taskTitle"];
	_taskTitle = format["Fahrzeug untersuchen (%1?)", gettext (configFile >> "CfgVehicles" >> _buildingClassname >> "displayName")];
	private["_taskDescription"];
	_taskDescription = format["Unser Geheimdienst hat ein Fahrzeug ermittelt in dem ein neues technisches Gerät verbaut ist. Bringen sie das Fahrzeug aus dem feindlichen Sektor, damit wir es genauer untersuchen können (Typ: %1?).", gettext (configFile >> "CfgVehicles" >> _buildingClassname >> "displayName")];
	
	private["_tmp"];
	_tmp = [_missionInfoIndex, _missionMarkerPosition, _missionMarkerRadius, _taskTitle, _taskDescription] execVM "missionsOpt\_common\runClient.sqf";	
};

if (isServer) then
{
	private["_groups"];
	_groups = [];
	private["_vehicles"];
	_vehicles = [];
	private["_buildings"];
	_buildings = [];
	
	/*--------------------*/
	/* Fahrzeug erstellen */
	/*--------------------*/
	private["_vehicle"];
	_vehicle = _buildingClassname createVehicle _missionPosition;
	_vehicle setdir (random 360);
	private["_normal"];
	_normal = surfaceNormal (position _vehicle);
	_vehicle setVectorUp _normal;
	_vehicles = _vehicles + [_vehicle];

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
	_mineFieldCount = 1 +  floor(random 3);
	for "_i" from 0 to _mineFieldCount do 
	{
		[_missionPosition, ["APERSTripMine"]] call PC_fnc_CreateMineFieldAtTarget;
	};

	/*--------------------------------------*/
	/* Warten bis die Mission erfüllt wurde */
	/*--------------------------------------*/
	private["_continue"];
	_continue = true;
	while { _continue } do
	{
		if (pixZones_ActiveIndex == -1) then { _continue = false; };
		if (!([_zoneIndex, getPos _vehicle] call PC_fnc_IsPositionInZone)) then { _continue = false; };
		Sleep 5;
	};
		
	/*--------------------------------------------------------*/
	/* Status auf beendet setzen und allen Clienten mitteilen */
	/*--------------------------------------------------------*/
	/*[_missionInfoIndex] call PC_fnc_FinishMissionStatus;*/
	if (pixZones_ActiveIndex == -1) then
	{
		(pvehPixZones_MissionStatus select 1) set [_missionInfoIndex, 2]; /* Fehlgeschlagen */
	}
	else
	{
		(pvehPixZones_MissionStatus select 1) set [_missionInfoIndex, 1]; /* erfolgreich */	
	};
	publicVariable "pvehPixZones_MissionStatus";
	if (!isDedicated) then { call compile preprocessFileLineNumbers "pixZones\pvehPixZones_MissionStatus.sqf"; }; /* PublicVariableEventHandler simulieren */

	/*-------------------------------------------------------------------------------------------------------------*/
	/* Warten bis Zone beendet. Dann nocheinmal zufällige Zeitverzögerung, damit nicht alle gleichzeitig aufräumen */
	/*-------------------------------------------------------------------------------------------------------------*/
	waitUntil {pixZones_ActiveIndex == -1 };
	sleep (random 60);
	[_groups, _vehicles, _buildings, true] call PC_fnc_CleanupMission;
};