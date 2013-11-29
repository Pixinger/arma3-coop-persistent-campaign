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
	/* Missionen auf Grund von Zufall & Spieleranzahl die Missionen bestimmen */
	/* => "_missionRevCfgIndices" */
	/*------------------------------------------------------------------------*/
	private["_missionRevCount"];
	_missionRevCount = count missionsRev_Missions;	
	private["_missionRevCfgIndices"];
	_missionRevCfgIndices = [];
	private["_missionRevPlayerCount"];
	_missionRevPlayerCount = 0;
	private["_index"];
	while { (_missionRevPlayerCount < _currentPlayerCount) } do 
	{
		_index = floor(random _missionRevCount);		
		_missionRevCfgIndices set [count _missionRevCfgIndices, _index];
		_missionRevPlayerCount = _missionRevPlayerCount + (missionsRev_MissionPlayers select _index);
	};
	
	/* Zum debuggen */
	if (isServer && !isDedicated) then
	{
		_missionRevCfgIndices = []; {_missionRevCfgIndices set [count _missionRevCfgIndices, count _missionRevCfgIndices];} foreach missionsRev_Missions;
	};
	
	private["_missionsRev"];/* [[missionEnvIndex, missionPosition, missionDirection, markerPosition, markerRadius],[..]] */
	_missionsRev = [];
	
	
	/*-------------------------------*/
	/* Missions Positionen berechnen */
	/* => "_missionRevLocations" */
	/*-------------------------------*/
	private["_missionRevLocations"];
	_missionRevLocations = [];
	private["_markerName"];
	_markerName = format["Zone%1", _zoneIndex];
	{
		private["_missionRevLocation"];
		_missionRevLocation = [_zoneIndex, _missionRevLocations] call compile preprocessFileLineNumbers format["missionsRev\%1\fn_GetMissionLocation.sqf", (missionsRev_Missions select _x)];
		_missionRevLocations = _missionRevLocations + _missionRevLocation;
	} foreach _missionRevCfgIndices;
	
	
	/*-----------------------------------------------*/
	/* Die Mission-REV Informationen zusammenstellen */
	/*-----------------------------------------------*/
	private["_missionsRev"]; /* [[missionRevCfgIndex, missionPosition, missionDirection],[..]] */
	_missionsRev = [];
	_index = 0;
	{
		/* Nur wenn eine gültige Position gefunden wurde,zum Missionsarray hinzufügen.*/
		if (str(_missionRevLocations select _index) != "[[0,0,0],0,[0,0,0],0]") then
		{
			_missionsRev set [count _missionsRev, [_x, (_missionRevLocations select _index) select 0, (_missionRevLocations select _index) select 1]];		
		}
		else
		{
			player sidechat format["missionOpt Index(%1) hat keine Position gefunden", _x];
		};
		_index = _index + 1;
	} foreach _missionRevCfgIndices;

	

	
	/*------------------------------------------------------------------------------------------------*/
	/* RESULT */
	/*------------------------------------------------------------------------------------------------*/
	/* Verpacken */
	/*-----------*/
	_result = [_zoneIndex, [], [], _missionsRev];
};
_result;