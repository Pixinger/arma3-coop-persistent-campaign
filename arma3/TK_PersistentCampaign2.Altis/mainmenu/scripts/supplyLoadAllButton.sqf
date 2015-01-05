
private["_button"];
_button = ["Hilfsgüter aufladen", false, true,"mainmenu\scripts\supplyLoadAllAction.sqf"];

private["_vehicle"];
_vehicle = cursorTarget;
if ((_vehicle isKindOf pixTown_ConfigSaniClassname) && ((_vehicle distance player) < 10)) then 
{
	if ((count nearestObjects[(getPos _vehicle), pixTown_ConfigReSupplyClassnames, 100]) > 0) then
	{
		_button set [1, true];
	};	
};
_button;

