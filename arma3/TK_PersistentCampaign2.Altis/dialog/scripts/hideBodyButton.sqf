private["_button"];
_button = if (((cursorTarget isKindOf "SoldierGB") || (cursorTarget isKindOf "Civilian_F")) && (!alive cursorTarget)) then 
{
	["Körper durchsuchen", TRUE, true,"dialog\scripts\hideBodyAction.sqf"] 
} 
else
{
	["Körper durchsuchen", false, true, ""] 
};
_button;

