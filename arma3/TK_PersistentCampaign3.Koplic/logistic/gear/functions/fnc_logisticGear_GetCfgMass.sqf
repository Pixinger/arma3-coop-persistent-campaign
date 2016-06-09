// _this: classname

if (_this == "") exitWith { 0 };

//diag_log "A";
private _mass = 0;
_mass = [(configfile >> "CfgWeapons" >> _this >> "WeaponSlotsInfo"),"mass",0] call BIS_fnc_returnConfigEntry;
if (_mass > 0) exitWith 
{ 
	if (pixDebug) then { diag_log format["fnc_logisticGear_GetMass.sqf: [WW] Classname='%1' Mass=%2", _this, _mass];};
	_mass; 
};
//diag_log "B";
_mass = [(configfile >> "CfgWeapons" >> _this >> "ItemInfo"),"mass",0] call BIS_fnc_returnConfigEntry;
if (_mass > 0) exitWith 
{ 
	if (pixDebug) then { diag_log format["fnc_logisticGear_GetMass.sqf: [WI] Classname='%1' Mass=%2", _this, _mass];};
	_mass; 
};
//diag_log "C";
_mass = [(configfile >> "CfgMagazines" >> _this),"mass",0] call BIS_fnc_returnConfigEntry;
if (_mass > 0) exitWith 
{ 
	if (pixDebug) then { diag_log format["fnc_logisticGear_GetMass.sqf: [MA] Classname='%1' Mass=%2", _this, _mass];};
	_mass; 
};
//diag_log "D";
_mass = [(configfile >> "CfgVehicles" >> _this),"mass",0] call BIS_fnc_returnConfigEntry;
if (_mass > 0) exitWith 
{ 
	if (pixDebug) then { diag_log format["fnc_logisticGear_GetMass.sqf: [VE] Classname='%1' Mass=%2", _this, _mass];};
	_mass; 
};
//diag_log "E";
_mass = [(configfile >> "CfgGlasses" >> _this),"mass",0] call BIS_fnc_returnConfigEntry; 
if (_mass > 0) exitWith 
{ 
	if (pixDebug) then { diag_log format["fnc_logisticGear_GetMass.sqf: [GL] Classname='%1' Mass=%2", _this, _mass];};
	_mass; 
};

//diag_log "F";
if (pixDebug) then { diag_log format["fnc_logisticGear_GetMass.sqf: [XX] Classname='%1' Mass=%2", _this, _mass];};
//diag_log "G";
_mass; 