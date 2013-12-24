/*if (pixDebug) then { player globalChat format["EvtHdlr: pvehPixZones_MissionInfos=%1", pvehPixZones_MissionInfos]; };*/

/* Es müssen keine Parameter übergeben werden, da das Skript direkt aus der PublicVaraiblen "pvehPixZones_MissionInfos" ausliest. */
private["_tmp"];
_tmp = [] execVM "pixZones\zoneRun.sqf"; 
