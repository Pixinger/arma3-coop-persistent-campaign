if (!isServer || !isDedicated) then
{
	private["_target"];
	_target = cursorTarget;

	if (!alive player) exitWith { false };
	if ((player getVariable "pixRevive_UNC") == 1) exitWith { false };
	if ((_target getVariable "pixRevive_UNC") == 0) exitWith { false };
	if ((_target getVariable "pixRevive_DRG") == 1) exitWith { false };
	if (pixRevive_IsDragging) exitWith { false };
	if (isNil "_target") exitWith { false };
	if (!alive _target) exitWith { false };
	if ((_target distance player) > 3 ) exitWith { false };
	if (isNil "_target") exitWith { false };
	if (!(pixRevive_RequiredItem in (items player))) exitWith { false };

	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	_target setVariable ["pixRevive_UNC", 0, true];
	_target setVariable ["pixRevive_DRG", 0, true];
	
	private["_cnt"];
	_cnt = pixRevive_ReviveTime; 
	while {_cnt > 0} do
	{
		hintSilent format["Versorgung beendet in: %1", _cnt];
		_cnt = _cnt - 1;
		sleep 1;
	};
	hintSilent "";		
};