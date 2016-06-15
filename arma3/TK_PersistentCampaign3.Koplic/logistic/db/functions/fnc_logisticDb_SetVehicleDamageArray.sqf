private["_vehicle"];
_vehicle = _this select 0;
private["_damageArray"];
_damageArray = _this select 1;

// _damageArray: Der erste Eintrag entspricht "getDammage _vehicle"!
private _totalDammage = _damageArray select 0;

private["_count"];
_count = count _damageArray;
for "_i" from 1 to _count - 1 do
{
	_vehicle setHitIndex [_i-1, _damageArray select _i];
};

diag_log format["_totalDammage=%1", _totalDammage];
if (_totalDammage > 0.9) then
{
	_vehicle setDamage 1;_vehicle setDamage 0;_vehicle setDamage 1;
};