if (isServer) then
{
	params ["_townIndex"];
	townActive set [_townIndex, 0];
	[_townIndex] call fnc_town_TownPause;
	//diag_log format["fnc_town_OnTriggerDeactivated: _this = %1", _this];
};