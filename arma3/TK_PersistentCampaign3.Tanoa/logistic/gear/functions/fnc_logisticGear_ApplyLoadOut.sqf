/* _this parameter abfragen */
private _unit = _this select 0;
private _loadout = _this select 1;
private _directory = _this select 2;

diag_log format["Directory: %1", _directory];

/* Loadout abfragen */
private["_result"];
_result = [] call compile preprocessFileLineNumbers format["logistic\gear\%1\%2", _directory, _loadout];

/* Result lesbar machen */
private["_goggleClassname"];
_goggleClassname = _result select 0;

private["_headgearClassname"];
_headgearClassname = _result select 1;

private["_binocularClassname"];
_binocularClassname = _result select 2;

private["_nightVisionClassname"];
_nightVisionClassname = _result select 3;

private["_linkedItems"];
_linkedItems = _result select 4;

private["_uniform"];
_uniform = _result select 5;
private["_uniformClassname"];
_uniformClassname = _uniform select 0;
private["_uniformWeapons"];
_uniformWeapons = _uniform select 1;
private["_uniformMagazines"];
_uniformMagazines = _uniform select 2;
private["_uniformItems"];
_uniformItems = _uniform select 3;

private["_vest"];
_vest = _result select 6;
private["_vestClassname"];
_vestClassname = _vest select 0;
private["_vestWeapons"];
_vestWeapons = _vest select 1;
private["_vestMagazines"];
_vestMagazines = _vest select 2;
private["_vestItems"];
_vestItems = _vest select 3;

private["_handgun"];
 _handgun = _result select 7;
private["_handgunClassname"];
_handgunClassname = _handgun select 0;
private["_handgunMagazine"];
_handgunMagazine = _handgun select 1;
private["_handgunItems"];
_handgunItems = _handgun select 2;

private["_primaryWeapon"];
_primaryWeapon = _result select 8;
private["_primaryWeaponClassname"];
_primaryWeaponClassname = _primaryWeapon select 0;
private["_primaryWeaponMagazine"];
_primaryWeaponMagazine = _primaryWeapon select 1;
private["_primaryWeaponItems"];
_primaryWeaponItems = _primaryWeapon select 2;

private["_secondaryWeapon"];
_secondaryWeapon = _result select 9;
private["_secondaryWeaponClassname"];
_secondaryWeaponClassname = _secondaryWeapon select 0;
private["_secondaryWeaponMagazine"];
_secondaryWeaponMagazine = _secondaryWeapon select 1;
private["_secondaryWeaponItems"];
_secondaryWeaponItems = _secondaryWeapon select 2;

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

private["_code"];
if (count _result > 11) then { _code = _result select 11; } else { _code = ""; };

private["_unitTypes"];
if (count _result > 12) then { _unitTypes = _result select 12; } else { _unitTypes = []; };

/* Funkgerät retten */
private _rescuedRadio = "";
{
	if (_x isKindOf ["ItemRadio", configFile >> "CfgWeapons"]) exitWith { _rescuedRadio = _x; };
} foreach (assignedItems player);

/* Aktuelle Ausrüstung löschen */
removeAllAssignedItems _unit;
removeAllPrimaryWeaponItems _unit;
removeAllHandgunItems _unit;
removeAllWeapons _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;
removeUniform _unit;
removeGoggles _unit;

/* Erstmal Klamotten anziehen, damit Platz zum befüllen ist */
if (_uniformClassname != "") then {	_unit addUniform _uniformClassname;};
if (_vestClassname != "") then { _unit addVest _vestClassname;};

/*Nun den Werfer hinzufügen da die Munition sonst verlorgen geht. Incl. Dummy Rucksack der wieder gelöscht wird.*/
if (_secondaryWeaponClassname != "") then
{
	if (_secondaryWeaponMagazine != "") then { _unit addBackpack "B_AssaultPack_rgr"; _unit addItemToBackpack _secondaryWeaponMagazine; };
	_unit addWeapon _secondaryWeaponClassname;
	{_unit addSecondaryWeaponItem _x;} foreach _secondaryWeaponItems;
	removeBackpack _unit;
};

/* Nun den echten Rucksack/Fallschrim */
if (_backpackClassname != "") then { _unit addBackpack _backpackClassname;};


/* Munition hinzufügen, sonst ist diese nacher nicht verfügbar */
if (_uniformClassname != "") then
{
	{ _unit addItemToUniform _x; } foreach _uniformWeapons;
	{ _unit addItemToUniform _x; } foreach _uniformMagazines;
	{ 
		if (_x == "ItemRadio") then
		{
			if (_rescuedRadio != "") then {	_unit linkItem _rescuedRadio; } else { _unit addItemToUniform _x; };
		}
		else
		{
			_unit addItemToUniform _x; 
		};
	} foreach _uniformItems;
};
if (_vestClassname != "") then
{
	{ _unit addItemToVest _x; } foreach _vestWeapons;
	{ _unit addItemToVest _x; } foreach _vestMagazines;
	{ _unit addItemToVest _x; } foreach _vestItems;
};
if (_backpackClassname != "") then
{
	{ _unit addItemToBackpack _x; } foreach _backpackWeapons;
	{ _unit addItemToBackpack _x; } foreach _backpackMagazines;
	{ _unit addItemToBackpack _x; } foreach _backpackItems;
};

/* Dann die Waffen hinzufügen, damit diese die Magazine gleich aufnehmen können
   das Inventar sollte danach wieder leer sein. */
if (_primaryWeaponClassname != "") then
{
	if (_primaryWeaponMagazine != "") then { _unit addMagazine _primaryWeaponMagazine; };
	_unit addWeapon _primaryWeaponClassname;
	{_unit addPrimaryWeaponItem _x;} foreach _primaryWeaponItems;
};

if (_handgunClassname != "") then
{
	if (_handgunMagazine != "") then {_unit addMagazine  _handgunMagazine; };
	_unit addWeapon _handgunClassname;
	{_unit addHandgunItem _x;} foreach _handgunItems;
};

/* Ausrüstung hinzufügen */
{
	_unit linkItem _x;
} foreach _linkedItems;
if (_goggleClassname != "") then
{
	_unit addGoggles _goggleClassname;
};
if (_headgearClassname != "") then
{
	_unit addHeadgear _headgearClassname;
};
if (_binocularClassname != "") then
{
	if (_binocularClassname == "Laserdesignator") then { _unit addMagazine "Laserbatteries"; }; /*Rangefinder*/
	_unit addWeapon _binocularClassname;
};
if (_nightVisionClassname != "") then
{
	_unit linkItem _nightVisionClassname;
};

if (_code != "") then
{
	call compile _code;
};

if (count _unitTypes > 0) then { player setVariable ["ACE_isEOD", (_unitTypes select 0), true]; };
if (count _unitTypes > 1) then { player setVariable ["ACE_IsEngineer", (_unitTypes select 1), true]; };
if (count _unitTypes > 2) then { player setVariable ["ace_medical_medicclass", (_unitTypes select 2), true]; };
if (count _unitTypes > 3) then { player setVariable ["isPioneer", (_unitTypes select 3), true]; };


