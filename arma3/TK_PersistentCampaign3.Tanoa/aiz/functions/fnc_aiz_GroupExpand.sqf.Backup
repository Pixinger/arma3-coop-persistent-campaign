//diag_log format["fnc_aiz_GroupExpand: _this=%1", _this];
params ["_group", "_unitInfos"];

private _leader = leader _group;
_leader setSpeedMode "LIMITED";

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


{ 
	_group reveal _x; 
	_x setSpeedMode "LIMITED"; 
	_x setCombatMode "WHITE"; // YELLOW / RED
	_x setBehaviour "SAFE";	
} foreach (units _group);
_group setFormation "STAG COLUMN";

[_group] spawn {
	Sleep 3;

	(_this select 0) setFormation "STAG COLUMN";
	{ 
		(_this select 0) reveal _x; 
		_x setSpeedMode "LIMITED"; 
		_x setCombatMode "WHITE"; // YELLOW / RED
		_x setBehaviour "SAFE";
	} foreach (units (_this select 0));
	(_this select 0) setFormation "STAG COLUMN";	
};	

true;