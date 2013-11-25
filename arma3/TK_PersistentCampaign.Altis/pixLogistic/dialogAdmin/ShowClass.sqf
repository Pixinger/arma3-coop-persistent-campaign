/*
=====================================================================================================================
ShowClass - by Cyborg11
Version: 1.4
Date: 05.04.2010
Description: 
	- This script will show you the
		- name
		- type
		- magazines
		- weapons
		- position (coordinates + mapgridposition)
		- items (only infantry)
		- primary and secondary weapon and pistol (only infantry)
		- turrets (only vehicle)
		- cargopositions (only vehicle)
		- driver, gunner and commander position (only vehicle)
		- total amount of seats (only vehicle)
		- driver weapons and magazines (only vehicle)
		- rucksack content (only infantry and only when ACE enabled)
	   of the Target you are aiming at.	
	- Classname of unit will be copied to your clipboard
	- Weapons, magazines, classname, name of unit, position and rucksack content will be saved to 
	   arma2.rpt with "Save to arma2.rpt" action
	- Change the target to player unit instead the cursorTarget and vice-versa
	- If you want to add the rucksack content to another unit then look at the ace wikipedia:
		- PackWeapon: http://dev-heaven.net/docs/ace/files/sys_ruck/fnc_PackWeapon-sqf.html
		- PackMagazine: http://dev-heaven.net/docs/ace/files/sys_ruck/fnc_PackMagazine-sqf.html
		- PutWeaponOnBack: http://dev-heaven.net/docs/ace/files/sys_ruck/fnc_PutWeaponOnBack-sqf.html
	
	arma2.rpt example of a soldier:
	--------------------------------------------------------------------------------------------------------------------------------------
	Unit: B 1-1-A:1 (Cyborg11) (Schütze)
	Classname: USMC_Soldier
	Weapons: ["NVGoggles","ACE_FAST_PackEDC","DMR","ACE_Glock18"]
	Magazines: ["20Rnd_762x51_DMR","20Rnd_762x51_DMR", ...]
	Items: ["ItemMap","ItemCompass","ItemWatch","ItemRadio","ACE_GlassesGasMask_US"]
	Rucksack Weapons: [["m16a4",1]]
	Rucksack Magazines: [["30Rnd_556x45_Stanag",6],["HandGrenade_West",4]]
	Weapon on Back: ACE_HK416_D10
	Position: 035015
	Coordinates: [3537.15,3570.88,0.00140953]
	--------------------------------------------------------------------------------------------------------------------------------------

	If you want that the script updates faster then change the variable _sleep in line 83. 
	Default value is 1 second.
	
Changelog:
	v1.4:	- The hint displays the magazines array now as following:
		   [["Magazin1", count], ["Magazin2", count], ...]
		   But arma2.rpt displays the magazines array as the normal magazines array (see the example above)
		- If ACE is enabled and the unit has a rucksack the script now displays the content of the rucksack and
		  will save it in the ArmA 2 report file (arma2.rpt)
		- Action to change the target to player unit instead cursorTarget and vice-versa
		- Vehicle hint now displays the driver weapons and magazines if present

	v1.3:	- Added an action to write to the arma2.rpt - not automatically anymore
		- Fixed the total seat number

	v1.2:	- added pistol to infantry hint
		- infantry hint will display the pictures of the weapons
		- vehicle hint displays the picture of the vehicle now
		- position also displays the mapgridposition
		- getPos -> getPosATL
	
	v1.1:	- added turrets, cargo/gunner/driver/commander position for vehicles
		- weapons, magazines, unitclassname and position will now be displayed in arma2.rpt
		- new colored hint
		
	v1.0:	- first Release

Parameter:  nul = [] execVM "showclass.sqf";
=====================================================================================================================
*/

