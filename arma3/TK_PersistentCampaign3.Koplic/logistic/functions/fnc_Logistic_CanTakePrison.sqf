private["_cursorTarget"];
_cursorTarget = cursorTarget;
private["_cursorTargetType"];
_cursorTargetType = typeof _cursorTarget;

if (!(_cursorTargetType isKindOf cfgLogisticTakePrisonClassname)) exitWith { false };
if (captiveNum _cursorTarget == 0) exitWith { false };

private _hqs = [(position player), 20] call fnc_Logistic_HQFind;
if (count _hqs == 0) exitWith { false };
if (!((_hqs select 0) call fnc_Logistic_HQIsOpen)) exitWith { false };

true;