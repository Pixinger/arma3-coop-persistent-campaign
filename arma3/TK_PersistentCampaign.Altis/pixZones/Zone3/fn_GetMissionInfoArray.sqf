private["_result"];
_result = [_this select 0, 3] call compile preprocessFileLineNumbers "pixZones\Preset1\fn_GetMissionInfoArray.sqf";
_result;