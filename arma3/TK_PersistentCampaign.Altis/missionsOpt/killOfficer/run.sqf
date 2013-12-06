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
	_taskTitle = "Offizier eliminieren";
	private["_taskDescription"];
	_taskDescription = "Ein feindlicher Offizier hat einen unserer verdeckten Ermittler aufgespÃ¼rt und diesen mit Aufdeckung erpresst. Momentan befindet sicher der Offizier gerade auf Patroulie im Feld. Wir kÃ¶nnen kein weiteres Risiko eingehen. Eliminieren sie den Offizier.";
	
	private["_tmp"];
	_tmp = [_missionInfoIndex, _missionMarkerPosition, _missionMarkerRadius, _taskTitle, _taskDescription] execVM "missionsOpt\_common\runClient.sqf";	
};

if (isServer) then
{
	private["_units"];
	_units = [];
	 	
	private["_unitTypes"];
	_unitTypes = ["O_officer_F","O_Soldier_AT_F","O_Soldier_AA_F","O_medic_F","O_recon_F","O_recon_F"];	
	private["_groupOfficer"];
	_groupOfficer = [_missionPosition, east, _unitTypes] call BIS_fnc_spawnGroup;		
	private["_tmp"];
	_tmp = [_groupOfficer, _missionPosition, random (missionsOpt_DefaultMarkerRadius/2)] call fn_missionsOpt_Patrol;
	[_groupOfficer] call fn_missionsOpt_SetSkill;
	_units = _units + (units _groupOfficer);	
	private["_officer"];
	_officer = _units select 0;

	private["_random"];
	_random = floor (random 4) + 1;
	for "_i" from 0 to _random do 
	{
		private["_randomPos"];
		_randomPos = [[[_missionPosition, random 700 + 500]],["water","out"]] call BIS_fnc_randomPos;
		private["_spawnGroup"];
		_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
		_tmp = [_spawnGroup, _missionPosition, random missionsOpt_DefaultMarkerRadius] call fn_missionsOpt_Patrol;
		_units = _units + (units _spawnGroup);
		 [_spawnGroup] call fn_missionsOpt_SetSkill;
		/* Nur im Debug */
		if (isServer && !isDedicated) then { [_spawnGroup] spawn fn_missionsRev_TrackGroup;};
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