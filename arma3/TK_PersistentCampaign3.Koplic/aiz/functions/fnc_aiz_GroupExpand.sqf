//diag_log format["fnc_aiz_GroupExpand: _this=%1", _this];
params ["_group", "_unitInfos"];

private _units = (units _group);
{
	_x setUnitAbility ((_unitInfos select _forEachIndex) select 0);
	_x setBehaviour "SAFE";
	_x setSpeedMode "LIMITED";
	_x setCombatMode "AWARE";
} foreach _units;

true;