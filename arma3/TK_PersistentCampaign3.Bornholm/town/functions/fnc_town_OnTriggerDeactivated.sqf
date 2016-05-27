if (isServer) then
{
	player sidechat "OFF";
	diag_log format["fnc_town_OnTriggerDeactivated: _this = %1", _this];
	[(_this select 0)] spawn fnc_town_TownPause;
};