/*--------------------------------------------------*/
/* Startet eine über Ihren Index definierte Mission */
/*--------------------------------------------------*/
private["_zoneIndex"];
_zoneIndex = _this select 0;
/* Der "_missionInfoIndex" entspricht einmal dem Index der "pvehPixZones_MissionInfos" wo die Opt-Missions spezifischen Daten abgefragt */
/* werden können. Zum anderen entspricht er dem "pvehPixZones_MissionStatus" Index wo der Status der entsprechenden Mission hinterlegt ist */
/* "(pvehPixZones_MissionInfos select 2) select _missionInfoIndex" gibt die MissionsOpt-Daten an (mission-cfg-index, position, richtung).
/* "(pvehPixZones_MissionStatus select 1) select _missionInfoIndex" gibt den MissionsOpt-Status an.*/
private["_missionInfoIndex"];
_missionInfoIndex = _this select 1; 

/*--------------*/
/* Error Checks */
/*--------------*/
if (_zoneIndex < 0) then { player globalChat format["ERROR: Invalid MissionOpt-ZoneIndex %1 (too small)", _zoneIndex]; };
if (_zoneIndex >= pixZones_ZoneCount) then { player globalChat format["ERROR: Invalid MissionOpt-ZoneIndex %1 (too large)", _zoneIndex]; };

/*-----------------*/
/* Mission starten */
/*-----------------*/
private["_missionOpt"]; /* [mission-cfg-index,, missionPosition, missionDirection] */
_missionOpt = (pvehPixZones_MissionInfos select 2) select _missionInfoIndex; /* Das brauchen wir um an die opt-mission-id (z.B. apc, checkpoint, ...) zu kommen */
private["_mission_cfg_Index"]; 
_mission_cfg_Index = _missionOpt select 0; 

/*-----------------------------*/
/* Wichtig: Als execVM starten */
/*-----------------------------*/
_tmp = [_zoneIndex, _missionInfoIndex] execVM format["missionsOpt\%1\run.sqf", (missionsOpt_Missions select _mission_cfg_Index)];
