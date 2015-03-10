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
	
	// Auswirkungen:
	// 20: Mission Start
	// 21: Mission fehlgeschlagen
	// 22: Mission erfolgreich		
	_townObject setVariable ["sideMission", 21];	
	
	// -----------------------------------
	// Marker erstellen
	// -----------------------------------
	private["_townMarker"];
	_townMarker = createMarker[format["markerTownSideMission%1", _townName], _townCenter];
	_townMarker setMarkerShape "ICON";
	_townMarker setMarkerSize [10, 10];
	_townMarker setMarkerType "mil_destroy";
	_townMarker setMarkerText "Waffenlager";
	_townMarker setMarkerAlpha 1;	
	_townMarker setMarkerColor "ColorRed";
	
	
	private["_missionPosition"];
	_missionPosition = [_townCenter, _townRadius * 2] call fnc_TownSM_GetRandomPositionField;
	if (str(_missionPosition) != "[[0,0,0],0]") then
	{
		private["_buildingClassnames"];
		_buildingClassnames = ["Box_East_WpsSpecial_F"];

		private["_ammobox1"];
		_ammobox1 = _buildingClassname createVehicle _missionPosition;
		_ammobox1 setdir random 360;
		_ammobox1 setVectorUp surfaceNormal (position _ammobox1);
		_ammobox1 allowDamage false;

		private["_ammobox2"];
		_ammobox2 = _buildingClassname createVehicle _missionPosition;
		_ammobox2 setdir random 360;
		_ammobox2 setVectorUp surfaceNormal (position _ammobox2);
		_ammobox2 allowDamage false;

		//-------------------------
		// Verteidigungs Truppe 
		//-------------------------
		private ["_groupDefend"];
		_groupDefend = createGroup pixTown_ConfigSideRed;		
		private["_unitsDefend"];
		_unitsDefend = [_groupDefend, _missionPosition, pixTown_ConfigRedClassnames, 5] call fnc_TownSM_CreateGroup;		
		[_groupDefend, _missionPosition] call bis_fnc_taskDefend;

		//-------------------------
		// Patrol Truppe 
		//-------------------------
		private ["_groupPatrol"];
		_groupPatrol = createGroup pixTown_ConfigSideRed;		
		private["_unitsPatrol"];
		_unitsPatrol = [_groupPatrol, _missionPosition, pixTown_ConfigRedClassnames, 5] call fnc_TownSM_CreateGroup;		
		[_groupPatrol, _missionPosition] call bis_fnc_taskDefend;

		//-------------------------
		// Minenfeld
		//-------------------------
		if (random (1) < 0.5) then
		{
			[_missionPosition, ["APERSTripMine"]] call fnc_TownSM_CreateMineFieldRandom;
		};

		//-------------------------
		// Mission Loop
		//-------------------------
		while { ((alive _ammobox1) && (alive _ammobox2)) } do
		{			
			Sleep 10;
		};

		_townObject setVariable ["sideMission", 22]; // erfolgreich
		deleteMarker _townMarker;
		Sleep 5*60;

		// Löschen und freigeben
		{ deleteVehicle _x; } foreach _unitsDefend;
		deleteGroup _groupDefend;
		{ deleteVehicle _x; } foreach _unitsPatrol;
		deleteGroup _groupPatrol;
	}
	else
	{
		_townObject setVariable ["sideMission", 22]; // erfolgreich
		deleteMarker _townMarker;
		diag_log "ERROR: Unable to create sidemission 'Waffenlager'.";
	};		
};
