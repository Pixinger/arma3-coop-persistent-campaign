if (isServer) then
{
	if (pixDebug) then { player sidechat format["EvtHdlr: pvehPixZones_OnRequestActivation=%1", pvehPixZones_OnRequestActivation]; };
	private["_tmp"];
	_tmp = [pvehPixZones_OnRequestActivation] execVM "pixZones\zoneInitialize.sqf"; /* Diese Methode erzeugt dann eine Varaible "pvehPixZones_MissionInfos" für alle Clienten */
};