private	["_seats","_once","_pweap","_sweap","_picture","_sleep","_commander","_gunner","_driver","_icon",
		 "_target","_items","_dispname","_weaps","_mags","_type","_pos","_cweap","_cmag","_ammo","_turrets",
		 "_turretcount","_cargoseats","_turretname","_dispnameturret","_mainturret","_turretarrayname","_turrethint",
		 "_weapPicArray","_weapPic","_weap","_weapPicHint","_weapArray","_pistol","_isPistol","_gridPos","_effcom","_array",
		 "_unit","_unitarray","_hasturrets","_ace","_hasruck","_ruckWeaps","_ruckMags","_weaponback","_uniqueArray",
		 "_compressedArray","_weapdriv","_magsdriv","_drivhint","_portrait"
		];

_hasruck = false;
_sleep = 1;
//_ace = isClass (configFile >> "CfgPatches" >> "ace_version");	// Check if ACE is installed
_ace = isClass (configFile>>"cfgWeapons" >> "ACE_B61BombLauncher");		// Check if ACE is installed
_pistol = "";

If (isNil "CYBP_save") then {saveact = player addAction ["Save to arma2.rpt", "observer\showclass.sqf", ["save"], 99, false, true, ""]};
If (isNil "CYBP_tapl") then {changetargetact = player addAction ["Change target to Player", "observer\showclass.sqf", ["player"], 98, false, true, ""]};

If (count _this > 2) then {_array = _this select 3} else {_array = []};	// _this is greater than 2 if the player has activated the given action
If (count _array > 0) then {
	If ("save" IN _array) then {CYBP_save = true};
	If ("player" IN _array) then {
		switch (CYBP_tapl) do {			// CYBP_tapl = Target Player => true if target is player
			case true : {
				CYBP_tapl = false;
				player removeAction changetargetact;
				changetargetact = player addAction ["Change target to Player", "observer\showclass.sqf", ["player"], 98, false, true, ""];
			};
			case false : {
				CYBP_tapl = true;
				player removeAction changetargetact;
				changetargetact = player addAction ["Change target to cursorTarget", "observer\showclass.sqf", ["player"], 98, false, true, ""];
			};
		};
	};
} else {
	CYBP_save = false;
	CYBP_tapl = false;
};

If (CYBP_save) exitWith {
	switch (CYBP_tapl) do {
		case true : {_target = player};
		case false : {_target = cursorTarget};
	};
	_dispname = getText (configFile >> "cfgVehicles" >> typeof _target >> "displayName");
	_items = items _target;
	_weaps = (weapons _target) - _items;	
	_mags = magazines _target;				
	_type = typeOf _target;
	_pos = getPosATL _target;
	_gridPos = mapGridPosition _pos;
	If (_target isKindOf "Man") then {
		If (_ace) then {
			_weaponback = _target getVariable "ACE_weapononback";
			_hasruck = [_target] call ACE_fnc_HasRuck;
			If (_hasruck) then {
				_ruckMags = [_target] call ACE_fnc_RuckMagazinesList;
				_ruckWeaps = [_target] call ACE_fnc_RuckWeaponsList;
			};
		};
	};

	If (!(isNull _target)) then {
		diag_log text format [""];
		diag_log text format ["Unit: %1 (%2)", _target, _dispname];
		diag_log text format ["Classname: %1", _type];
		diag_log text format ["Weapons: %1", _weaps];
		diag_log text format ["Magazines: %1", _mags];
		If (_target isKindOf "Man") then {diag_log text format ["Items: %1", _items]};
		If (_target isKindOf "Man" && _ace && _hasruck) then {diag_log text format ["Rucksack Weapons: %1", _ruckWeaps]};
		If (_target isKindOf "Man" && _ace && _hasruck) then {diag_log text format ["Rucksack Magazines: %1", _ruckMags]};
		If (_target isKindOf "Man" && _ace && !(_weaponback == "")) then {diag_log text format ["Weapon on Back: %1", _weaponback]};
		diag_log text format ["Position: %1", _gridPos];
		diag_log text format ["Coordinates: %1", _pos];
		diag_log text format [""];
	};
	
	CYBP_save = false;
};

