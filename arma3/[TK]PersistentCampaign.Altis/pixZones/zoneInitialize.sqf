/* ------------------------------------------------------------------------------------------------------------------------------
   Wird auf dem Server aufgerufen, wenn ein Client über "pvehPixZones_OnRequestActivation" eine Aktivierung angefragt hat.
   Dieses Skript bereitet dann die Missionen vor (berechnet was genau und wo gestartet werden soll.
   Die vorbereiteten Daten werden dann über "pvehPixZones_MissionInfos" an alle Clienten gesendet.
   Auserdem startet der Server selbst die Missionen.
/* ------------------------------------------------------------------------------------------------------------------------------*/
if (isServer) then
{
	private["_zoneIndex"];
	_zoneIndex = _this select 0;
	if ((_zoneIndex > -1) && (_zoneIndex < pixZones_ZoneCount)) then
	{
		/*--------------------------------*/
		/* Den Zonen Status aktualisieren */
		/*--------------------------------*/
		pvehPixZones_ZoneStatus set [_zoneIndex, 1];
		publicVariable "pvehPixZones_ZoneStatus";
		if (!isDedicated) then	{ call compile preprocessFileLineNumbers "pixZones\pvehPixZones_ZoneStatus.sqf"; }; /* PublicVariableEventHandler simulieren */

		/*----------------------------*/
		/* Missionen berechnen lassen */
		/*----------------------------*/
		pvehPixZones_MissionInfos = call compile preprocessFileLineNumbers format["pixZones\Zone%1\run.sqf", _zoneIndex];
		publicVariable "pvehPixZones_MissionInfos";
		/* Der PublicVariablen-EventHandler startet die "zoneRun.sqf". Da er das aber nur auf den Clients macht, müssen wir noch nachhelfen */
		call compile preprocessFileLineNumbers "pixZones\pvehPixZones_MissionInfos.sqf"; 
	}
	else
	{
		player sidechat format["ERROR: Unable to start Zone %1. Invalid zone index: %1", _zoneIndex];
	};
};
