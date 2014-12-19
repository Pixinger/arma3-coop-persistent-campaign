private["_vehicle"];
_vehicle = cursorTarget;
private["_active"];
_active = _vehicle getVariable ["active", false];
if ((_vehicle isKindOf pixTown_ConfigSaniClassname) && ((_vehicle distance player) < 10)) then 
{
	if (_active) then
	{
		_vehicle setVariable["active", false, true];	
		hint "Hilfe wurde eingestellt.";
	}
	else
	{
		_vehicle setVariable["active", true, true];	
		hint "Hilfe wurde angeboten.";
	};	
};