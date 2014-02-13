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

/*private["_leader"];
_leader = leader _group;
_leader setSkill random pixParamAISkillSettings;
{
	_x setSkill ["general", pixParamAISkillSettings];
	/*setSkill ["endurance", pixParamAISkillSettings];*/
	/*_x setSkill ["reloadSpeed", 0];
	_x setSkill ["spotDistance", 0.9];
	_x setSkill ["spotTime", 0.9];
	_x setSkill ["courage", 0.3];
	_x setSkill ["commanding", 0.9];
	_x setSkill ["aimingShake", pixParamAISkillSettings];
	_x setSkill ["aimingSpeed", pixParamAISkillSettings];
	_x setSkill ["aimingAccuracy", pixParamAISkillSettings];
} foreach units _group;*/

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

/*
 aimingAccuracy
    Affects how well the AI can lead a target
    Affects how accurately the AI estimate range and calculates bullet drop
    Affects how well the AI compensates for weapon dispersion
    Affects how much the AI will know to compensate for recoil (Higher value = more controlled fire)
    Affects how certain the AI must be about its aim on target before opening fire 

aimingShake
    Affects how steadily the AI can hold a weapon (Higher value = less weapon sway) 

aimingSpeed
    Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error) 

commanding
    Affects how quickly recognized targets are shared with the group (Higher value = faster reporting) 

courage
    Affects unit's subordinates' morale (Higher value = more courage) 

endurance
	Disabled in Arma3

general
    Raw "Skill", value is distributed to sub-skills unless defined otherwise. Affects the AI's decision making. 

reloadSpeed
    Affects the delay between switching or reloading a weapon (Higher value = less delay) 

spotDistance
    Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
    Affects the accuracy of the information (Higher value = more accurate information) 

spotTime
    Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction) 
*/