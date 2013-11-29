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
	_taskTitle = format["Fahrzeuge zerstören (%1)", gettext (configFile >> "CfgVehicles" >> _vehicleClassname >> "displayName")];
	private["_taskDescription"];
	_taskDescription = format["Unser Geheimdienst hat eine Fahrzeuggruppe ermittelt. Vernichten sie diese Fahrzeuge (Typ: %1)", gettext (configFile >> "CfgVehicles" >> _vehicleClassname >> "displayName")];
	
	private["_tmp"];
	_tmp = [_missionInfoIndex, _missionMarkerPosition, _missionMarkerRadius, _taskTitle, _taskDescription] execVM "missionsOpt\_common\runClient.sqf";	
};

if (isServer) then
{
	private["_units"];
	_units = [];

	private["_vehicle1"];
	_vehicle1 = _vehicleClassname createVehicle _missionPosition;
	Sleep .2;
	_vehicle1 lock true;
	_vehicle1 setdir random 360;
	_normal = surfaceNormal (position _vehicle1);
	_vehicle1 setVectorUp _normal;
	createVehicleCrew _vehicle1;
	_units = _units + (crew _vehicle1);

	private["_vehicle2"];
	_vehicle2 = _vehicleClassname createVehicle [_missionPosition select 0, (_missionPosition select 1) + ((random 100) - 50), 0]; 
	Sleep .2;
	_vehicle2 lock true;
	_vehicle2 setdir random 360;
	_normal = surfaceNormal (position _vehicle2);
	_vehicle2 setVectorUp _normal;
	createVehicleCrew _vehicle2;
	_units = _units + (crew _vehicle2);

	private["_vehicle3"];
	_vehicle3 = _vehicleClassname createVehicle [(_missionPosition select 0) + ((random 100) - 50), _missionPosition select 1, 0]; 
	Sleep .2;
	_vehicle3 lock true;
	_vehicle3 setdir random 360;
	_normal = surfaceNormal (position _vehicle3);
	_vehicle3 setVectorUp _normal;
	createVehicleCrew _vehicle3;
	_units = _units + (crew _vehicle3);
	

	private["_spawnGroup"];
	private["_randomPos"];
	private["_random"];
	_random = floor (random 3) + 1;
	for "_i" from 0 to _random do 
	{
		_randomPos = [[[_missionPosition, random 400 + 250]],["water","out"]] call BIS_fnc_randomPos;
		private["_spawnGroup"];
		_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
		nul = [_spawnGroup, _missionPosition, random 600 + 300] call fn_missionsOpt_Patrol;
		_units = _units + (units _spawnGroup);
		 [_spawnGroup] call fn_missionsOpt_SetSkill;
	};

	_random = floor (random 2) + 1;
	for "_i" from 0 to _random do 	
	{
		_randomPos = [[[_missionPosition,random 150]],["water","out"]] call BIS_fnc_randomPos;
		_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
		[_spawnGroup, _missionPosition] call BIS_fnc_taskDefend;
		_units = _units + (units _spawnGroup);
		 [_spawnGroup] call fn_missionsOpt_SetSkill;
	};

	_vehicle1 setDamage 0.5;
	_vehicle2 setDamage 0.5;
	_vehicle3 setDamage 0.5;
	if (_vehicle1 distance [0,0,0] < 1000) then { _vehicle1 setDamage 1;};
	if (_vehicle2 distance [0,0,0] < 1000) then { _vehicle2 setDamage 1;};
	if (_vehicle3 distance [0,0,0] < 1000) then { _vehicle3 setDamage 1;};

	/*--------------------------------------*/
	/* Warten bis die Mission erfüllt wurde */
	/*--------------------------------------*/
	waitUntil {((!alive _vehicle1) &&(!alive _vehicle2) &&(!alive _vehicle3)) || (pixZones_ActiveIndex == -1)};
	
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

	/*-------------------------------------------------------*/
	/* Bewegungsunfähige Fahrzeuge in die Logistic aufnehmen */
	/*-------------------------------------------------------*/
	if (!canMove _vehicle1) then 
	{
		private["_script"];
		_script = [_vehicle1] execVM "pixLogistic\serverInsertItem.sqf";
		waitUntil { scriptDone _script;};
		_vehicle1 = nil;
	};
	if (!canMove _vehicle2) then 
	{
		private["_script"];
		_script = [_vehicle2] execVM "pixLogistic\serverInsertItem.sqf";
		waitUntil { scriptDone _script;};
		_vehicle2 = nil;
	};
	if (!canMove _vehicle3) then 
	{
		private["_script"];
		_script = [_vehicle3] execVM "pixLogistic\serverInsertItem.sqf";
		waitUntil { scriptDone _script;};
		_vehicle3 = nil;
	};

	/*-----------------------*/
	/* Kurze Zeitverzögerung */
	/*-----------------------*/
	sleep 60;

	/*------------------------*/
	/* Alle Einheiten löschen */
	/*------------------------*/
	if (!(isNil "_vehicle1")) then {deletevehicle _vehicle1;};
	if (!(isNil "_vehicle2")) then {deletevehicle _vehicle2;};
	if (!(isNil "_vehicle3")) then {deletevehicle _vehicle3;};
	{deletevehicle _x} foreach _units;
};