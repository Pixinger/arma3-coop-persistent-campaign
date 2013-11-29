private["_zoneIndex"];
_zoneIndex = _this select 0;

private["_missionLocations"];
_missionLocations = _this select 1;

 private["_markerName"];
_markerName = format["Zone%1", _zoneIndex];

private["_result"]; /* [[0,0,0],0, [0,0],0] location, direction,   markerlocation, markerradius */
_result = [_markerName, _missionLocations, 100, missionsOpt_DefaultMarkerRadius] call fn_missionsOpt_RandomPositionField;

_result