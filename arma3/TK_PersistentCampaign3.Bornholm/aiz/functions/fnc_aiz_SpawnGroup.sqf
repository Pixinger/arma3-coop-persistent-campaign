params ["_position", "_side", "_unitClassnames"];

private _group = [_position, _side, _unitClassnames] call BIS_fnc_SpawnGroup;

{	
	private _skill = (aizAISkillMin + (random (aizAISkillMax - aizAISkillMin)));
	diag_log format["fnc_aiz_SpawnGroup: Skill=%1", _skill];
	_x setSkill _skill;
} foreach (units _group);
_gropup;