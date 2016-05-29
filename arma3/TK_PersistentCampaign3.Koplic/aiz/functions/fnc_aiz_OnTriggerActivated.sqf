if (isServer) then
{
	aizZoneActiveCounter = aizZoneActiveCounter + 1;
	aizZoneActive set [_zoneIndex, aizZoneActiveCounter];
	[(_this select 0), aizZoneActiveCounter] call fnc_aiz_ZoneResume;
	diag_log format["fnc_aiz_OnTriggerActivated: _this = %1", _this];
};