params ["_unit"];

private _i = 0;
private _damageArray = [];
private _damage = _unit getHitIndex _i;
while { !isNil "_damage" } do 
{
	_damageArray pushBack _damage;
	_i = _i + 1;
	_damage = _unit getHitIndex _i;
};
//diag_log format["fnc_aiz_GetUnitDamageArray: %1", _damageArray];
_damageArray;