if (isServer) then
{
	townActive set [(_this select 0), 0];
	[(_this select 0)] call fnc_town_TownPause;
	diag_log format["fnc_town_OnTriggerDeactivated: _this = %1", _this];
};