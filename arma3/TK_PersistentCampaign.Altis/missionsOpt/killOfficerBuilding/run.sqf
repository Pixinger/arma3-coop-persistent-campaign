private["_zoneIndex"];
_zoneIndex = _this select 0;
private["_missionInfoIndex"];
_missionInfoIndex = _this select 1;

/*----------------------------------*/
/* Die Missionsdaten herausarbeiten */
/*----------------------------------*/
private["_missionOpt"]; /* [missionIndex, missionPosition, missionDirection, markerPosition, markerRadius] */
_missionOpt = ((pvehPixZones_MissionInfos select 2) select _missionInfoIndex);
private["_missionPosition"];
_missionPosition = _missionOpt select 1;
private["_missionDirection"];
_missionDirection = _missionOpt select 2;
private["_missionMarkerPosition"];
_missionMarkerPosition = _missionOpt select 3;
private["_missionMarkerRadius"];
_missionMarkerRadius = _missionOpt select 4;

/*---------------------------------------*/
/* Wenn notwendig die Clientside starten */
/*---------------------------------------*/
if (!isServer || !isDedicated) then
{
	private["_taskTitle"];
	_taskTitle = "Offizier eliminieren (GebÃ¤ude)";
	private["_taskDescription"];
	_taskDescription = "Ein feindlicher Offizier hat einen unserer verdeckten Ermittler aufgespÃ¼rt und diesen mit Aufdeckung erpresst. Momentan hat sich der Offizier mit einer Truppe in ein paar GebÃ¤uden verschanzt. Wir kÃ¶nnen kein weiteres Risiko eingehen. Eliminieren sie den Offizier.";
	
	private["_tmp"];
	_tmp = [_missionInfoIndex, _missionMarkerPosition, _missionMarkerRadius, _taskTitle, _taskDescription] execVM "missionsOpt\_common\runClient.sqf";	
};

if (isServer) then
{
	private["_units"];
	_units = [];
	
	
	private["_officer"];
	_officer = "O_officer_F" createVehicle _missionPosition;
	Sleep .2;
	_officer setdir random 360;
	_units = _units + [_officer];
	
	private["_guard1"];
	_guard1 = "O_recon_F" createVehicle _missionPosition;
	Sleep .2;
	_guard1 setdir random 360;
	_units = _units + [_guard1];


	
	private["_spawnGroup"];
	private["_randomPos"];
	private["_random"];
	private["_tmp"];
	_random = floor (random 3) + 1;
	for "_i" from 0 to _random do 
	{
		_randomPos = [[[_missionPosition, random 700 + 500]],["water","out"]] call BIS_fnc_randomPos;
		_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
		_tmp = [_spawnGroup, _missionPosition, random 400] call fn_missionsOpt_Patrol;
		_units = _units + (units _spawnGroup);
		 [_spawnGroup] call fn_missionsOpt_SetSkill;
		/* Nur im Debug */
		if (isServer && !isDedicated) then { [_spawnGroup, true, "ColorRed"] spawn fn_missionsRev_TrackGroup;};
	};

	_random = floor (random 2) + 1;
	for "_i" from 0 to _random do 	
	{
		_randomPos = [[[_missionPosition, random 150]],["water","out"]] call BIS_fnc_randomPos;
		_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
		[_officer] join _spawnGroup;
		
		_tmp = [_spawnGroup, _missionPosition, random 100] call fn_missionsOpt_Patrol;
		_units = _units + (units _spawnGroup);
		 [_spawnGroup] call fn_missionsOpt_SetSkill;
		/* Nur im Debug */
		if (isServer && !isDedicated) then { [_spawnGroup, true, "ColorRed"] spawn fn_missionsRev_TrackGroup;};
	};
	
	/*--------------------------------------*/
	/* Warten bis die Mission erfüllt wurde */
	/*--------------------------------------*/
	waitUntil {(!alive _officer) || (pixZones_ActiveIndex == -1)};
	
	/*--------------------------------------------------------*/
	/* Status auf beendet setzen und allen Clienten mitteilen */
	/*--------------------------------------------------------*/
	if (pixZones_ActiveIndex != -1) then
	{
		(pvehPixZones_MissionStatus select 1) set [_missionInfoIndex, 1]; /* erfolgreich */	
	}
	else
	{	
		(pvehPixZones_MissionStatus select 1) set [_missionInfoIndex, 2]; /* Fehlgeschlagen */
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
	{deletevehicle _x} foreach _units;
};