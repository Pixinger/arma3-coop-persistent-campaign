if (isServer) then
{
	params ["_townIndex"];
	townActiveCounter = townActiveCounter + 1; 
	private _townActiveIndex = townActiveCounter;
	townActive set [_townIndex, _townActiveIndex];
	[_townIndex, _townActiveIndex] call fnc_town_TownResume;
	diag_log format["fnc_town_OnTriggerActivated: _this = %1 / %2", _this, _townActiveIndex];
};