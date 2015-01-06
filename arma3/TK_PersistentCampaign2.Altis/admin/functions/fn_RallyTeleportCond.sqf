private["_vehicle"];
_vehicle = cursorTarget;
private["_result"];
_result = false;

if (_vehicle isKindOf admin_ConfigHQClassname) then
{
	if ((_vehicle distance player) < 10) then
	{
		if (getPlayerUID player in admin_ConfigPlayerUIDs) then
		{
			_result = true;
		};
	};
};

_result;