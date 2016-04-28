private["_result"];
_result = false;

if (isServer && !isDedicated) then
{
	_result = true;
};

//
if (serverCommandAvailable "#logout") then
{
	_result = true;
};

_result;