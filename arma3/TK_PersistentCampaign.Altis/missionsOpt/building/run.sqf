private["_zoneIndex"];
_zoneIndex = _this select 0;
private["_missionInfoIndex"];
_missionInfoIndex = _this select 1;
private["_buildingClassname"];
_buildingClassname = _this select 2;

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
	_taskTitle = format["Gebäude zerstören (%1)", gettext (configFile >> "CfgVehicles" >> _buildingClassname >> "displayName")];
	private["_taskDescription"];
	_taskDescription = format["Der Feind hat ein für uns strategisch wichtiges Gebäude in Einsatzreichweite. Zerstören Sie dieses Gebäude um jeden Preis. (Typ: %1)", gettext (configFile >> "CfgVehicles" >> _buildingClassname >> "displayName")];
	
	private["_tmp"];
	_tmp = [_missionInfoIndex, _missionMarkerPosition, _missionMarkerRadius, _taskTitle, _taskDescription] execVM "missionsOpt\_common\runClient.sqf";	
};

if (isServer) then
{
	private["_units"];
	_units = [];
	
	private["_building"];
	_building = _buildingClassname createVehicle _missionPosition;
	_building setdir random 360;
	_building setVectorUp surfaceNormal (position _building);
	_units = _units + [_building];

	private["_spawnGroup"];
	private["_randomPos"];
	/* Anzahl der Spieler berechnen um den Schwierigkeitsgrad bestimmen zu können */
	private["_currentPlayerCount"];
	_currentPlayerCount = call PC_fnc_GetPlayerCount;
	private["_patrolCount"];
	_patrolCount = ceil(_currentPlayerCount / 4);
	for "_i" from 0 to _patrolCount do 
	{
		private["_teamTypes"];
		_teamTypes = ["OIA_InfSquad","OIA_InfTeam","OIA_InfTeam_AT","OIA_MotInfTeam","OIA_MotInf_AT"];
		_randomPos = [[[_missionPosition, random 600]],["water","out"]] call BIS_fnc_randomPos;
		_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> (_teamTypes select floor(random(count _teamTypes))))] call BIS_fnc_spawnGroup;
		private["_tmp"];
		_tmp = [_spawnGroup, _zoneIndex, _missionPosition, random 500] call PC_fnc_PatrolObject;
		_units = _units + (units _spawnGroup);
		/* Nur im Debug */
		if (isServer && !isDedicated) then { [_spawnGroup, true, "ColorRed","optBuildingP"] spawn fn_missionsRev_TrackGroup;};
	};

	/* Verteidigungs Truppe */
	private["_teamTypes"];
	_teamTypes = ["OIA_InfSquad","OIA_InfTeam","OIA_InfTeam_AT","OIA_MotInfTeam","OIA_MotInf_AT","OIA_InfSentry"];				
	_randomPos = [[[_missionPosition, random 80]],["water","out"]] call BIS_fnc_randomPos;	
	_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> (_teamTypes select floor(random(count _teamTypes))))] call BIS_fnc_spawnGroup;
	[_spawnGroup, _missionPosition] call PC_fnc_GuardObject;
	_units = _units + (units _spawnGroup);
	/* Nur im Debug */
	if (isServer && !isDedicated) then { [_spawnGroup, true, "ColorRed","optBuildingD"] spawn fn_missionsRev_TrackGroup;};
	
	_building setDamage 0.5;
	if (_building distance [0,0,0] < 1000) then { _building setDamage 1;};
	
	/*--------------------------------------*/
	/* Warten bis die Mission erfüllt wurde */
	/*--------------------------------------*/
	waitUntil {(!alive _building) || (pixZones_ActiveIndex == -1)};
	
	/*--------------------------------------------------------*/
	/* Status auf beendet setzen und allen Clienten mitteilen */
	/*--------------------------------------------------------*/
	if (pixZones_ActiveIndex != -1) then
	{
		(pvehPixZones_MissionStatus select 1) set [_missionInfoIndex, 1]; /* erfolgreich */	
	}
	else
	{	
		(pvehPixZones_MissionStatus select 1) set [_missionInfoIndex, 2]; /* Fehlgeschlagen */
	};
	publicVariable "pvehPixZones_MissionStatus";
	if (!isDedicated) then { call compile preprocessFileLineNumbers "pixZones\pvehPixZones_MissionStatus.sqf"; }; /* PublicVariableEventHandler simulieren */

	/*-----------------------*/
	/* Kurze Zeitverzögerung */
	/*-----------------------*/
	waitUntil {pixZones_ActiveIndex == -1 };
	sleep 60;

	/*------------------------*/
	/* Alle Einheiten löschen */
	/*------------------------*/
	{deletevehicle _x} foreach _units;
};