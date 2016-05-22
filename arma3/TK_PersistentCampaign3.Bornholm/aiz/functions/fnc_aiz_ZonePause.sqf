diag_log format["fnc_aiz_ZoneOause: _this = %1", _this];
waitUntil { aizZoneInitCompleted };

private["_zoneIndex"];
_zoneIndex = _this select 0;

aizZoneActive set [_zoneIndex, false];