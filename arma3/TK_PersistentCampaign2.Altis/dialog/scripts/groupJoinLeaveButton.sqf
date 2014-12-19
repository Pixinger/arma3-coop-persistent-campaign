private["_button"]; 
_button = if (count (units (group player)) > 1) then 
{
	["Gruppe verlassen",true,true,"dialog\scripts\groupLeaveAction.sqf"] 
} 
else
{
	if ((cursorTarget isKindOf "CAManBase") && (isPlayer cursorTarget)) then
	{
		["Gruppe beitreten", true, true, "dialog\scripts\groupJoinAction.sqf"] 
	}
	else
	{
		["Gruppe beitreten", false, true, ""] 
	};
};
_button;
