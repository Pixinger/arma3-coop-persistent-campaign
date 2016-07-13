#include "..\..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

// _this: classname

if (_this == "") exitWith { 0 };

if (runLogisticGear_LastMassResult select 0 == _this) exitWith 
{ 
//	if (pixDebug) then { diag_log format["fnc_logisticGear_GetMass.sqf: LAST RESULT [WW] Classname='%1' Mass=%2", _this, (runLogisticGear_LastMassResult select 1)];};
	(runLogisticGear_LastMassResult select 1); 
};

private _mass = 0;
_mass = [(configfile >> "CfgWeapons" >> _this >> "WeaponSlotsInfo"),"mass",0] call BIS_fnc_returnConfigEntry;
if (_mass > 0) exitWith 
{ 
//	if (pixDebug) then { diag_log format["fnc_logisticGear_GetMass.sqf: [WW] Classname='%1' Mass=%2", _this, _mass];};
	runLogisticGear_LastMassResult = [_this, _mass];
	_mass; 
};
_mass = [(configfile >> "CfgWeapons" >> _this >> "ItemInfo"),"mass",0] call BIS_fnc_returnConfigEntry;
if (_mass > 0) exitWith 
{ 
//	if (pixDebug) then { diag_log format["fnc_logisticGear_GetMass.sqf: [WI] Classname='%1' Mass=%2", _this, _mass];};
	runLogisticGear_LastMassResult = [_this, _mass];
	_mass; 
};
_mass = [(configfile >> "CfgMagazines" >> _this),"mass",0] call BIS_fnc_returnConfigEntry;
if (_mass > 0) exitWith 
{ 
//	if (pixDebug) then { diag_log format["fnc_logisticGear_GetMass.sqf: [MA] Classname='%1' Mass=%2", _this, _mass];};
	runLogisticGear_LastMassResult = [_this, _mass];
	_mass; 
};
_mass = [(configfile >> "CfgVehicles" >> _this),"mass",0] call BIS_fnc_returnConfigEntry;
if (_mass > 0) exitWith 
{ 
//	if (pixDebug) then { diag_log format["fnc_logisticGear_GetMass.sqf: [VE] Classname='%1' Mass=%2", _this, _mass];};
	runLogisticGear_LastMassResult = [_this, _mass];
	_mass; 
};
_mass = [(configfile >> "CfgGlasses" >> _this),"mass",0] call BIS_fnc_returnConfigEntry; 
if (_mass > 0) exitWith 
{ 
//	if (pixDebug) then { diag_log format["fnc_logisticGear_GetMass.sqf: [GL] Classname='%1' Mass=%2", _this, _mass];};
	runLogisticGear_LastMassResult = [_this, _mass];
	_mass; 
};

if (pixDebug) then { diag_log format["fnc_logisticGear_GetMass.sqf: [XX] Classname='%1' Mass=%2", _this, _mass];};
runLogisticGear_LastMassResult = [_this, _mass];
_mass; 