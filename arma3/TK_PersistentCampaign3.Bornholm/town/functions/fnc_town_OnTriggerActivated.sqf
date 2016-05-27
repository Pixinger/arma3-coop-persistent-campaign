if (isServer) then
{
	player sidechat "ON";
	diag_log format["fnc_town_OnTriggerActivated: _this = %1", _this];
	[(_this select 0)] spawn fnc_town_TownResume;
};