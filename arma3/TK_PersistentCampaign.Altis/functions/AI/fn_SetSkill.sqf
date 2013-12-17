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
_leader setSkill random .7;
{
	_x setSkill ["endurance",random .7];
	_x setSkill ["reloadSpeed",random .7];
	_x setSkill ["general",random .7];
	_x setSkill ["spotDistance",random .7];
	_x setSkill ["spotTime",random .7];
	_x setSkill ["courage",random .7];
	_x setSkill ["commanding",random .7];
	_x setSkill ["aimingShake",random .7];
	_x setSkill ["aimingSpeed",random .7];
	_x setSkill ["aimingAccuracy",random .7];
} foreach units _group;