private["_zoneIndex"];
_zoneIndex = _this select 0;
private["_missionInfoIndex"];
_missionInfoIndex = _this select 1;
private["_vehicleClassname"];
_vehicleClassname = _this select 2;

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
	private["_taskTitle"];
	_taskTitle = format["Fahrzeuge zerstÃ¶ren (%1)", gettext (configFile >> "CfgVehicles" >> _vehicleClassname >> "displayName")];
	private["_taskDescription"];
	_taskDescription = format["Unser Geheimdienst hat eine Fahrzeuggruppe ermittelt. Vernichten sie diese Fahrzeuge (Typ: %1)", gettext (configFile >> "CfgVehicles" >> _vehicleClassname >> "displayName")];
	
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

	/*---------------------*/
	/* Fahrzeuge erstellen */
	/*---------------------*/
	private["_vehicle1"];
	_vehicle1 = _vehicleClassname createVehicle _missionPosition;
	Sleep .2;
	_vehicle1 setdir random 360;
	private["_normal"];
	_normal = surfaceNormal (position _vehicle1);
	_vehicle1 setVectorUp _normal;
	createVehicleCrew _vehicle1;
	_groups = _groups + [group ((crew _vehicle1) select 0)];
	_vehicles = _vehicles + [_vehicle1];

	private["_vehicle2"];
	_vehicle2 = _vehicleClassname createVehicle [_missionPosition select 0, (_missionPosition select 1) + ((random 100) - 50), 0]; 
	Sleep .2;
	_vehicle2 setdir random 360;
	_normal = surfaceNormal (position _vehicle2);
	_vehicle2 setVectorUp _normal;
	createVehicleCrew _vehicle2;
	_groups = _groups + [group ((crew _vehicle2) select 0)];
	_vehicles = _vehicles + [_vehicle2];

	/*----------------------------------------------------------------------------*/
	/* Anzahl der Spieler berechnen um den Schwierigkeitsgrad bestimmen zu können */
	/*----------------------------------------------------------------------------*/
	private["_patrolCount"];
	_patrolCount = ceil((call PC_fnc_GetPlayerCount) / 4);

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

	/*--------------*/
	/* Vorschädigen */
	/*--------------*/
	_vehicle1 setDamage 0.5;
	_vehicle2 setDamage 0.5;

	/*--------------------------------------*/
	/* Warten bis die Mission erfüllt wurde */
	/*--------------------------------------*/
	waitUntil {((!alive _vehicle1) &&(!alive _vehicle2)) || (pixZones_ActiveIndex == -1)};
	
	/*--------------------------------------------------------*/
	/* Status auf beendet setzen und allen Clienten mitteilen */
	/*--------------------------------------------------------*/
	[_missionInfoIndex] call PC_fnc_FinishMissionStatus;

	/*-----------------------*/
	/* Kurze Zeitverzögerung */
	/*-----------------------*/
	waitUntil {pixZones_ActiveIndex == -1 };
	sleep 60;

	/*-------------------------------------------------------------------------------------------------------------*/
	/* Warten bis Zone beendet. Dann nocheinmal zufällige Zeitverzögerung, damit nicht alle gleichzeitig aufräumen */
	/*-------------------------------------------------------------------------------------------------------------*/
	waitUntil {pixZones_ActiveIndex == -1 };
	sleep (random 60);
	[_groups, _vehicles, _buildings, true] call PC_fnc_CleanupMission;
};