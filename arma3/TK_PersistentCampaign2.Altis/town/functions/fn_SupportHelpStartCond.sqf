private["_result"];
_result = false;

private["_vehicle"];
_vehicle = cursorTarget;

if (_vehicle isKindOf pixTown_ConfigSaniClassname) then
{
	if ((_vehicle distance player) < 10) then
	{
		private["_active"];
		_active = _vehicle getVariable ["TA", false];
		
		if (!_active) then
		{
			_result = true;
		};
	};
};

_result;