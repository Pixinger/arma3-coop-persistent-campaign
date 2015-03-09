if (ExecuteHeadlessCode) then
{
	private["_townObject"];
	_townObject = _this select 0;	
	private["_townCenter"];
	_townCenter = getPos _townObject;
	private["_townRadius"];
	_townRadius = _townObject getVariable "townRadius";
	private["_townName"];
	_townName = _townObject getVariable "townName";
	
	// -----------------------------------
	// Marker erstellen
	// -----------------------------------
	private["_townMarker"];
	_townMarker = createMarker[format["markerTownSideMission%1", _townName], _townCenter];
	_townMarker setMarkerShape "ICON";
	_townMarker setMarkerSize [10, 10];
	_townMarker setMarkerType "mil_destroy";
	_townMarker setMarkerText "Weaponcache";
	_townMarker setMarkerAlpha 1;	
	_townMarker setMarkerColor "ColorRed";
	
	
	private["_missionPosition"];
	_missionPosition = [_townCenter, _townRadius * 2] call fnc_TownSM_GetRandomPositionField;
	if (str(_missionPosition) != "[[0,0,0],0]") then
	{
		private["_groups"];
		_groups = [];
		private["_vehicles"];
		_vehicles = [];
		private["_buildings"];
		_buildings = [];
		private["_buildingClassnames"];
		_buildingClassnames = ["Box_East_WpsSpecial_F"];

		private["_ammobox1"];
		_ammobox1 = _buildingClassname createVehicle _missionPosition;
		_ammobox1 setdir random 360;
		_ammobox1 setVectorUp surfaceNormal (position _ammobox1);
		_ammobox1 allowDamage false;
		_buildings = _buildings + [_ammobox1];

		private["_ammobox2"];
		_ammobox2 = _buildingClassname createVehicle _missionPosition;
		_ammobox2 setdir random 360;
		_ammobox2 setVectorUp surfaceNormal (position _ammobox2);
		_ammobox2 allowDamage false;
		_buildings = _buildings + [_ammobox2];	

		private["_patrolCount"];
		_patrolCount = floor random (4);

		//-------------------------
		// Patroullierende Truppen 
		//-------------------------
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

		//-------------------------
		// Verteidigungs Truppe 
		//-------------------------
		private["_groupInfos"];
		_groupInfos = [["OIA_InfSquad","OIA_InfTeam","OIA_InfTeam_AT","OIA_MotInf_Team","OIA_MotInf_AT","OIA_InfSentry"], _missionPosition] call PC_fnc_SpawnGroupGuardObject;
		if (count _groupInfos > 0) then
		{
			_groups = _groups + [(_groupInfos select 0)];
			_vehicles = _vehicles + (_groupInfos select 1);
		};
		
		//-------------------------
		// Minenfelder 
		//-------------------------
		if (random (1) < 0.5) then
		{
			private["_mineFieldCount"];
			_mineFieldCount = 1 + floor(random 3);
			for "_i" from 0 to _mineFieldCount do 
			{
				[_missionPosition, ["APERSTripMine"]] call fnc_TownSM_CreateMineFieldRandom;
			};
		};
		

		//-------------------------
		// Mission Loop
		//-------------------------
		while { ((alive _ammobox1) && (alive _ammobox2)) } do
		{			
			Sleep 10;
		};
			
		
		[_groups, _vehicles, _buildings, true] call PC_fnc_CleanupMission;
		
	}
	else
	{
		diag_log "ERROR: Unable to create sidemission 'AmmoBox'.";
	};

	_townObject setVariable ["sideMission", 0];
	deleteMarker _townMarker;
};