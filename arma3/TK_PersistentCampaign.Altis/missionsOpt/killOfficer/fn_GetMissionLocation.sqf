private["_zoneIndex"];
_zoneIndex = _this select 0;

private["_missionLocations"];
_missionLocations = _this select 1;

 private["_markerName"];
_markerName = format["Zone%1", _zoneIndex];

private["_result"];
_result = [[_markerName, _missionLocations, 100] call fn_pixZones_RandomPositionField];

private["_obfuscatedMarker"];
_obfuscatedMarker = [_result select 0, 100] call fn_missionsOpt_GetObfuscatedMarker;	
_result = _result + [_obfuscatedMarker select 0];
_result = _result + [_obfuscatedMarker select 1];

_result;