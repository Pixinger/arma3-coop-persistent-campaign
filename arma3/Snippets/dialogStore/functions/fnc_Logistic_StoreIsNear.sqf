private["_result"];
_result = false;
{
	if ((_x select 0) distance (position player) < 20) exitWith { _result = true; };
} foreach logisticStores;
_result