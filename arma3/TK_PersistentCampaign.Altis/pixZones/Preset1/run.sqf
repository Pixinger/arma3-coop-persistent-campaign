/*---------------------------------------------------------------------*/
/* Diese Funktion erstellt eine Standard Missionsvorlage für eine Zone */
/*---------------------------------------------------------------------*/
private["_result"];
_result = [];
if (isServer) then
{
	private["_zoneIndex"];
	_zoneIndex = _this select 0;
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
	/*_missionsEnv = [];*/
	

	/*------------------------------------------------------------------------------------------------*/
	/*------------------------------------------------------------------------------------------------*/
	/* MISSION OPT */
	/*------------------------------------------------------------------------------------------------*/
	/*------------------------------------------------------------------------------------------------*/
	/* Missionen auf Grund von Zufall & Spieleranzahl die Missionen bestimmen */
	/* => "_missionIndices" */
	/*------------------------------------------------------------------------*/
	private["_missionCount"];
	_missionCount = count missionsOpt_Missions;
	
	private["_missionIndices"];
	_missionIndices = [];
	private["_missionPlayerCount"];
	_missionPlayerCount = 0;
	private["_index"];
	while { (_missionPlayerCount < _currentPlayerCount) } do 
	{
		_index = floor(random _missionCount);
		
		_missionIndices set [count _missionIndices, _index];
		_missionPlayerCount = _missionPlayerCount + (missionsOpt_MissionPlayers select _index);
	};
	
	/* Zum debuggen */
	if (isServer && !isDedicated) then
	{
		/*_missionIndices = [0,1,2,3,4,5,6,7,8,9];*/
		_missionIndices = [];{_missionIndices set [count _missionIndices, count _missionIndices];} foreach missionsOpt_Missions;
	};
	
	
	/*-------------------------------*/
	/* Missions Positionen berechnen */
	/* => "_missionLocations" */
	/*-------------------------------*/
	private["_missionLocations"];
	_missionLocations = [];
	private["_missionCount"];
	_missionCount = count _missionIndices;
	private["_markerName"];
	_markerName = format["Zone%1", _zoneIndex];
	{
		private["_missionLocation"];
		_missionLocation = [_zoneIndex, _missionLocations] call compile preprocessFileLineNumbers format["missionsOpt\%1\fn_GetMissionLocation.sqf", (missionsOpt_Missions select _x)];
		_missionLocations = _missionLocations + _missionLocation;
	} foreach _missionIndices;
	
	/*-----------------------------------------------*/
	/* Die Mission-OPT Informationen zusammenstellen */
	/*-----------------------------------------------*/
	private["_missionsOpt"]; /* [[missionOptIndex, missionPosition, missionDirection],[..]] */
	_missionsOpt = [];
	private["_optIndex"];
	_optIndex = 0;
	{
		/* Nur wenn eine gültige Position gefunden wurde,zum Missionsarray hinzufügen.*/
		if (str(_missionLocations select _optIndex) != "[[0,0,0],0]") then
		{
			_missionsOpt set [count _missionsOpt, [_x, (_missionLocations select _optIndex) select 0, (_missionLocations select _optIndex) select 1]];		
		}
		else
		{
			player sidechat format["missionOpt Index(%1) hat keine Position gefunden", _x];
		};
		_optIndex = _optIndex + 1;
	} foreach _missionIndices;
	
	
	/*------------------------------------------------------------------------------------------------*/
	/*------------------------------------------------------------------------------------------------*/
	/* RESULT */
	/*------------------------------------------------------------------------------------------------*/
	/*------------------------------------------------------------------------------------------------*/
	/* Verpacken */
	/*-----------*/
	_result = [_zoneIndex, _missionsEnv, _missionsOpt];
};
_result;

