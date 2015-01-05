private["_button"]; 
_button = ["Fortschicken", false, true,"mainmenu\scripts\sendAwayAction.sqf"];

private["_unit"];
_unit = cursorTarget;
if ((_unit isKindOf "Civilian_F") && (_unit distance player < 5) && (alive _unit))	then
{
	_button set [1, true];
};

_button;

