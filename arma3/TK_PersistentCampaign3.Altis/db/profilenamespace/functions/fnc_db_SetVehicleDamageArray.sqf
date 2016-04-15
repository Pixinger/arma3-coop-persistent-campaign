private["_vehicle"];
_vehicle = _this select 0;
private["_damageArray"];
_damageArray = _this select 1;

private["_count"];
_count = (count _damageArray) - 1;
for "_i" from 0 to _count do
{
	_vehicle setHitIndex [_i, _damageArray select _i];
};
