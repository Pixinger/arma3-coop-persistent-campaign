private["_button"]; 
_button = ["HQ Teleport", false, true,"mainmenu\scripts\hqTeleportAction.sqf"];
if (cursorTarget isKindOf "B_APC_Wheeled_01_cannon_F") then 
{
	_button set [1, true];
};
_button;

