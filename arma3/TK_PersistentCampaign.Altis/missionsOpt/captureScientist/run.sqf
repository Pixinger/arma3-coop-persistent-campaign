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
_missionDirection = _missionOpt select 2; /* Wird hier verwendet um den Unit Typen zu bestimmen */
private["_missionMarkerPosition"];
_missionMarkerPosition = _missionOpt select 3;
private["_missionMarkerRadius"];
_missionMarkerRadius = _missionOpt select 4;


/*---------------------------*/
/* Unit Typen definieren */
/*---------------------------*/
private["_unitClassnames"];
_unitClassnames = ["C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_p_fugitive_F","C_man_w_worker_F"];

/* Aus der zufälligen Richtung den Klassennamen errechnen */
private["_unitClassnameIndex"];
_unitClassnameIndex = floor (((count _unitClassnames) / 360) * _missionDirection);
if (_unitClassnameIndex < 0) then { _unitClassnameIndex = 0;};
if (_unitClassnameIndex >= count _unitClassnames) then { _unitClassnameIndex = (count _unitClassnames) - 1;};

private["_unitClassname"];
_unitClassname = _unitClassnames select _unitClassnameIndex;


/*---------------------------------------*/
/* Wenn notwendig die Clientside starten */
/*---------------------------------------*/
if (!isServer || !isDedicated) then
{
	[] spawn {
		/*-------------------------*/
		/* Missions vorbereitungen */
		/*-------------------------*/
		/* Objekte suchen (warten bis erzeugt) */
		private["_counter"];
		_counter = 20;
		private["_objects"];
		_objects = [];
		while { (count _objects != 1) && (_counter > 0) } do
		{
			Sleep 0.5;
			_objects = nearestObjects [_missionPosition, [_unitClassname], 50];
			_counter = _counter - 1;
		};
		
		/* Action Menü zu den Objekten hinzufügen */
		{ _x addAction["Gefangen nehmen", "missionsOpt\_common\actionTakeCaptive.sqf"]; } foreach _objects;
		
		/*----------------------------------------*/
		/* Standart Missions verarbeitung starten */
		/*----------------------------------------*/
		private["_taskTitle"];
		_taskTitle = "Gefangennahme";
		private["_taskDescription"];
		_taskDescription = "Unser Geheimdienst hat Hinweise auf einen Wissenschaftler, der auf unsere Seite überlaufen möchte. Leider hat die Gegenseite diesen momentan in Gewahrsam. Befreien sie den Wissenschaftler und bringen sie ihn aus dem feindlichen Gebiet.";
		
		private["_tmp"];
		_tmp = [_missionInfoIndex, _missionMarkerPosition, _missionMarkerRadius, _taskTitle, _taskDescription] execVM "missionsOpt\_common\runClient.sqf";	
	};
};

if (isServer) then
{
	private["_groups"];
	_groups = [];
	private["_vehicles"];
	_vehicles = [];
	private["_buildings"];
	_buildings = [];	
	
	/*------------------------------*/
	/* Gruppe des Officers erzeugen */
	/*------------------------------*/
	private["_groupScientist"];
	_groupScientist = [_missionPosition, civilian, [_unitClassname]] call BIS_fnc_spawnGroup;	
	Sleep .2;
	_groups = _groups + [_groupScientist];	
	private["_scientist"];
	_scientist = (units _groupScientist) select 0;
	_scientist setCaptive true;
	[_groupScientist] call PC_fnc_SetSkill;	
	
	private["_house"];
	_house = nearestObject[_missionPosition, "House"];
	if (!isNull _house) then
	{
		private["_maxIndex"];
		_maxIndex = 0;
		while { str(_house buildingPos _maxIndex) != "[0,0,0]" } do { _maxIndex = _maxIndex + 1;};

		private["_bpos"];
		_bpos = _house buildingPos (floor random (_maxIndex));
		_scientist setPos _bpos;
		doStop _scientist;
	};
	
	/*----------------------------------------------------------------------------*/
	/* Anzahl der Spieler berechnen um den Schwierigkeitsgrad bestimmen zu können */
	/*----------------------------------------------------------------------------*/
	private["_patrolCount"];
	_patrolCount = ceil((call PC_fnc_GetPlayerCount) / 6);

	/*-------------------------*/
	/* Patroullierende Truppen */
	/*-------------------------*/
	for "_i" from 0 to _patrolCount do 
	{
		private["_groupInfos"];
		_groupInfos = [["OIA_InfSquad","OIA_InfTeam","OIA_InfTeam_AT","OIA_MotInf_Team","OIA_MotInf_AT"], _zoneIndex, _missionPosition, 600, 25] call PC_fnc_SpawnGroupPatrolObject;		
		if (count _groupInfos > 0) then
		{
			_groups = _groups + [(_groupInfos select 0)];
			_vehicles = _vehicles + (_groupInfos select 1);
		};
	};
	
	/*-------------*/
	/* Minenfelder */
	/*-------------*/
	private["_mineFieldCount"];
	_mineFieldCount = 1 + floor(random 2);
	for "_i" from 0 to _mineFieldCount do 
	{
		[_missionPosition, ["APERSMine","APERSBoundingMine","APERSTripMine"]] call PC_fnc_CreateMineFieldAtTarget;
	};

	/*--------------------------------------*/
	/* Warten bis die Mission erfüllt wurde */
	/*--------------------------------------*/
	private["_continue"];
	_continue = true;
	while { _continue } do
	{
		if (!alive _scientist) then { _continue = false; };
		if (pixZones_ActiveIndex == -1) then { _continue = false; };
		if (!([_zoneIndex, getPos _scientist] call PC_fnc_IsPositionInZone)) then { _continue = false; };
		Sleep 5;
	};
		
	/*--------------------------------------------------------*/
	/* Status auf beendet setzen und allen Clienten mitteilen */
	/*--------------------------------------------------------*/
	/*[_missionInfoIndex] call PC_fnc_FinishMissionStatus;*/
	if ((!alive _scientist) || (pixZones_ActiveIndex == -1)) then
	{
		(pvehPixZones_MissionStatus select 1) set [_missionInfoIndex, 2]; /* Fehlgeschlagen */
	}
	else
	{
		(pvehPixZones_MissionStatus select 1) set [_missionInfoIndex, 1]; /* erfolgreich */	
	};
	publicVariable "pvehPixZones_MissionStatus";
	if (!isDedicated) then { call compile preprocessFileLineNumbers "pixZones\pvehPixZones_MissionStatus.sqf"; }; /* PublicVariableEventHandler simulieren */


	/*-------------------------------------------------------------------------------------------------------------*/
	/* Warten bis Zone beendet. Dann nocheinmal zufällige Zeitverzögerung, damit nicht alle gleichzeitig aufräumen */
	/*-------------------------------------------------------------------------------------------------------------*/
	waitUntil {pixZones_ActiveIndex == -1 };
	sleep (random 60);
	[_groups, _vehicles, _buildings, true] call PC_fnc_CleanupMission;
};