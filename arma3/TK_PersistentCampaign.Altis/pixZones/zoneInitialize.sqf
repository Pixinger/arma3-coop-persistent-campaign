/* ------------------------------------------------------------------------------------------------------------------------------
   Wird auf dem Server aufgerufen, wenn ein Client über "pvehPixZones_OnRequestActivation" eine Aktivierung angefragt hat.
   Dieses Skript bereitet dann die Missionen vor (berechnet was genau und wo gestartet werden soll.
   Die vorbereiteten Daten werden dann über "pvehPixZones_MissionInfos" an alle Clienten gesendet.
   Auserdem startet der Server selbst die Missionen.
/* ------------------------------------------------------------------------------------------------------------------------------*/
if (isServer) then
{
	/* (_this select 0) = _zoneIndex */
	private["_zoneIndex"];
	_zoneIndex = _this select 0; /* (_this select 0) == pvehPixZones_OnRequestActivation */
	if ((_zoneIndex > -1) && (_zoneIndex < pixZones_ZoneCount)) then
	{
		/*------------------------------------------------------------------------------------*/
		/* Merken um welche Art von Angriff es sich handelt, bevor wir den ZonenStatus ändern */
		/*------------------------------------------------------------------------------------*/
		private["_reverseAttack"];
		if (pvehPixZones_ZoneStatus select _zoneIndex == 2) then { _reverseAttack = true; } else { _reverseAttack = false; };
		
		/*--------------------------------*/
		/* Den Zonen Status aktualisieren */
		/*--------------------------------*/
		pvehPixZones_ZoneStatus set [_zoneIndex, 1];
		publicVariable "pvehPixZones_ZoneStatus";
		if (!isDedicated) then	{ call compile preprocessFileLineNumbers "pixZones\pvehPixZones_ZoneStatus.sqf"; }; /* PublicVariableEventHandler simulieren */

		/*----------------------------*/
		/* Missionen berechnen lassen */
		/*----------------------------*/
		/* Der Aufruf der run.sqf gibt uns ein fertig berechnetes "pvehPixZones_MissionInfos"-Objekt zurück. Darin ist enthalten, welche Zone 
		angegriffen werden muss, welche Missionen (env,opt, rev) wo gestartet werden sollen. Dadurch das wir jedes Verzeichnis einzeln ansteuern
		können, kann jede Zone die nicht den Standard-Preset1 verwenden will, die "pvehPixZones_MissionInfos" nach eigenen Vorgaben erstellen. */
		pvehPixZones_MissionInfos = [_reverseAttack] call compile preprocessFileLineNumbers format["pixZones\Zone%1\fn_GetMissionInfoArray.sqf", _zoneIndex];
		publicVariable "pvehPixZones_MissionInfos";
		/* Der PublicVariablen-EventHandler startet bei den CLienten die "zoneRun.sqf". 
		Auf dem Server müssen wir das aber noch manuell machen  */
		call compile preprocessFileLineNumbers "pixZones\pvehPixZones_MissionInfos.sqf"; 
	}
	else
	{
		player globalChat format["ERROR: Unable to start Zone %1. Invalid zone index: %1", _zoneIndex];
	};
};

