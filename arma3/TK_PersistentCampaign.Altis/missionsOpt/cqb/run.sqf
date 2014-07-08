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
	_taskTitle = "Häuserkampf";
	private["_taskDescription"];
	_taskDescription = "Eliminieren sie alle feindlichen Einheiten im markierten Bereich!";
	
	private["_tmp"];
	_tmp = [_missionInfoIndex, _missionMarkerPosition, _missionMarkerRadius, _taskTitle, _taskDescription] execVM "missionsOpt\_common\runClient.sqf";	
};

if (isServer) then
{
	private["_relevantGroups"];
	_relevantGroups = [];
	private["_civilianGroups"];
	_civilianGroups = [];
	private["_vehicles"];
	_vehicles = [];
	private["_buildings"];
	_buildings = [];	
	
	/*----------------------------------------------------------------------------*/
	/* Anzahl der Spieler berechnen um den Schwierigkeitsgrad bestimmen zu können */
	/*----------------------------------------------------------------------------*/
	private["_staticCount"];
	_staticCount = ceil((call PC_fnc_GetPlayerCount) * 1.5);

	/*----------------------------------*/
	/* Vorbereitungen für die Einheiten */
	/*----------------------------------*/
	private["_unittypes"];
	_unittypes = ["O_Soldier_SL_F", "O_Soldier_AT_F", "O_medic_F", "O_Soldier_AR_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_F"];
	private["_unittypesCiv"];
	_unittypesCiv = ["C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_2_F", "C_man_shorts_1_F","C_man_shorts_2_F","C_man_shorts_3_F","C_man_p_shorts_1_F","C_man_p_fugitive_F","C_man_p_beggar_F"];

	/*-------------------------------------*/
	/* Einheiten in den Gebäuden erstellen */
	/*-------------------------------------*/
	for "_i" from 0 to _staticCount do 
	{
		private["_houses"];
		_houses = nearestObjects[_missionPosition, ["House"], _missionMarkerRadius - 20];
		if (count _houses > 0) then
		{
			/* Zufälliges Haus bestimmen */
			private["_house"];
			_house = _houses select (floor (random (count _houses)));
			/* Anzahl der Positionen in dem Haus errechnen */
			private["_maxIndex"];
			_maxIndex = 0;
			while { str(_house buildingPos _maxIndex) != "[0,0,0]" } do { _maxIndex = _maxIndex + 1;};			
			/* Zufällige Position aussuchen */
			private["_buildingPos"];
			_buildingPos = _house buildingPos (floor random (_maxIndex));
			
			/* Einheit an diese Position erstellen */
			private["_group"];
			_group = createGroup east;
			private["_unit"];
			_unit = _group createUnit [_unittypes select (floor(random(count _unittypes))), _buildingPos, [], 0, "NONE"];
			sleep .2;
			_relevantGroups = _relevantGroups + [_group];
			_unit setPos _buildingPos;
			doStop _unit;			
			[_group] call PC_fnc_SetSkill;	
			/* Im Debug die Gruppe mit einem Marker tracken */
			if (!isDedicated) then { [_group, false, "ColorRed","CQB"] spawn PC_fnc_TrackGroup; };			
		};
	};	
	/*-------------------------------------------*/
	/* Einheiten in den Gebäuden erstellen (CIV) */
	/*-------------------------------------------*/
	for "_i" from 0 to _staticCount do 
	{
		private["_houses"];
		_houses = nearestObjects[_missionPosition, ["House"], _missionMarkerRadius - 20];
		if (count _houses > 0) then
		{
			/* Zufälliges Haus bestimmen */
			private["_house"];
			_house = _houses select (floor (random (count _houses)));
			/* Anzahl der Positionen in dem Haus errechnen */
			private["_maxIndex"];
			_maxIndex = 0;
			while { str(_house buildingPos _maxIndex) != "[0,0,0]" } do { _maxIndex = _maxIndex + 1;};			
			/* Zufällige Position aussuchen */
			private["_buildingPos"];
			_buildingPos = _house buildingPos (floor random (_maxIndex));
			
			/* Einheit an diese Position erstellen */
			private["_group"];
			_group = createGroup east;
			private["_unit"];
			_unit = _group createUnit [_unittypesCiv select (floor(random(count _unittypesCiv))), _buildingPos, [], 0, "NONE"];
			sleep .2;
			_civilianGroups = _civilianGroups + [_group];
			_unit setPos _buildingPos;
			doStop _unit;			
			_unit setSkill 0;
			/* Im Debug die Gruppe mit einem Marker tracken */
			if (!isDedicated) then { [_group, false, "ColorBlue","civ"] spawn PC_fnc_TrackGroup; };			
		};
	};	
	
	/*-------------------------*/
	/* Patroullierende Truppen */
	/*-------------------------*/
	for "_i" from 0 to 1 do 
	{
		private["_groupInfos"];
		_groupInfos = [["OIA_InfTeam","OIA_InfTeam_AT"], _zoneIndex, _missionPosition, _missionMarkerRadius, 25] call PC_fnc_SpawnGroupPatrolObject;		
		if (count _groupInfos > 0) then
		{
			_relevantGroups = _relevantGroups + [(_groupInfos select 0)];
			_vehicles = _vehicles + (_groupInfos select 1);
		};
	};
	for "_i" from 0 to 1 do 
	{
		private["_groupInfos"];
		_groupInfos = [["OIA_InfTeam"], _zoneIndex, _missionPosition, _missionMarkerRadius, 25] call PC_fnc_SpawnGroupPatrolHouse;		
		if (count _groupInfos > 0) then
		{
			_relevantGroups = _relevantGroups + [(_groupInfos select 0)];
			_vehicles = _vehicles + (_groupInfos select 1);
		};
	};
	for "_i" from 0 to 1 do 
	{
		private["_groupInfos"];
		_groupInfos = [["OIA_InfTeam"], _zoneIndex, _missionPosition, _missionMarkerRadius, 25] call PC_fnc_SpawnGroupPatrolRoad;		
		if (count _groupInfos > 0) then
		{
			_relevantGroups = _relevantGroups + [(_groupInfos select 0)];
			_vehicles = _vehicles + (_groupInfos select 1);
		};
	};

	/*--------------------------------------*/
	/* Warten bis die Mission erfüllt wurde */
	/*--------------------------------------*/
	private["_relevantUnits"];
	_relevantUnits = [];
	{
		_relevantUnits = _relevantUnits + (units _x);		
	} foreach _relevantGroups;
	
	private["_relevantCivUnits"];
	_relevantCivUnits = [];
	{
		_relevantCivUnits = _relevantCivUnits + (units _x);		
	} foreach _civilianGroups;
	
	private["_aliveUnits"];
	_aliveUnits = 65000;
	private["_deadCivUnits"];
	_deadCivUnits = 0;
	private["_maxDeadCivs"];
	_maxDeadCivs = 5; /* 5= 4 allowed. 5 will exit. */
	private["_relevantUnitsCount"];
	_relevantUnitsCount = ((count _relevantUnits) / 20);
	while { (_deadCivUnits < _maxDeadCivs) && (_aliveUnits > _relevantUnitsCount) && (pixZones_ActiveIndex != -1) } do
	{
		Sleep 5;
		_aliveUnits = 0;
		_deadCivUnits = 0;
		{ if (alive _x) then { _aliveUnits = _aliveUnits + 1;};} foreach _relevantUnits;
		{ if (!alive _x) then { _deadCivUnits = _deadCivUnits + 1;};} foreach _relevantCivUnits;	
		player globalchat format["alive enemy: %1 dead civ: %2",_aliveUnits,_deadCivUnits];
	};	
	/*--------------------------------------------------------*/
	/* Status auf beendet setzen und allen Clienten mitteilen */
	/*--------------------------------------------------------*/
	/*[_missionInfoIndex] call PC_fnc_FinishMissionStatus;*/
	if ((_deadCivUnits >= _maxDeadCivs) || (pixZones_ActiveIndex == -1)) then
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
	sleep 120 + (random 60);
	[_relevantGroups, _vehicles, _buildings, true] call PC_fnc_CleanupMission;
};