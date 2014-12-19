private["_button"]; 
_button = ["Festnehmen", false, true,"dialog\scripts\arrestAction.sqf"];

if ((cursorTarget isKindOf "SoldierGB") && (cursorTarget distance player < 5))	then
{
	_button set [1, true];
};

_button;

