private["_grp"];
_grp = _this select 0;	
private["_leader"];
_leader = leader _grp;
_leader setskill random 1;
{
	_x setskill ["aimingAccuracy",random 1];
	_x setskill ["spotDistance",random 1];
	_x setskill ["spotTime",random 1];
	_x setskill ["courage",random 1];
	_x setskill ["commanding",random 1];
	_x setskill ["aimingShake",random 1];
	_x setskill ["aimingSpeed",random 1];
} foreach units _grp;