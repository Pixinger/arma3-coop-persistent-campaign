/* 
	Based on the function from: Joris-Jan van 't Land, modified by Thomas Ryan
	Diese Funktion erstellt eine feindliche AI Gruppe.
	
Parameter:
	_cfgGroupNames:	Ein Array das die CfgGroups-Namen enthält, die zur Erstellung diese AI-Gruppe verwendet werden können (aus der Config). 					
	position:		Die Position an der die Grupper erstellt werden soll.	
	
Return: 
	GroupInfo Array: [group, vehicles]
	If failed: []
/*-------------------------------------------------------------------*/
if (!isServer) exitWith {[]};

private["_cfgGroupNames"];
_cfgGroupNames = [_this, 0, [], [[]]] call BIS_fnc_param;
if (count _cfgGroupNames == 0) exitwith {["Empty _cfgGroupNames parameter"] call BIS_fnc_error; []};

private["_position"];
_position = [_this, 1, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
if (str(_position) == "[0,0,0]") exitwith {["Empty _position parameter"] call BIS_fnc_error; []};

/*-------------------------------------------------------------------*/

/* Zufällig einen Eintrag wählen */
private["_cfgGroupName"];
_cfgGroupName = _cfgGroupNames select (floor random (count _cfgGroupNames));

/* Den dazugehörigen Config Eintrag herausarbeiten */
scopeName "main";
private["_cfgGroup"];
private["_gci"]; /* GroupCategoryIndex */
for "_gci" from 1 to (count (configfile >> "CfgGroups" >> "East" >> "OPF_F") - 1) do
{
	private["_groupCategory"];
	_groupCategory = ((configfile >> "CfgGroups" >> "East" >> "OPF_F") select _gci);
	private["_gni"]; /* GroupNameIndex */
	for "_gni" from 1 to ((count _groupCategory) - 1) do
	{
		private["_groupName"];
		_groupName = _groupCategory select _gni;
		if (_cfgGroupName == configName _groupName) then { _cfgGroup = _groupName; breakTo "main";};
	};
};

/* Prüfen ob etwas gefunden wurde */
if (isNil "_cfgGroup") exitWith {["Unable to find in _cfgGroupNames-Parameter specified cfgGroupName: %1 / %2", _cfgGroupName, _cfgGroupNames] call BIS_fnc_error; []};

/* Convert a CfgGroups entry to types, positions and ranks. */
private ["_types"];
_types = [];
private ["_ranks"];
_ranks = [];	
for "_i" from 0 to ((count _cfgGroup) - 1) do 
{
	private ["_item"];
	_item = _cfgGroup select _i;
	
	if (isClass _item) then 
	{
		_types = _types + [getText(_item >> "vehicle")];
		_ranks = _ranks + [getText(_item >> "rank")];
	};
};

/* Zufällige Richtung berechnen */
private["_azimuth"];
_azimuth = random 360;

private["_vehicles"];
_vehicles = [];
private ["_tmpGroup"];
_tmpGroup = createGroup east;

/* Create the units according to the selected types. */
for "_i" from 0 to ((count _types) - 1) do
{
	private["_unit"];
	private["_type"];
	_type = _types select _i;
		
	/* Is this a character or vehicle? */
	if (getNumber(configFile >> "CfgVehicles" >> _type >> "isMan") == 1) then 
	{	
		private["_freePosition"];
		_freePosition = _position findEmptyPosition [0, 100, _type];
		if (count _freePosition > 0) then
		{
			_unit = _tmpGroup createUnit [_type, _position, [], 0, "FORM"];
			_unit setDir _azimuth;
		};
	} 
	else 
	{
		private["_freePosition"];
		_freePosition = _position findEmptyPosition [0, 100, _type];
		if (count _freePosition > 0) then
		{
			private["_vehicleResult"];
			_vehicleResult = [_freePosition, _azimuth, _type, _tmpGroup] call BIS_fnc_spawnVehicle;
			_unit = _vehicleResult select 0; /* Das eigentliche Vehicle. Es wird hier als unit gesetzt, damit die unten stehende Rank zuweisung funktioniert. */
			_vehicles = _vehicles + [_unit]; 
		};
	};
		
	/* If given, set the unit's rank. */
	if ((count _ranks) > 0) then 
	{
		[_unit,_ranks select _i] call bis_fnc_setRank;
	};		
	_unit = nil;
};

/* Sort group members by ranks (the same as 2D editor does it) */
private ["_group"];
_group = createGroup east;
while {count units _tmpGroup > 0} do 
{
	private ["_maxRank"];
	_maxRank = -1;
	private["_unit"];
	_unit = objnull;
	{
		_rank = rankid _x;
		if (_rank > _maxRank) then {_maxRank = _rank; _unit = _x;};
	} foreach units _tmpGroup;
	[_unit] joinsilent _group;
};
_group selectleader (units _group select 0);
deletegroup _tmpGroup;

[_group] call PC_fnc_SetSkill;

_group allowFleeing 0;

private["_result"];
_result = [_group, _vehicles];
_result