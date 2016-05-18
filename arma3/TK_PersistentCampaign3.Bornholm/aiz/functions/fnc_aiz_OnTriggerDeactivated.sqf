if (isServer) then
{
player sidechat "off";
	diag_log format["fnc_dacZones_OnTriggerDeactivated: _this = %1", _this];

	[(_this select 0)] spawn fnc_aiz_ZonePause;
};