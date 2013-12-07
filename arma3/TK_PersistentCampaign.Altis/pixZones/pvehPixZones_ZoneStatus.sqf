if (pixDebug) then { player globalChat format["EvtHdlr: pvehPixZones_ZoneStatus=%1", pvehPixZones_ZoneStatus]; };
/* Die Farben der Zonen aktualisieren */
if (!isServer || !isDedicated) then	{ call fn_pixZones_UpdateMarkerColor; };	
