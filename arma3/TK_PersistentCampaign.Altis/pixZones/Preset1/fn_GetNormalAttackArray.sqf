/* Diese Funktion erstellt ein MissionsInfo-Array, dass dann in der Regel in die Variable "pvehPixZones_MissionInfos" geschrieben wird. */

private["_result"];
_result = [];
if (isServer) then
{
	/* Weil es ein Preset ist, wird hier noch der Index der eigentlich aufgerufenen Zone angegeben */
	private["_zoneIndex"]; 
	_zoneIndex = _this select 0;
	
	/* Anzahl der Spieler berechnen um den Schwierigkeitsgrad bestimmen zu können */
	private["_currentPlayerCount"];
	_currentPlayerCount = call PC_fnc_GetPlayerCount;

	/*------------------------------------------------------------------------------------------------*/
	/*------------------------------------------------------------------------------------------------*/
	/* MISSION ENV */
	/*------------------------------------------------------------------------------------------------*/
	/*------------------------------------------------------------------------------------------------*/
	/* Zu verwendende Environment Missionen bestimmen */
	/*------------------------------------------------*/
	private["_missionsEnv"];/* [[missionEnvIndex, missionPosition, missionDirection],[..]] */
	_missionsEnv = [];
	if (_currentPlayerCount >= 3) then
	{
		_missionsEnv set [count _missionsEnv, [0,[0,0,0],_zoneIndex]]; /* missionEnv-Index, location, direction */
		_missionsEnv set [count _missionsEnv, [0,[0,0,0],_zoneIndex]]; /* missionEnv-Index, location, direction */
		_missionsEnv set [count _missionsEnv, [0,[0,0,0],_zoneIndex]]; /* missionEnv-Index, location, direction */
		_missionsEnv set [count _missionsEnv, [0,[0,0,0],_zoneIndex]]; /* missionEnv-Index, location, direction */
	};
	if (_currentPlayerCount >= 6) then
	{
		_missionsEnv set [count _missionsEnv, [0,[0,0,0],_zoneIndex]]; /* missionEnv-Index, location, direction */
		_missionsEnv set [count _missionsEnv, [0,[0,0,0],_zoneIndex]]; /* missionEnv-Index, location, direction */
		_missionsEnv set [count _missionsEnv, [0,[0,0,0],_zoneIndex]]; /* missionEnv-Index, location, direction */
	};
	if (_currentPlayerCount >= 10) then
	{
		_missionsEnv set [count _missionsEnv, [0,[0,0,0],_zoneIndex]]; /* missionEnv-Index, location, direction */
		_missionsEnv set [count _missionsEnv, [0,[0,0,0],_zoneIndex]]; /* missionEnv-Index, location, direction */
	};
	if (_currentPlayerCount >= 15) then
	{
		_missionsEnv set [count _missionsEnv, [0,[0,0,0],_zoneIndex]]; /* missionEnv-Index, location, direction */
		_missionsEnv set [count _missionsEnv, [0,[0,0,0],_zoneIndex]]; /* missionEnv-Index, location, direction */
	};
	
	/* Zum debuggen */
	if (isServer && !isDedicated) then
	{
		/*_missionsEnv = [];*/
	};

	diag_log format["INFO: _missionsEnv = %1", _missionsEnv];
	

	/*------------------------------------------------------------------------------------------------*/
	/*------------------------------------------------------------------------------------------------*/
	/* MISSION OPT */
	/*------------------------------------------------------------------------------------------------*/
	/*------------------------------------------------------------------------------------------------*/
	/* Missionen auf Grund von Zufall & Spieleranzahl die Missionen bestimmen */
	/* => "_missionIndices" */
	/*------------------------------------------------------------------------*/
	private["_missionOptCount"];
	_missionOptCount = count missionsOpt_Missions;
	
	private["_missionOptCfgIndices"];
	_missionOptCfgIndices = [];
	private["_missionOptLocations"];
	_missionOptLocations = [];
	
	private["_missionOptPlayerCount"];
	_missionOptPlayerCount = 0;
	private["_loopLimit"];
	_loopLimit = 500;
	while { (_missionOptPlayerCount < (_currentPlayerCount * pixParamMissionFactor)) && (_loopLimit > 0) } do 
	{
		_loopLimit = _loopLimit - 1;
		
		/* zufälligen Index bestimmen */
		private["_index"];
		_index = floor(random _missionOptCount);
		
		/* Mission Location zu diesem Index bestimmen */
		private["_missionLocation"];
		_missionLocation = [_zoneIndex, _missionOptLocations] call compile preprocessFileLineNumbers format["missionsOpt\%1\fn_GetMissionLocation.sqf", (missionsOpt_Missions select _index)];

		/* Wenn eine gültige Location gefunden wurde, dann zu Index und Location Array hinzufügen */
		if (str(_missionLocation) != "[[0,0,0],0,[0,0,0],0]") then
		{
			_missionOptCfgIndices set [count _missionOptCfgIndices, _index];
			_missionOptLocations set [count _missionOptLocations, _missionLocation];
			_missionOptPlayerCount = _missionOptPlayerCount + (missionsOpt_MissionPlayers select _index);
		};			
	};
	
	/* Zum Debuggen */
/*	if (isServer && !isDedicated) then
	{
		/* Missionen festlegen */
/*		_missionOptCfgIndices = [];{_missionOptCfgIndices set [count _missionOptCfgIndices, count _missionOptCfgIndices];} foreach missionsOpt_Missions;
		/*_missionOptCfgIndices = [10];*/
		
		/* Locations berechnen */
/*		{
			private["_missionLocation"];
			_missionLocation = [_zoneIndex, _missionOptLocations] call compile preprocessFileLineNumbers format["missionsOpt\%1\fn_GetMissionLocation.sqf", (missionsOpt_Missions select _x)];
			_missionOptLocations set [count _missionOptLocations, _missionLocation];
		} foreach _missionOptCfgIndices;
	};*/
	
	
	
	/*-----------------------------------------------*/
	/* Die Mission-OPT Informationen zusammenstellen */
	/*-----------------------------------------------*/
	private["_missionsOpt"]; /* [[missionOptCfgIndex, missionPosition, missionDirection, markerPosition, markerRadius],[..]] */
	_missionsOpt = [];
	private["_index"];
	_index = 0;
	{
		/* Nur wenn eine gültige Position gefunden wurde,zum Missionsarray hinzufügen.*/
		if (str(_missionOptLocations select _index) != "[[0,0,0],0,[0,0,0],0]") then
		{
			_missionsOpt set [count _missionsOpt, [_x, (_missionOptLocations select _index) select 0, (_missionOptLocations select _index) select 1, (_missionOptLocations select _index) select 2, (_missionOptLocations select _index) select 3]];		
		}
		else
		{
			diag_log format["ERROR: missionOpt Index(%1) hat keine Position gefunden: (%2)", _index, (_missionOptLocations select _index)];
		};
		_index = _index + 1;
	} foreach _missionOptCfgIndices;
	diag_log format["INFO: _missionsOpt = %1", _missionsOpt];
	
	
	
	/*------------------------------------------------------------------------------------------------*/
	/*------------------------------------------------------------------------------------------------*/
	/* RESULT */
	/*------------------------------------------------------------------------------------------------*/
	/*------------------------------------------------------------------------------------------------*/
	/* Verpacken */
	/*-----------*/
	_result = [_zoneIndex, _missionsEnv, _missionsOpt, []];
};
_result;