private["_result"];
_result = false;

private["_vehicle"];
_vehicle = cursorTarget;

if (_vehicle isKindOf pixTown_ConfigSaniClassname) then
{
	if ((_vehicle distance player) < 10) then
	{
		private["_content"];
		_content = _vehicle getVariable ["TG", 0];

		if (_content > 0) then
		{
			_result = true;
		};
	};
};

_result;