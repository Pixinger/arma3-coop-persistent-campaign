private["_button"]; 
_button = ["Festnehmen", false, true,"mainmenu\scripts\arrestAction.sqf"];

private["_unit"];
_unit = cursorTarget;
if ((_unit isKindOf pixTown_ConfigBaseClassRed) && (_unit distance player < 5) && (alive _unit)) then
{
	_button set [1, true];
};

_button;

