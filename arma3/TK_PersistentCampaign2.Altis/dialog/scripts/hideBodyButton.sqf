private["_button"];
_button = ["Körper durchsuchen", false, true, "dialog\scripts\hideBodyAction.sqf"];

private["_unit"];
_unit = cursorTarget;
if (!alive _unit) then
{	
	if ((_unit isKindOf "SoldierGB") || (_unit isKindOf "SoldierWB") || (_unit isKindOf "Civilian_F")) then 
	{
		_button set [1, true];
	};
}; 

_button;

