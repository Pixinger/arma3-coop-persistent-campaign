/*--------------------------------------------------*/
/* Startet eine über Ihren Index definierte Mission */
/*--------------------------------------------------*/
private["_zoneIndex"];
_zoneIndex = _this select 0;
/* Der "_missionInfoIndex" entspricht einmal dem Index der "pvehPixZones_MissionInfos" wo die Opt-Missions spezifischen Daten abgefragt */
/* werden können. Zum anderen entspricht er dem "pvehPixZones_MissionStatus" Index wo der Status der entsprechenden Mission hinterlegt ist */
private["_missionInfoIndex"];
_missionInfoIndex = _this select 1; 

/*--------------*/
/* Error Checks */
/*--------------*/
if (_zoneIndex < 0) then { player sidechat format["ERROR: Invalid MissionOpt-ZoneIndex %1 (too small)", _zoneIndex]; };
if (_zoneIndex >= pixZones_ZoneCount) then { player sidechat format["ERROR: Invalid MissionOpt-ZoneIndex %1 (too large)", _zoneIndex]; };

/*-----------------*/
/* Mission starten */
/*-----------------*/
private["_missionOpt"]; /* [missionIndex, missionPosition, missionDirection] */
_missionOpt = (pvehPixZones_MissionInfos select 2) select _missionInfoIndex; /* Das brauchen wir um an die opt-mission-id (z.B. apc, checkpoint, ...) zu kommen */
private["_missionOptIndex"]; 
_missionOptIndex = _missionOpt select 0; 

/*-----------------------------*/
/* Wichtig: Als execVM starten */
/*-----------------------------*/
_tmp = [_zoneIndex, _missionInfoIndex] execVM format["missionsOpt\%1\run.sqf", (missionsOpt_Missions select _missionOptIndex)];
