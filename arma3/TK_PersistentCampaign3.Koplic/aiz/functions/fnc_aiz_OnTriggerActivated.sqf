if (isServer) then
{
	diag_log format["fnc_aiz_OnTriggerActivated: _this = %1", _this];
	[(_this select 0)] spawn fnc_aiz_ZoneResume;
};