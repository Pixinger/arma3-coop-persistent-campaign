/*--------------------------------------------------*/
/* Startet eine über Ihren Index definierte Mission */
/*--------------------------------------------------*/
private["_zoneIndex"];
_zoneIndex = _this select 0;
/* Der "_missionInfoIndex" entspricht einmal dem Index der "pvehPixZones_MissionInfos" wo die Rev-Missions spezifischen Daten abgefragt */
/* werden können. Zum anderen entspricht er dem "pvehPixZones_MissionStatus" Index wo der Status der entsprechenden Mission hinterlegt ist */
/* "(pvehPixZones_MissionInfos select 2) select _missionInfoIndex" gibt die MissionsRev-Daten an (mission-cfg-index, position, richtung).
/* "(pvehPixZones_MissionStatus select 1) select _missionInfoIndex" gibt den MissionsRev-Status an.*/
private["_missionInfoIndex"];
_missionInfoIndex = _this select 1; 

/*--------------*/
/* Error Checks */
/*--------------*/
if (_zoneIndex < 0) then { player sidechat format["ERROR: Invalid MissionRev-ZoneIndex %1 (too small)", _zoneIndex]; };
if (_zoneIndex >= pixZones_ZoneCount) then { player sidechat format["ERROR: Invalid MissionRev-ZoneIndex %1 (too large)", _zoneIndex]; };

/*-----------------*/
/* Mission starten */
/*-----------------*/
private["_missionRev"]; /* [mission-cfg-index,, missionPosition, missionDirection] */
_missionRev = (pvehPixZones_MissionInfos select 3) select _missionInfoIndex; /* Das brauchen wir um an die rev-mission-id (z.B. apc, checkpoint, ...) zu kommen */
private["_mission_cfg_Index"]; 
_mission_cfg_Index = _missionRev select 0; 

/*-----------------------------*/
/* Wichtig: Als execVM starten */
/*-----------------------------*/
_tmp = [_zoneIndex, _missionInfoIndex] execVM format["missionsRev\%1\run.sqf", (missionsRev_Missions select _mission_cfg_Index)];
