params ["_position", "_side", "_unitClassnames"];

private _group = [_position, _side, _unitClassnames] call BIS_fnc_SpawnGroup;

{	
	private _skill = (aizAISkillMin + (random (aizAISkillMax - aizAISkillMin)));
	if (_skill < 0) then { _skill = 0; };
	if (_skill > 1) then { _skill = 1; };
	
	diag_log format["fnc_aiz_SpawnGroup: Skill=%1", _skill];
	_x setSkill _skill;
} foreach (units _group);
_group;