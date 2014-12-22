private["_button"]; 
_button = if (cursorTarget isKindOf "GroundWeaponHolder") then //WeaponHolder
{
	["Waffen beschlagnahmen", true, true,"dialog\scripts\weaponConfiscateAction.sqf"]  
} 
else
{
	["Waffen beschlagnahmen", false, true, ""] 
};
_button;

