/* 
	Generiert für eine bestimmte Gruppe zufällig Skill-Level
	
Parameter:
	group: Die Gruppe für die zufällige SkillLevel generiert werden sollen.

Return: 
	nothing

/*-------------------------------------------------------------------*/

private["_group"];
_group = [_this, 0, grpNull, [grpNull]] call BIS_fnc_param;

/*-------------------------------------------------------------------*/

private["_leader"];
_leader = leader _group;
_leader setSkill random 1;
{
	_x setSkill ["aimingAccuracy",random 1];
	_x setSkill ["endurance",random 1];
	_x setSkill ["reloadSpeed",random 1];
	_x setSkill ["general",random 1];
	_x setSkill ["spotDistance",random 1];
	_x setSkill ["spotTime",random 1];
	_x setSkill ["courage",random 1];
	_x setSkill ["commanding",random 1];
	_x setSkill ["aimingShake",random 1];
	_x setSkill ["aimingSpeed",random 1];
} foreach units _group;