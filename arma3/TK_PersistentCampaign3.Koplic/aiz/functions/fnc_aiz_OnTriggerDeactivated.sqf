if (isServer) then
{
	params ["_zoneIndex"];
	aizZoneActive set [_zoneIndex, 0];	
	[_zoneIndex] call fnc_aiz_ZonePause;
	diag_log format["fnc_aiz_OnTriggerDeactivated: _this = %1", _this];
};