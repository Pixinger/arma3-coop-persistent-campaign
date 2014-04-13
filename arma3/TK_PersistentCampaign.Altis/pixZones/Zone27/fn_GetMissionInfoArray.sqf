private["_missionsEnv"];/* [[missionEnvIndex, missionPosition, missionDirection],[..]] */
_missionsEnv = [];

/* Die Zeusmission hat den Index 0 */
private["_missionOptZeusIndex"];
_missionOptZeusIndex = 0;

/* Mission Location zu diesem Index bestimmen */
private["_missionLocation"];
_missionLocation = [_zoneIndex, []] call compile preprocessFileLineNumbers format["missionsOpt\%1\fn_GetMissionLocation.sqf", (missionsOpt_Missions select _missionOptZeusIndex)];

private["_missionsOpt"]; /* [[missionOptCfgIndex, missionPosition, missionDirection, markerPosition, markerRadius],[..]] */
_missionsOpt = [[_missionOptZeusIndex, _missionLocation select 0, _missionLocation select 1, _missionLocation select 2, _missionLocation select 3]];		
	
private["_result"];
_result = [27, _missionsEnv, _missionsOpt, []];

_result;
