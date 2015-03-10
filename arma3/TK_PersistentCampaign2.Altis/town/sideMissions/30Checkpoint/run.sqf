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
	_townObject setVariable ["sideMission", 31];	
	
	// -----------------------------------
	// Marker erstellen
	// -----------------------------------
	private["_townMarker"];
	_townMarker = createMarker[format["markerTownSideMission%1", _townName], _townCenter];
	_townMarker setMarkerShape "ICON";
	_townMarker setMarkerSize [10, 10];
	_townMarker setMarkerType "mil_destroy";
	_townMarker setMarkerText "Strassensperre";
	_townMarker setMarkerAlpha 1;	
	_townMarker setMarkerColor "ColorRed";
	
	
	private["_missionPosition"];
	_missionPosition = [_townCenter, _townRadius * 2] call fnc_TownSM_GetRandomPositionRoad;
	if (str(_missionPosition) != "[[0,0,0],0]") then
	{
		private["_missionDirection"];
		_missionDirection = _missionPosition select 1;
		_missionPosition = _missionPosition select 0;
		_missionPosition set [2,0];

		// Als erstes die Schranke erstellen, da sich alles um diese Schranke dreht. 
		private["_bargate"];
		_bargate = createVehicle ["Land_BarGate_F", _missionPosition, [], 0, "NONE"];
		Sleep .2;
		_bargate setDir _missionDirection;	 
		_bargate setPos _missionPosition;
		private["_tmp"];
		_tmp = _bargate addEventHandler ["HandleDamage", {false}];
		// Position korrigieren, da die Schranke nicht mittig steht 
		_missionPosition = _bargate modelToWorld [7,0,0]; 
		_bargate setPos _missionPosition;
		
		// Bunker1 erstellen
		private["_bunkerPos"];
		_bunkerPos = _bargate modelToWorld [6.5,-2,-2];
		_bunkerPos set [2, 0];
		private["_bunker1"];
		_bunker1 = createVehicle ["Land_BagBunker_Small_F", _bunkerPos, [], 0, "NONE"];
		Sleep .2;
		_bunker1 setDir _missionDirection;
		
		// Bunker2 erstellen
		_bunkerPos = _bargate modelToWorld [-8,-2,-2],;
		_bunkerPos set [2, 0];
		private["_bunker2"];
		_bunker2 = createVehicle ["Land_BagBunker_Small_F", _bunkerPos, [], 0, "NONE"];
		Sleep .2;
		_bunker2 setDir _missionDirection;
		
		// MG1 erstellen
		private["_mg1"];
		_mg1 = createVehicle ["I_HMG_01_high_F", getPos _bunker1, [], 0, "CAN_COLLIDE"];
		Sleep .2;
		_mg1 setDir (_missionDirection-180);
		// MG2 erstellen
		private["_mg2"];
		_mg2 = createVehicle ["I_HMG_01_high_F", getPos _bunker2, [], 0, "CAN_COLLIDE"];
		Sleep .2;
		_mg2 setDir (_missionDirection-180);
		
		//-------------------------
		// Verteidigungs Truppe 
		//-------------------------
		private ["_groupDefend"];
		_groupDefend = createGroup pixTown_ConfigSideRed;		
		private["_unitsDefend"];
		_unitsDefend = [_groupDefend, _missionPosition, pixTown_ConfigRedClassnames, 10] call fnc_TownSM_CreateGroup;		
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
		// Mission Loop
		//-------------------------
		private["_observedUnits"];
		_observedUnits = units _groupDefend;
		_observedUnits = _observedUnits + (units _groupPatrol);
		
		private["_aliveUnits"];
		_aliveUnits = 65000;
		while { (_aliveUnits > 2) } do
		{
			Sleep 10;
			_aliveUnits = 0;
			{ if (alive _x) then { _aliveUnits = _aliveUnits + 1;};} foreach _observedUnits;
		};

		_townObject setVariable ["sideMission", 32]; // erfolgreich
		deleteMarker _townMarker;		
		Sleep 5*60;		

		// Löschen und freigeben
		deleteVehicle _bargate;
		deleteVehicle _bunker1;
		deleteVehicle _bunker2;
		deleteVehicle _mg1;
		deleteVehicle _mg2;
		
		{ deleteVehicle _x; } foreach _unitsDefend;
		deleteGroup _groupDefend;
		{ deleteVehicle _x; } foreach _unitsPatrol;
		deleteGroup _groupPatrol;
	}
	else
	{
		diag_log "ERROR: Unable to create sidemission 'Strassensperre'.";
		_townObject setVariable ["sideMission", 32]; // erfolgreich
		deleteMarker _townMarker;
	};
};