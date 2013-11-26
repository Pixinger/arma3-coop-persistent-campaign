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
	_currentPlayerCount = 10;
	if (isDedicated) then { _currentPlayerCount = count playableUnits;};

	/*------------------------------------------------------------------------------------------------*/
	/*------------------------------------------------------------------------------------------------*/
	/* MISSION ENV */
	/*------------------------------------------------------------------------------------------------*/
	/*------------------------------------------------------------------------------------------------*/
	/* Zu verwendende Environment Missionen bestimmen */
	/*------------------------------------------------*/
	private["_missionsEnv"];/* [[missionEnvIndex, missionPosition, missionDirection],[..]] */
	_missionsEnv = [];
	if (_currentPlayerCount <= 3) then
	{
		_missionsEnv set [count _missionsEnv, [0,[0,0,0],_zoneIndex]]; /* missionEnv-Index, location, direction */
		_missionsEnv set [count _missionsEnv, [0,[0,0,0],_zoneIndex]]; /* missionEnv-Index, location, direction */
	};
	if (_currentPlayerCount <= 6) then
	{
		_missionsEnv set [count _missionsEnv, [0,[0,0,0],_zoneIndex]]; /* missionEnv-Index, location, direction */
	};
	if (_currentPlayerCount <= 10) then
	{
		_missionsEnv set [count _missionsEnv, [0,[0,0,0],_zoneIndex]]; /* missionEnv-Index, location, direction */
	};
	if (_currentPlayerCount <= 15) then
	{
		_missionsEnv set [count _missionsEnv, [0,[0,0,0],_zoneIndex]]; /* missionEnv-Index, location, direction */
	};
	
	/* Zum debuggen */
	if (isServer && !isDedicated) then
	{
		_missionsEnv = [];
	};
	

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
	private["_missionOptPlayerCount"];
	_missionOptPlayerCount = 0;
	private["_index"];
	while { (_missionOptPlayerCount < _currentPlayerCount) } do 
	{
		_index = floor(random _missionOptCount);
		
		_missionOptCfgIndices set [count _missionOptCfgIndices, _index];
		_missionOptPlayerCount = _missionOptPlayerCount + (missionsOpt_MissionPlayers select _index);
	};
	
	/* Zum debuggen */
	if (isServer && !isDedicated) then
	{
		/*_missionOptCfgIndices = [0,1,2,3,4,5,6,7,8,9];*/
		_missionOptCfgIndices = [];{_missionOptCfgIndices set [count _missionOptCfgIndices, count _missionOptCfgIndices];} foreach missionsOpt_Missions;
	};
	
	
	/*-------------------------------*/
	/* Missions Positionen berechnen */
	/* => "_missionOptLocations" */
	/*-------------------------------*/
	private["_missionOptLocations"];
	_missionOptLocations = [];
	private["_markerName"];
	_markerName = format["Zone%1", _zoneIndex];
	{
		private["_missionLocation"];
		_missionLocation = [_zoneIndex, _missionOptLocations] call compile preprocessFileLineNumbers format["missionsOpt\%1\fn_GetMissionLocation.sqf", (missionsOpt_Missions select _x)];
		_missionOptLocations = _missionOptLocations + _missionLocation;
	} foreach _missionOptCfgIndices;
	
	/*-----------------------------------------------*/
	/* Die Mission-OPT Informationen zusammenstellen */
	/*-----------------------------------------------*/
	private["_missionsOpt"]; /* [[missionOptCfgIndex, missionPosition, missionDirection],[..]] */
	_missionsOpt = [];
	_index = 0;
	{
		/* Nur wenn eine gültige Position gefunden wurde,zum Missionsarray hinzufügen.*/
		if (str(_missionOptLocations select _index) != "[[0,0,0],0]") then
		{
			_missionsOpt set [count _missionsOpt, [_x, (_missionOptLocations select _index) select 0, (_missionOptLocations select _index) select 1]];		
		}
		else
		{
			player sidechat format["missionOpt Index(%1) hat keine Position gefunden", _x];
		};
		_index = _index + 1;
	} foreach _missionOptCfgIndices;
	
	
	
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