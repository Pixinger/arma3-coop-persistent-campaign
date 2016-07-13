params ["_position", "_side", "_unitClassnames"];

private _group = [_position, _side, _unitClassnames] call BIS_fnc_SpawnGroup;

{	
	private _skill = (cfgAizAISkillMin + (random (cfgAizAISkillMax - cfgAizAISkillMin)));
	if (_skill < 0) then { _skill = 0; };
	if (_skill > 1) then { _skill = 1; };
	_x setSkill _skill;
} foreach (units _group);
_group;