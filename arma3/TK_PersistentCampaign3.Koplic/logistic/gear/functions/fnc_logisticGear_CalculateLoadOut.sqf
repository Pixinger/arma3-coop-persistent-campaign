// _this select 0: _loadout filename
params ["_loadout"];

/* Loadout abfragen */
private["_result"];
_result = [] call compile preprocessFileLineNumbers format["logistic\gear\%1\%2", cfgLogisticGear_LoadoutFolder, _loadout];

//---------------------------------------------------------------
private _totalMass = 0;

//---------------------------------------------------------------
private["_goggleClassname"];
_goggleClassname = _result select 0;

if (_goggleClassname != "") then { _totalMass = _totalMass + ([(configfile >> "CfgGlasses" >> _goggleClassname),"mass",0] call BIS_fnc_returnConfigEntry);};

//---------------------------------------------------------------
private["_headgearClassname"];
_headgearClassname = _result select 1;

if (_headgearClassname != "") then { _totalMass = _totalMass + ([(configfile >> "CfgWeapons" >> _headgearClassname >> "ItemInfo"),"mass",0] call BIS_fnc_returnConfigEntry);};

//---------------------------------------------------------------
private["_binocularClassname"];
_binocularClassname = _result select 2;

if (_binocularClassname != "") then { _totalMass = _totalMass + ([(configfile >> "CfgWeapons" >> _binocularClassname >> "WeaponSlotsInfo"),"mass",0] call BIS_fnc_returnConfigEntry);};

//---------------------------------------------------------------
private["_nightVisionClassname"];
_nightVisionClassname = _result select 3;

if (_nightVisionClassname != "") then { _totalMass = _totalMass + ([(configfile >> "CfgWeapons" >> _nightVisionClassname >> "ItemInfo"),"mass",0] call BIS_fnc_returnConfigEntry);};

//---------------------------------------------------------------
private["_linkedItems"];
_linkedItems = _result select 4;

{
	if (_x != "") then { _totalMass = _totalMass + ([(configfile >> "CfgWeapons" >> _x >> "ItemInfo"),"mass",0] call BIS_fnc_returnConfigEntry);};
} foreach _linkedItems;

//---------------------------------------------------------------
private["_primaryWeapon"];
_primaryWeapon = _result select 5;
private["_primaryWeaponClassname"];
_primaryWeaponClassname = _primaryWeapon select 0;
private["_primaryWeaponMagazine"];
_primaryWeaponMagazine = _primaryWeapon select 1;
private["_primaryWeaponItems"];
_primaryWeaponItems = _primaryWeapon select 2;

if (_primaryWeaponClassname != "") then { _totalMass = _totalMass + ([(configfile >> "CfgWeapons" >> _primaryWeaponClassname >> "WeaponSlotsInfo"),"mass",0] call BIS_fnc_returnConfigEntry);};
if (_primaryWeaponMagazine != "") then { _totalMass = _totalMass + ([(configfile >> "CfgMagazines" >> _primaryWeaponMagazine),"mass",0] call BIS_fnc_returnConfigEntry);};
{
	if (_x != "") then { _totalMass = _totalMass + ([(configfile >> "CfgWeapons" >> _x >> "ItemInfo"),"mass",0] call BIS_fnc_returnConfigEntry);};
} foreach _primaryWeaponItems;

//---------------------------------------------------------------
private["_secondaryWeapon"];
_secondaryWeapon = _result select 6;
private["_secondaryWeaponClassname"];
_secondaryWeaponClassname = _secondaryWeapon select 0;
private["_secondaryWeaponMagazine"];
_secondaryWeaponMagazine = _secondaryWeapon select 1;
private["_secondaryWeaponItems"];
_secondaryWeaponItems = _secondaryWeapon select 2;

if (_secondaryWeaponClassname != "") then { _totalMass = _totalMass + ([(configfile >> "CfgWeapons" >> _secondaryWeaponClassname >> "WeaponSlotsInfo"),"mass",0] call BIS_fnc_returnConfigEntry);};
if (_secondaryWeaponMagazine != "") then { _totalMass = _totalMass + ([(configfile >> "CfgMagazines" >> _secondaryWeaponMagazine),"mass",0] call BIS_fnc_returnConfigEntry);};
{
	if (_x != "") then { _totalMass = _totalMass + ([(configfile >> "CfgWeapons" >> _x >> "ItemInfo"),"mass",0] call BIS_fnc_returnConfigEntry);};
} foreach _secondaryWeaponItems;

//---------------------------------------------------------------
private["_handgun"];
 _handgun = _result select 7;
private["_handgunClassname"];
_handgunClassname = _handgun select 0;
private["_handgunMagazine"];
_handgunMagazine = _handgun select 1;
private["_handgunItems"];
_handgunItems = _handgun select 2;

