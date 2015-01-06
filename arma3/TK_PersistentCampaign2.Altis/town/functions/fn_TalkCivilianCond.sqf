private["_result"];
_result = false;

private["_civ"];
_civ = cursorTarget;

if ((_civ isKindOf "Civilian_F") && {(alive _civ)} && {(_civ distance player < 8)}) then 
{
	_result = true;
};

_result