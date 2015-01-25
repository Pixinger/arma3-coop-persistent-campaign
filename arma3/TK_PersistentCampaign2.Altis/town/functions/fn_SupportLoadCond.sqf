private["_result"];
_result = false;

private["_vehicle"];
_vehicle = cursorTarget;

if (_vehicle isKindOf pixTown_ConfigSaniClassname) then
{
	if ((_vehicle distance player) < 10) then 
	{
		if ((count nearestObjects[(getPos _vehicle), pixTown_ConfigReSupplyClassnames, 100]) > 0) then
		{
			_result = true;
		};	
	};
};

_result