diag_log format["fnc_aiz_ZoneResume: _this = %1", _this];
waitUntil { aizLoaded };
diag_log "ZoneResume: isLoaded";

private["_zoneIndex"];
_zoneIndex = _this select 0;

aizZoneActive set [_zoneIndex, true];
[_zoneIndex] call fnc_aiz_RunGroup;