if (_handgunClassname != "") then { _totalMass = _totalMass + ([(configfile >> "CfgWeapons" >> _handgunClassname >> "WeaponSlotsInfo"),"mass",0] call BIS_fnc_returnConfigEntry);};
if (_handgunMagazine != "") then { _totalMass = _totalMass + ([(configfile >> "CfgMagazines" >> _handgunMagazine),"mass",0] call BIS_fnc_returnConfigEntry);};
{
	if (_x != "") then { _totalMass = _totalMass + ([(configfile >> "CfgWeapons" >> _x >> "ItemInfo"),"mass",0] call BIS_fnc_returnConfigEntry);};
} foreach _handgunItems;

//---------------------------------------------------------------
private["_uniform"];
_uniform = _result select 8;
private["_uniformClassname"];
_uniformClassname = _uniform select 0;
private["_uniformWeapons"];
_uniformWeapons = _uniform select 1;
private["_uniformMagazines"];
_uniformMagazines = _uniform select 2;
private["_uniformItems"];
_uniformItems = _uniform select 3;

if (_uniformClassname != "") then { _totalMass = _totalMass + ([(configfile >> "CfgWeapons" >> _uniformClassname >> "ItemInfo"),"mass",0] call BIS_fnc_returnConfigEntry);};
{
	if (_x != "") then { _totalMass = _totalMass + ([(configfile >> "CfgWeapons" >> _x >> "WeaponSlotsInfo"),"mass",0] call BIS_fnc_returnConfigEntry);};
} foreach _uniformWeapons;
{
	if (_x != "") then { _totalMass = _totalMass + ([(configfile >> "CfgMagazines" >> _x),"mass",0] call BIS_fnc_returnConfigEntry);};
} foreach _uniformMagazines;
{
	if (_x != "") then { _totalMass = _totalMass + ([(configfile >> "CfgWeapons" >> _x >> "ItemInfo"),"mass",0] call BIS_fnc_returnConfigEntry);};
} foreach _uniformItems;

//---------------------------------------------------------------
private["_vest"];
_vest = _result select 9;
private["_vestClassname"];
_vestClassname = _vest select 0;
private["_vestWeapons"];
_vestWeapons = _vest select 1;
private["_vestMagazines"];
_vestMagazines = _vest select 2;
private["_vestItems"];
_vestItems = _vest select 3;

if (_vestClassname != "") then { _totalMass = _totalMass + ([(configfile >> "CfgWeapons" >> _vestClassname >> "ItemInfo"),"mass",0] call BIS_fnc_returnConfigEntry);};
{
	if (_x != "") then { _totalMass = _totalMass + ([(configfile >> "CfgWeapons" >> _x >> "WeaponSlotsInfo"),"mass",0] call BIS_fnc_returnConfigEntry);};
} foreach _vestWeapons;
{
	if (_x != "") then { _totalMass = _totalMass + ([(configfile >> "CfgMagazines" >> _x),"mass",0] call BIS_fnc_returnConfigEntry);};
} foreach _vestMagazines;
{
	if (_x != "") then { _totalMass = _totalMass + ([(configfile >> "CfgWeapons" >> _x >> "ItemInfo"),"mass",0] call BIS_fnc_returnConfigEntry);};
} foreach _vestItems;


//---------------------------------------------------------------
private["_backpack"];
_backpack = _result select 10;
private["_backpackClassname"];
_backpackClassname = _backpack select 0;
private["_backpackWeapons"];
_backpackWeapons = _backpack select 1;
private["_backpackMagazines"];
_backpackMagazines = _backpack select 2;
private["_backpackItems"];
_backpackItems = _backpack select 3;

if (_backpackClassname != "") then { _totalMass = _totalMass + ([(configfile >> "CfgVehicles" >> _backpackClassname),"mass",0] call BIS_fnc_returnConfigEntry);};
{
	if (_x != "") then { _totalMass = _totalMass + ([(configfile >> "CfgWeapons" >> _x >> "WeaponSlotsInfo"),"mass",0] call BIS_fnc_returnConfigEntry);};
} foreach _backpackWeapons;
{
	if (_x != "") then { _totalMass = _totalMass + ([(configfile >> "CfgMagazines" >> _x),"mass",0] call BIS_fnc_returnConfigEntry);};
} foreach _backpackMagazines;
{
	if (_x != "") then { _totalMass = _totalMass + ([(configfile >> "CfgWeapons" >> _x >> "ItemInfo"),"mass",0] call BIS_fnc_returnConfigEntry);};	
} foreach _backpackItems;

if (pixDebug) then { diag_log format["_totalMass for _loadout '%1' = %2",_loadout, _totalMass];
_totalMass;