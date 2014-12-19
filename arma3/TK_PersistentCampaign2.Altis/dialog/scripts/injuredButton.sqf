private["_button"]; 
_button = ["Medizinisch versorgen", false, true,"dialog\scripts\injuredAction.sqf"];

if ((cursorTarget isKindOf "CAManBase") && (!(isPlayer cursorTarget)) && (cursorTarget getVariable ["injured", 0] != 0)) then
{
	_button set [1, true];
};

_button;

