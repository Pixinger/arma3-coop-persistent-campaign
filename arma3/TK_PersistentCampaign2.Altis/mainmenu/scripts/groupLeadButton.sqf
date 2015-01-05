private["_button"]; 
_button = if (count (units (group player)) > 1) then 
{
	if (player == leader (group (vehicle player)) ) then
	{
		["Gruppenführer werden", false, true, ""]
	}
	else
	{
		["Gruppenführer werden", true, true, "mainmenu\scripts\groupLeadAction.sqf"]
	}
} 
else 
{
	["Gruppenführer werden", false, true, ""] 
};
_button;
