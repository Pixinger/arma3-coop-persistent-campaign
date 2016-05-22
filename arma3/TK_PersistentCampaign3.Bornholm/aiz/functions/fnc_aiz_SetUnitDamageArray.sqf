params ["_unit", "_damageArray"];

private _count = (count _damageArray) - 1;
for "_i" from 0 to _count do
{
	_unit setHitIndex [_i, _damageArray select _i];
};
