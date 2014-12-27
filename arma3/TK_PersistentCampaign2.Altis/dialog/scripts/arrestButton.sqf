private["_button"]; 
_button = ["Festnehmen", false, true,"dialog\scripts\arrestAction.sqf"];

private["_unit"];
_unit = cursorTarget;
if ((_unit isKindOf "SoldierGB") && (_unit distance player < 5) && (alive _unit)) then
{
	_button set [1, true];
};

_button;

