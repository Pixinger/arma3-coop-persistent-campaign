if (isServer) then
{
	params ["_zoneIndex"];
	aizZoneActiveCounter = aizZoneActiveCounter + 1;
	private _aizZoneActiveIndex = aizZoneActiveCounter;
	aizZoneActive set [_zoneIndex, _aizZoneActiveIndex];
	[_zoneIndex, _aizZoneActiveIndex] call fnc_aiz_ZoneResume;
	diag_log format["fnc_aiz_OnTriggerActivated: _this = %1", _this];
};