private["_button"]; 
_button = if (cursorTarget isKindOf "WeaponHolder") then 
{
	["Waffen beschlagnahmen", false, true,"dialog\scripts\weaponConfiscateAction.sqf"]  
} 
else
{
	["Waffen beschlagnahmen", false, true, ""] 
};
_button;

