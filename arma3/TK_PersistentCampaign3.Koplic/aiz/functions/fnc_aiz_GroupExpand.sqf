//diag_log format["fnc_aiz_GroupExpand: _this=%1", _this];
params ["_group", "_unitInfos"];

private _leader = leader _group;
{
	_x params ["_classname", "_weapons", "_skill", "_damageArray"];
	//diag_log format["fnc_aiz_GroupExpand: _x = %1  %2 %3 %4 %5", _this, _classname, _weapons, _skill, _damageArray];
	_unit = _group createUnit [_classname, getPos _leader, [], 0, "FORM"];
	_unit setDir (getDir _leader);
	// TODO: Set weapon loadout
	_unit setUnitAbility _skill;
	[_unit, _damageArray] call fnc_aiz_SetUnitDamageArray;
	_unit setBehaviour (behaviour _leader);
	_unit setSpeedMode (speedMode _leader);
	_unit setCombatMode (combatMode _leader);
} foreach _unitInfos;

_group setBehaviour (behaviour _leader);
_group setSpeedMode (speedMode _leader);
_group setCombatMode (combatMode _leader);

true;