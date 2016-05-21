if (isServer) then
{
	diag_log format["fnc_dacZones_OnTriggerActivated: _this = %1 (zoneNameInices)", _this];
	[(_this select 0)] spawn fnc_aiz_ZoneResume;
};