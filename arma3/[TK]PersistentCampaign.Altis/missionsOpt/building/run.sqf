private["_zoneIndex"];
_zoneIndex = _this select 0;
private["_missionInfoIndex"];
_missionInfoIndex = _this select 1;
private["_buildingClassname"];
_buildingClassname = _this select 2;

/*----------------------------------*/
/* Die Missionsdaten herausarbeiten */
/*----------------------------------*/
private["_missionOpt"]; /* [missionIndex, missionPosition, missionStatus] */
_missionOpt = ((pvehPixZones_MissionInfos select 2) select _missionInfoIndex);
private["_missionPosition"];
_missionPosition = _missionOpt select 1;

/*---------------------------------------*/
/* Wenn notwendig die Clientside starten */
/*---------------------------------------*/
if (!isServer || !isDedicated) then
{
	private["_tmp"];
	_tmp = [_missionInfoIndex, _missionPosition, _buildingClassname] execVM "missionsOpt\building\runClient.sqf";	
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
	private["_random"];
	_random = floor (random 3) + 1;
	for "_i" from 0 to _random do 
	{
		_randomPos = [[[_missionPosition, random 600 + 300]],["water","out"]] call BIS_fnc_randomPos;
		private["_spawnGroup"];
		_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
		nul = [_spawnGroup, _missionPosition, random 600 + 300] call fn_missionsOpt_Patrol;
		_units = _units + (units _spawnGroup);
		 [_spawnGroup] call fn_missionsOpt_SetSkill;
	};

	_random = floor (random 2) + 1;
	for "_i" from 0 to _random do 	
	{
		_randomPos = [[[_missionPosition, random 100]],["water","out"]] call BIS_fnc_randomPos;
		_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
		[_spawnGroup, _missionPosition] call BIS_fnc_taskDefend;
		_units = _units + (units _spawnGroup);
		 [_spawnGroup] call fn_missionsOpt_SetSkill;
	};
	
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
		pvehPixZones_MissionStatus set [_missionInfoIndex, 1]; /* erfolgreich */	
	}
	else
	{	
		pvehPixZones_MissionStatus set [_missionInfoIndex, 2]; /* Fehlgeschlagen */
	};
	publicVariable "pvehPixZones_MissionStatus";
	if (!isDedicated) then { call compile preprocessFileLineNumbers "pixZones\pvehPixZones_MissionStatus.sqf"; }; /* PublicVariableEventHandler simulieren */

	/*-----------------------*/
	/* Kurze Zeitverzögerung */
	/*-----------------------*/
	if (pixDebug) then
	{
		sleep 60;
	}
	else
	{
		sleep 10;
	};

	/*------------------------*/
	/* Alle Einheiten löschen */
	/*------------------------*/
	{deletevehicle _x} foreach _units;
};