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
	_taskTitle = "Materialkisten zerstÃ¶ren";
	private["_taskDescription"];
	_taskDescription = "Unser Nachrichtendienst hat Informationen abgefangen die darauf hinweisen, dass im Zielgebiet neue Technologie getestet werden soll. Laut den Informationen der verdeckten Ermittler, handelt es sich dabei um Material welche in zwei Kisten transportiert wird. ZerstÃ¶ren Sie diese Materialkisten. Es ist mit Feindlicher Infantrie zu rechnen, welche zur Bewachung abgestellt wurde.";
	private["_tmp"];
	_tmp = [_missionInfoIndex, _missionMarkerPosition, _missionMarkerRadius, _taskTitle, _taskDescription] execVM "missionsOpt\_common\runClient.sqf";	
};

if (isServer) then
{
	private["_units"];
	_units = [];
	
	
	private["_ammobox1"];
	_ammobox1 = "Box_East_WpsSpecial_F" createVehicle _missionPosition;
	_ammobox1 setdir random 360;
	_ammobox1 setVectorUp surfaceNormal (position _ammobox1);
	_units = _units + [_ammobox1];

	private["_ammobox2"];
	_ammobox2 = "Box_East_WpsSpecial_F" createVehicle _missionPosition;
	_ammobox2 setdir random 360;
	_ammobox2 setVectorUp surfaceNormal (position _ammobox2);
	_units = _units + [_ammobox2];
	

	private["_spawnGroup"];
	private["_randomPos"];
	/* Anzahl der Spieler berechnen um den Schwierigkeitsgrad bestimmen zu können */
	private["_currentPlayerCount"];
	_currentPlayerCount = 10;
	if (isDedicated) then { _currentPlayerCount = count playableUnits;};
	private["_patrolCount"];
	_patrolCount = ceil(_currentPlayerCount / 4);
	for "_i" from 0 to _patrolCount do 
	{
		private["_teamTypes"];
		_teamTypes = ["OIA_InfSquad","OIA_InfTeam","OIA_InfTeam_AT","OIA_MotInfTeam","OIA_MotInf_AT"];
		_randomPos = [[[_missionPosition, random 600 + 300]],["water","out"]] call BIS_fnc_randomPos;
		_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> (_teamTypes select floor(random(count _teamTypes))))] call BIS_fnc_spawnGroup;
		private["_tmp"];
		_tmp = [_spawnGroup, _missionPosition, random 600] call fn_missionsOpt_Patrol;
		_units = _units + (units _spawnGroup);
		 [_spawnGroup] call fn_missionsOpt_SetSkill;
		/* Nur im Debug */
		if (isServer && !isDedicated) then { [_spawnGroup] spawn fn_missionsRev_TrackGroup;};
	};


	/* Verteidigungs Truppe */
	private["_teamTypes"];
	_teamTypes = ["OIA_InfSquad","OIA_InfTeam","OIA_InfTeam_AT","OIA_MotInfTeam","OIA_MotInf_AT","OIA_InfSentry"];				
	_randomPos = [[[_missionPosition, random 80]],["water","out"]] call BIS_fnc_randomPos;	
	_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> (_teamTypes select floor(random(count _teamTypes)))] call BIS_fnc_spawnGroup;
	[_spawnGroup, _missionPosition] call BIS_fnc_taskDefend;
	_units = _units + (units _spawnGroup);
	 [_spawnGroup] call fn_missionsOpt_SetSkill;
	/* Nur im Debug */
	if (isServer && !isDedicated) then { [_spawnGroup] spawn fn_missionsRev_TrackGroup;};

	_ammobox1 setDamage 0.5;
	_ammobox2 setDamage 0.5;
	if (_ammobox1 distance [0,0,0] < 1000) then { _ammobox1 setDamage 1;};
	if (_ammobox2 distance [0,0,0] < 1000) then { _ammobox2 setDamage 1;};
	
	/*--------------------------------------*/
	/* Warten bis die Mission erfüllt wurde */
	/*--------------------------------------*/
	waitUntil {((!alive _ammobox1) && (!alive _ammobox2)) || (pixZones_ActiveIndex == -1)};
	
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