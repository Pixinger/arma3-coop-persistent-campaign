private["_result"];
_result = false;

if ((getPlayerUID player) in admin_ConfigPlayerUIDs) then
{
	_result = true;
};

_result;