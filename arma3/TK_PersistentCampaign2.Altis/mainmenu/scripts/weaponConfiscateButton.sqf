private["_button"]; 
_button = if (cursorTarget isKindOf "GroundWeaponHolder") then //WeaponHolder
{
	["Waffen beschlagnahmen", true, true,"mainmenu\scripts\weaponConfiscateAction.sqf"]  
} 
else
{
	["Waffen beschlagnahmen", false, true, ""] 
};
_button;

