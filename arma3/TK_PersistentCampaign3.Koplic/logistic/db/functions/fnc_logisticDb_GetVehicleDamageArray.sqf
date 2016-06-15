private["_vehicle"];
_vehicle = _this select 0;

private["_damageArray"];
_damageArray = [];

_damageArray pushBack (getDammage _vehicle); // Das erste Element ist der TotalSchaden

private["_i"];
_i = 0;

private["_damage"];
_damage = _vehicle getHitIndex _i;
while { !isNil "_damage" } do 
{
	_damageArray pushBack _damage;
	_i = _i + 1;
	_damage = _vehicle getHitIndex _i;
};
//diag_log format["GetVehicleDamageArray: %1", _damageArray];

_damageArray;