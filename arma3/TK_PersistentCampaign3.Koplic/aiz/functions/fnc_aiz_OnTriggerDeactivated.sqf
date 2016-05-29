if (isServer) then
{
	aizZoneActive set [(_this select 0), 0];	
	[(_this select 0)] call fnc_aiz_ZonePause;
	diag_log format["fnc_aiz_OnTriggerDeactivated: _this = %1", _this];
};