If (CYBP_tapl) exitWith {};

// Function for pistol data - by Spooner
isPistol =
{
	_unknownWeaponClass = _this select 0;
	
	_unknownConfig = configFile >> "CfgWeapons" >> _unknownWeaponClass;
	_pistolConfig = configFile >> "CfgWeapons" >> "PistolCore";
	
	_isPistol = false;
	while {isClass _unknownConfig} do
	{
	    if (_unknownConfig == _pistolConfig) exitWith
	    {
	        _isPistol = true;
	    };
	
	    _unknownConfig = inheritsFrom _unknownConfig;
	};
	
	_isPistol; // Return.
};

While {true} do {
	_uniqueArray = [];
	_compressedArray = [];
	_portrait = "";
	
	switch (CYBP_tapl) do {
		case true : {_target = player};
		case false : {_target = cursorTarget};
	};

	If (_target isKindOf "All") then {
	If (!(isNil ("_target"))) then {
		_items = items _target;
		_dispname = getText (configFile >> "cfgVehicles" >> typeof _target >> "displayName");	// different displayname for different languages
		_weaps = (weapons _target) - _items;	
		_mags = magazines _target;				
		_type = typeOf _target;
		_pos = getPosATL _target;
		_gridPos = mapGridPosition _pos;
		_cweap = currentWeapon _target;
		_pweap = primaryWeapon _target;
		If (_pweap == "") then {_pweap = "/"};
		_sweap = secondaryWeapon _target;
		If (_sweap == "") then {_sweap = "/"};
		_cmag = currentMagazine _target;
		_ammo = _target ammo _cweap;
		_weapPicArray = [];
		_weapArray = [];
		_weapPicHint = "";
		_pistol = "";
		_turretarrayname = [];
		_turrethint = "";
			
		If(_target isKindOf "Man") then {
			_portrait = getText (configFile >> "cfgVehicles" >> _type >> "portrait");
			//player globalchat format ["Portrait: %1", _portrait];
		
			If (!(_weaps select 0 == "")) then {
				for [{_i = 0}, {_i < count _weaps}, {_i = _i + 1}] do {
					_weap = _weaps select _i;
					_weapPic = getText (configFile >> "cfgWeapons" >> _weap >> "picture");
					_weapPicArray = _weapPicArray + [_weapPic];
					If ([_weap] call isPistol) then {_pistol = _weap};
				};				
				_weapPicHint = 
					switch (count _weapPicArray) do {
						case 1 : {format ["<img size='1.75' image='%1'/><br/>", _weapPicArray select 0]};
						case 2 : {format ["<img size='1.75' image='%1'/> - <img size='1.75' image='%2'/><br/>", _weapPicArray select 0, _weapPicArray select 1]};
						case 3 : {format ["<img size='1.75' image='%1'/> - <img size='1.75' image='%2'/> - <img size='1.75' image ='%3'/><br/>", _weapPicArray select 0, _weapPicArray select 1, _weapPicArray select 2]};
						case 4 : {format ["<img size='1.75' image='%1'/> - <img size='1.75' image='%2'/> - <img size='1.75' image ='%3'/> - <img size='1.75' image='%4'/><br/>", _weapPicArray select 0, _weapPicArray select 1, _weapPicArray select 2, _weapPicArray select 3]};
						case 5 : {format ["<img size='1.75' image='%1'/> - <img size='1.75' image='%2'/> - <img size='1.75' image ='%3'/> - <img size='1.75' image='%4'/> - <img size='1.75' image='%5'/><br/>", _weapPicArray select 0, _weapPicArray select 1, _weapPicArray select 2, _weapPicArray select 3, _weapPicArray select 4]};
				};
			} else {
				_weapPicArray = [];
				_weapPicHint = "";
			};
			If (_pistol == "") then {_pistol = "/"};
			
			If (_ace) then {
				_hasruck = [_target] call ACE_fnc_HasRuck;
				If (_hasruck) then {
					_ruckMags = [_target] call ACE_fnc_RuckMagazinesList;
					_ruckWeaps = [_target] call ACE_fnc_RuckWeaponsList;
				};
				_weaponback = _target getVariable "ACE_weapononback";
			};
		};
		
		// Change magazines array ["Magazine1", "Magazine1", "Magazine1", "Magazine2", ...] to this format: [["Magazine1", 4], ["Magazine2", 6], ...]
		{
			if (!(_x in _uniqueArray)) then	{
				_uniqueArray set [count _uniqueArray,_x];
				_compressedArray set [count _compressedArray,[_x,1]];
			} else {
				_className = _x;
				_i = 0;
				{
					if ((_x select 0) == _className) exitWith {_compressedArray set [_i,[_className,(_x select 1) + 1]];};
					_i = _i + 1;
				} forEach _compressedArray;
			};
		} forEach _mags;
		
		If (!(_target isKindOf "Building")) then {				// buildings doesn't have an icon or a picture
			_icon = getText (configFile >> "cfgVehicles" >> _type >> "icon");		// get icon from config
			_picture = getText (configFile >> "cfgVehicles" >> _type >> "picture");	// get picture from config
		} else {
			_icon = "";
			_picture = "";
		};
			
		If (_target isKindOf "LandVehicle" || _target isKindOf "Air" || _target isKindOf "Ship") then {	// check if the unit is a vehicle
			_weapdriv = getArray (configFile >> "cfgVehicles" >> _type >> "weapons");		// Pilot/Driver weapons
			_magsdriv = getArray (configFile >> "cfgVehicles" >> _type >> "magazines");		// Pilot/Driver magazines
			_drivhint = format ["<br/><br/><t color='#0000CC'>Driver Weapons:</t><br/>%1<br/><br/><t color='#0000CC'>Driver Magazines:</t><br/>%2", _weapdriv, _magsdriv];
			If (count _weapdriv == 0) then {_drivhint = ""};
			
			_mainturret = false;
			_hasturrets = false;
			If (isClass (configFile >> "cfgVehicles" >> _type >> "Turrets")) then {				// check if the unit has turrets
				If ((count (configFile >> "cfgVehicles" >> _type >> "Turrets")) > 1) then {		// Sometimes there are Turrets in the Turrets class (Air vehicles) and that turrets are dependent on the Mainturret class
					_turrets = configFile >> "cfgVehicles" >> _type >> "Turrets";
					_hasturrets = true;
				} else {
					_turrets = configFile >> "cfgVehicles" >> _type >> "Turrets" >> "MainTurret" >> "Turrets";	// If only the "Mainturret" class is in "Turrets" then use the lower class "Turrets" as the turrets (Tanks f.e.)
					_mainturret = true;
					_hasturrets = true;
				};
			} else {
				_turrets = [];		// If the turret check fails then there are no turrets
			};
			_turretcount = 
				If (_mainturret) then {
					(count _turrets) - 1;	// If the turrets are a lower class of MainTurret then substract 1 from the _turret count (CommanderOptics)
				} else {
					count _turrets;
			};
						
			If (_turretcount >= 1) then {
				for [{_i = 0}, {_i < _turretcount}, {_i = _i + 1}] do {
					_turretarrayname = _turretarrayname + [getText (_turrets select _i >> "gunnerName")];
					//player globalchat format ["%1", _turretarrayname];
				};
			};
			//case 1 : {format ["<t color='#CCCC33'>Turret:</t> %1<br/><t color='#CCCC33'>Turretname:</t> %2<br/>Test: %3<br/>", _turretcount, getText (_turrets select 0 >> "gunnerName"), _turrets select 0]};
			_turrethint = switch (_turretcount) do {
				case -1 : {""};
				case 1 : {format ["<t color='#CCCC33'>Turret:</t> %1<br/><t color='#CCCC33'>Turretname:</t> %2<br/>", _turretcount, getText (_turrets select 0 >> "gunnerName")]};
				case 2 : {format ["<t color='#CCCC33'>Turrets:</t> %1<br/><t color='#CCCC33'>Turretname 1:</t> %2<br/><t color='#CCCC33'>Turretname 2:</t> %3<br/>",_turretcount, _turretarrayname select 0, _turretarrayname select 1]};
				case 3 : {format ["<t color='#CCCC33'>Turrets:</t> %1<br/><t color='#CCCC33'>Turretname 1:</t> %2<br/><t color='#CCCC33'>Turretname 2:</t> %3<br/><t color='#CCCC33'>Turretname 3:</t> %4<br/>",_turretcount, _turretarrayname select 0, _turretarrayname select 1, _turretarrayname select 2]};
				case 4 : {format ["<t color='#CCCC33'>Turrets:</t> %1<br/><t color='#CCCC33'>Turretname 1:</t> %2<br/><t color='#CCCC33'>Turretname 2:</t> %3<br/><t color='#CCCC33'>Turretname 3:</t> %4<br/><t color='#CCCC33'>Turretname 4:</t> %5<br/>",_turretcount, _turretarrayname select 0, _turretarrayname select 1, _turretarrayname select 2, _turretarrayname select 3]};
				case 5 : {format ["<t color='#CCCC33'>Turrets:</t> %1<br/><t color='#CCCC33'>Turretname 1:</t> %2<br/><t color='#CCCC33'>Turretname 2:</t> %3<br/><t color='#CCCC33'>Turretname 3:</t> %4<br/><t color='#CCCC33'>Turretname 4:</t> %5<br/><t color='#CCCC33'>Turretname 5:</t> %6<br/>",_turretcount, _turretarrayname select 0, _turretarrayname select 1, _turretarrayname select 2, _turretarrayname select 3, _turretarrayname select 4]};
			};
			
			_upperclass = configName (inheritsFrom (configFile >> "cfgVehicles" >> _type));
			_cargoseats = getNumber (configFile >> "cfgVehicles" >> _type >> "transportSoldier");
			_driver = getNumber (configFile >> "cfgVehicles" >> _upperclass >> "hasDriver");
			
			// Workaround to check if the vehicle has a gunner position
			_gunner = _target emptyPositions "Gunner";
			If (_gunner == 0) then {							// check if position is not empty (empty = 1)
				_gunner = switch (isNull (gunner _target)) do {	// check if a soldier is in gunner position
					case true : {0};							// no gunner in vehicle => there isn't a gunner position in that vehicle
					case false: {1};							// gunner is in vehicle
				};
			} else {									// if the script goes to the else code then the position is empty (1)
				_gunner = switch (_mainturret) do {		// check if the vehicle has multiple turrets which doesn't use the 
					case false : {0};					// mainturret as base class
					case true : {1};
				};
			};
			
			
			// Workaround to check if the vehicle has a commander position
			_commander = _target emptyPositions "commander";
			_effcom = effectiveCommander _target;
			If (_commander == 0) then {						// check if position is not empty (empty = 1)
				If (isNull (commander _target)) then {		// check if soldier is in commander position
					_commander = 0;							// no commander in vehicle => there isn't a commander position in that vehicle
				} else {
					_commander = 1;							// commander in vehicle
				};
			};
			
			// Total amount of seats
			_seats = If (_turretcount == -1) then {
					_cargoseats + _driver + _gunner + _commander + (_turretcount + 1);
				} else {
					_cargoseats + _driver + _gunner + _commander + _turretcount;
			};
		};

If (_target isKindOf "LandVehicle" || _target isKindOf "Air" || _target isKindOf "Ship") then {
hintSilent parseText format ["
<t color='#330000'>Unit:</t> %1<br/>
<t color='#330000'>Name:</t> %9<br/>
<t color='#330000'>Type:</t> %4<br/>
<t color='#330000'>Position:</t> %14<br/>
<t color='#330000'>Coords:</t> %5<br/>
<t color='#330000'>Picture:</t><br/>
<img size='6' image='%10'/><br/><br/>
<t color='#990000'>Vehicle Informations:</t><br/>
<t color='#CCCC33'>Driver:</t> %8<br/>
<t color='#CCCC33'>Gunner:</t> %11<br/>
<t color='#CCCC33'>Commander:</t> %12<br/>
<t color='#CCCC33'>Cargoseats:</t> %7<br/>
%6
<t color='#CCCC33'>Total amount of seats:</t> %13
%15<br/><br/>
<t color='#0000CC'>Weapons:</t><br/>%2<br/><br/>
<t color='#0000CC'>Magazines:</t><br/>%3
",
	_target, _weaps, _compressedArray, _type, _pos,				// 5
	_turrethint, _cargoseats, _driver, _dispname, _picture,		// 10
	_gunner, _commander, _seats, _gridPos, _drivhint			// 15
];
} else {
If (!_hasruck) then {
hintSilent parseText format ["
<t color='#330000'>Unit:</t> %1 <img image='%7'/><br/>
<t color='#330000'>Name:</t> %6<br/>
<t color='#330000'>Type:</t> %4<br/>
<t color='#330000'>Position:</t> %13<br/>
<t color='#330000'>Coords:</t> %5<br/><br/>
<t color='#0000CC'>Weapons:</t><br/>%2<br/>
%11
<t color='#CCCC33'>Primary:</t> %9<br/>
<t color='#CCCC33'>Secondary:</t> %10<br/>
<t color='#CCCC33'>Pistol:</t> %12<br/><br/>
<t color='#0000CC'>Magazines:</t><br/>%3<br/><br/>
<t color='#0000CC'>Items:</t><br/>%8
",
	_target, _weaps, _compressedArray, _type, _pos,			// 5
	_dispname, _icon, _items, toUpper _pweap, _sweap,		// 10
	_weapPicHint, _pistol, _gridPos, _portrait				// 14
];
} else {
hintSilent parseText format ["
<t color='#330000'>Unit:</t> %1 <img image='%7'/><br/>
<t color='#330000'>Name:</t> %6<br/>
<t color='#330000'>Type:</t> %4<br/>
<t color='#330000'>Position:</t> %13<br/>
<t color='#330000'>Coords:</t> %5<br/><br/>
<t color='#0000CC'>Weapons:</t><br/>%2<br/>
%11
<t color='#CCCC33'>Primary:</t> %9<br/>
<t color='#CCCC33'>Secondary:</t> %10<br/>
<t color='#CCCC33'>Pistol:</t> %12<br/><br/>
<t color='#0000CC'>Magazines:</t><br/>%3<br/><br/>
<t color='#0000CC'>Items:</t><br/>%8<br/><br/>
<t color='#0000CC'>Rucksack Weapons:</t><br/>%14<br/><br/>
<t color='#0000CC'>Rucksack Magazines:</t><br/>%15<br/><br/>
<t color='#0000CC'>Weapon on Back: </t><br/>%16
",
	_target, _weaps, _compressedArray, _type, _pos,				// 5
	_dispname, _icon, _items, toUpper _pweap, _sweap,			// 10
	_weapPicHint, _pistol, _gridPos, _ruckWeaps, _ruckMags,		// 15
	_weaponback, _portrait
];
};
If (!(_target isKindOf "Man")) then {
hintSilent parseText format ["
<t color='#330000'>Object:</t> %1 <img image='%7'/><br/>
<t color='#330000'>Name:</t> %6<br/>
<t color='#330000'>Type:</t> %4<br/>
<t color='#330000'>Position:</t> %13<br/>
<t color='#330000'>Coords:</t> %5
",
	_target, _weaps, _compressedArray, _type, _pos,			// 5
	_dispname, _icon, _items, toUpper _pweap, _sweap,		// 10
	_weapPicHint, _pistol, _gridPos							// 14
];
};
};


		CopyToClipboard _type;		// Copy the classname to the clipboard
		};
	};
	sleep _sleep;
};