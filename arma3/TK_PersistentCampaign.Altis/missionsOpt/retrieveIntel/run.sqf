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
	private["_taskTitle"];
	_taskTitle = "Geheime Dokumente vernichten";
	private["_taskDescription"];
	_taskDescription = "Einer unserer Hubschrauber wurde abgeschossen und vom Feind gesichert. Leider befanden sich geheime Dokumente im Hubschrauber. Diese mÃ¼ssen von uns umgehend vernichtet werden. Beginnen Sie mit der Suche an der Absturztstelle.";
	
	private["_tmp"];
	_tmp = [_missionInfoIndex, _missionMarkerPosition, _missionMarkerRadius, _taskTitle, _taskDescription] execVM "missionsOpt\_common\runClient.sqf";	
};

if (isServer) then
{
	private["_units"];
	_units = [];
	
	private["_vehicle"];
	_vehicle = "Land_Wreck_Heli_Attack_01_F" createVehicle _missionPosition;
	private["_intel"];
	_intel = "Land_Suitcase_F" createVehicle _missionPosition;
	_vehicle setVectorUp  surfaceNormal (position _vehicle);
	_units = _units + [_vehicle, _intel];	

	private["_spawnGroup"];
	private["_randomPos"];
	/* Anzahl der Spieler berechnen um den Schwierigkeitsgrad bestimmen zu können */
	private["_currentPlayerCount"];
	_currentPlayerCount = 10;
	if (isDedicated) then { _currentPlayerCount = count playableUnits;};
	private["_patrolCount"];
	_patrolCount = ceil(_currentPlayerCount / 4);
	for "_i" from 0 to _patrolCount do 
	{
		private["_teamTypes"];
		_teamTypes = ["OIA_InfSquad","OIA_InfTeam","OIA_InfTeam_AT","OIA_MotInfTeam","OIA_MotInf_AT"];
		_randomPos = [[[_missionPosition, random 600]],["water","out"]] call BIS_fnc_randomPos;
		_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> (_teamTypes select floor(random(count _teamTypes))))] call BIS_fnc_spawnGroup;
		private["_tmp"];
		_tmp = [_spawnGroup, _missionPosition, random 600] call fn_missionsOpt_Patrol;
		_units = _units + (units _spawnGroup);
		 [_spawnGroup] call fn_missionsOpt_SetSkill;
		/* Nur im Debug */
		if (isServer && !isDedicated) then { [_spawnGroup] spawn fn_missionsRev_TrackGroup;};
	};

	/* Verteidigungs Truppe */
	private["_teamTypes"];
	_teamTypes = ["OIA_InfSquad","OIA_InfTeam","OIA_InfTeam_AT","OIA_MotInfTeam","OIA_MotInf_AT","OIA_InfSentry"];				
	_randomPos = [[[_missionPosition, random 80]],["water","out"]] call BIS_fnc_randomPos;	
	_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> (_teamTypes select floor(random(count _teamTypes)))] call BIS_fnc_spawnGroup;
	[_spawnGroup, _missionPosition] call BIS_fnc_taskDefend;
	_units = _units + (units _spawnGroup);
	 [_spawnGroup] call fn_missionsOpt_SetSkill;
	/* Nur im Debug */
	if (isServer && !isDedicated) then { [_spawnGroup] spawn fn_missionsRev_TrackGroup;};
	
	_intel setDamage 0.9;
	if (_intel distance [0,0,0] < 1000) then { _intel setDamage 1;};
	
	/*--------------------------------------*/
	/* Warten bis die Mission erfüllt wurde */
	/*--------------------------------------*/
	waitUntil {(!alive _intel) || (pixZones_ActiveIndex == -1)};
	
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