private["_zoneIndex"];
_zoneIndex = _this select 0;

private["_missionLocations"];
_missionLocations = _this select 1;

private["_result"];
_result = _this call compile preprocessFileLineNumbers "missionsOpt\vehicle\fn_GetMissionLocation.sqf";

_result;