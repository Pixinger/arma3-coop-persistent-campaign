private["_zoneIndex"];
_zoneIndex = _this select 0;
private["_missionInfoIndex"];
_missionInfoIndex = _this select 1;

/*----------------------------------*/
/* Die Missionsdaten herausarbeiten */
/*----------------------------------*/
private["_missionRev"]; /* [missionIndex, missionPosition, missionStatus] */
_missionRev = ((pvehPixZones_MissionInfos select 3) select _missionInfoIndex);
private["_missionPosition"];
_missionPosition = _missionRev select 1;
private["_missionDirection"];
_missionDirection = _missionRev select 2;

/*---------------------------------------*/
/* Wenn notwendig die Clientside starten */
/*---------------------------------------*/
if (!isServer || !isDedicated) then
{
	private["_tmp"];
	_tmp = [_missionInfoIndex, _missionPosition, _missionDirection] execVM "missionsRev\camp\runClient.sqf";	
};

if (isServer) then
{
	/*---------------------------------------------------------------------*/
	/* Angreifende Zonen bestimmen, also da wo die Gegner herkommen sollen */
	/*---------------------------------------------------------------------*/
	private["_attackingZones"];
	_attackingZones = [_zoneIndex] call compile preprocessFileLineNumbers "missionsRev\fn_GetAttackingZones.sqf";

	/*-------------------*/
	/* Mission erstellen */
	/*-------------------*/




	/*--------------------------------------*/
	/* Warten bis die Mission erfüllt wurde */
	/*--------------------------------------*/
	/*private["_aliveUnits"];
	
	while { (_aliveUnits > 1) && (pixZones_ActiveIndex != -1) } do
	{
		Sleep 2;
		_aliveUnits = 0;
		{ if (alive _x) then { _aliveUnits = _aliveUnits + 1;};} foreach _units;
	};*/

	/*--------------------------------------------------------*/
	/* Status auf beendet setzen und allen Clienten mitteilen */
	/*--------------------------------------------------------*/
	if (pixZones_ActiveIndex != -1) then
	{
		(pvehPixZones_MissionStatus select 2) set [_missionInfoIndex, 1]; /* erfolgreich */	
	}
	else
	{	
		(pvehPixZones_MissionStatus select 2) set [_missionInfoIndex, 2]; /* Fehlgeschlagen */
	};
	publicVariable "pvehPixZones_MissionStatus";
	if (!isDedicated) then { call compile preprocessFileLineNumbers "pixZones\pvehPixZones_MissionStatus.sqf"; }; /* PublicVariableEventHandler simulieren */

	/*-----------------------*/
	/* Kurze Zeitverzögerung */
	/*-----------------------*/
	sleep 60;

	/*------------------------*/
	/* Alle Einheiten löschen */
	/*------------------------*/
	if (pixDebug) then { player sideChat "missionsRev: camp deleted";};	
};
 