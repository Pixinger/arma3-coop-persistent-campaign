if (!isServer || !isDedicated) then
{
	private ["_target"];
	_target = _this select 0;

	if (alive _target) then
	{
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		_target setVariable ["pixRevive_UNC", 0, true];
		_target setVariable ["pixRevive_DRG", 0, true];
		Sleep 6;
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
	};
};