private["_zoneIndex"];
_zoneIndex = _this select 0;
private["_missionInfoIndex"];
_missionInfoIndex = _this select 1;

/*----------------------------------*/
/* Die Missionsdaten herausarbeiten */
/*----------------------------------*/
private["_missionEnv"]; /* [missionIndex, missionPosition, missionStatus] */
_missionEnv = ((pvehPixZones_MissionInfos select 1) select _missionInfoIndex);
private["_missionPosition"];
_missionPosition = _missionEnv select 1;





/*--------------------------*/
/* Server oder ServerClient */
/*--------------------------*/
if (isServer) then
{
	private["_zoneIndex"];
	_zoneIndex = _this select 0;
	private["_groupSize"];
	_groupSize = _this select 1;
	private["_tmp"];
	
	private["_markerName"];
	_markerName = format["Zone%1", _zoneIndex];
	
	
	/* Aller verfügbaren Einheiten */
	private["_unitTypePool"];
	_unitTypePool = ["O_Soldier_AT_F","O_Soldier_AA_F","O_medic_F","O_engineer_F"];


	/* Jetzt verwendete einheiten */
	private["_unitTypes"];
	_unitTypes = ["O_Soldier_SL_F", "O_medic_F"];

	private["_currentPlayerCount"];
	_currentPlayerCount = 10;
	if (isDedicated) then { _currentPlayerCount = count playableUnits;};
	if (_currentPlayerCount <= 3) then
	{
		_unitTypes set [count _unitTypes, _unitTypePool select (floor(random (count _unitTypePool)))];
	};
	if (_currentPlayerCount <= 6) then
	{
		_unitTypes set [count _unitTypes, _unitTypePool select (floor(random (count _unitTypePool)))];
	};
	if (_currentPlayerCount <= 10) then
	{
		_unitTypes set [count _unitTypes, _unitTypePool select (floor(random (count _unitTypePool)))];
	};
	if (_currentPlayerCount <= 15) then
	{
		_unitTypes set [count _unitTypes, _unitTypePool select (floor(random (count _unitTypePool)))];
	};
	if (_currentPlayerCount <= 20) then
	{
		_unitTypes set [count _unitTypes, _unitTypePool select (floor(random (count _unitTypePool)))];
	};
	if (_currentPlayerCount <= 25) then
	{
		_unitTypes set [count _unitTypes, _unitTypePool select (floor(random (count _unitTypePool)))];
	};
	
	private["_group"];
	_group = [getMarkerPos _markerName, east, _unitTypes] call BIS_fnc_spawnGroup;		
	
	if (pixPatrolSkriptType == "UPS") then
	{
		_tmp = [leader _group, _markerName,"randomdn","min:2/max:2","nofollow","nowait","showmarker","NOTRIGGER"] execVM "missionsEnv\patrol\ups.sqf"; /*,"track"*/
	}
	else
	{
		private["_size"];
		_size = markerSize _markerName;
		if (_size select 0 > _size select 1) then { _size = _size select 1; } else { _size = _size select 0; };
		_tmp = [leader _group, 100, _size, _markerName, _markerName, _size, true, "SAFE", "RED", "LIMITED", "FILE", 0, 30, 0, [true,35,25,3,1]] execVM "missionsEnv\patrol\USPS.sqf";		
	};		

	/*Sleep 5;	
	player setPos (getpos (leader _group));*/
	
	/*--------------------------------------*/
	/* Warten bis die Mission erfüllt wurde */
	/*--------------------------------------*/
	waitUntil {(pixZones_ActiveIndex == -1)};
	player globalChat "zone beendet. patrol wird gelöscht";
	
	Sleep 10;
	
	{
		deleteVehicle _x;
	} foreach (units _group);
	deleteGroup _group;
};
