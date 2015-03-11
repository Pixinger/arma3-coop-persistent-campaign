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
	_townMarker setMarkerSize [1, 1];
	_townMarker setMarkerType "mil_destroy";
	_townMarker setMarkerText "Strassensperre";
	_townMarker setMarkerAlpha 1;	
	_townMarker setMarkerColor "ColorRed";
	
	
	private["_missionPosition"];
	_missionPosition = [_townCenter, _townRadius * 2] call fnc_TownSM_GetRandomPositionCircleRoad;
	if (str(_missionPosition) != "[[0,0,0],0]") then
	{
		private["_missionDirection"];
		_missionDirection = _missionPosition select 1;
		_missionPosition = _missionPosition select 0;
		_missionPosition set [2,0];

		// Als erstes die Schranke erstellen, da sich alles um diese Schranke dreht. 
		private["_bargate1"];
		_bargate1 = createVehicle ["Land_CncBarrier_F", _missionPosition, [], 0, "NONE"];
		Sleep .2;
		_bargate1 setDir _missionDirection;	 
		_bargate1 setPos _missionPosition;

		private["_tmpPos"];
		_tmpPos = _bargate1 modelToWorld [3,0,0];
		_tmpPos set [2, 0];
		private["_bargate2"];
		_bargate2 = createVehicle ["Land_CncBarrier_F", _tmpPos, [], 0, "NONE"];
		Sleep .2;
		_bargate2 setDir _missionDirection;	 
		_bargate2 setPos _tmpPos;

		_tmpPos = _bargate1 modelToWorld [-3,0,0];
		_tmpPos set [2, 0];
		private["_bargate3"];
		_bargate3 = createVehicle ["Land_CncBarrier_F", _tmpPos, [], 0, "NONE"];
		Sleep .2;
		_bargate3 setDir _missionDirection;	 
		_bargate3 setPos _tmpPos;
		
		// MG1 erstellen
		_tmpPos = _bargate1 modelToWorld [0,6,0];
		_tmpPos set [2, 0];
		private["_mg1"];
		_mg1 = createVehicle ["I_HMG_01_high_F", _tmpPos, [], 0, "CAN_COLLIDE"];
		Sleep .2;
		_mg1 setDir (_missionDirection-180);
		
		// MG2 erstellen
		_tmpPos = _bargate1 modelToWorld [0,-6,0],;
		_tmpPos set [2, 0];
		private["_mg2"];
		_mg2 = createVehicle ["I_HMG_01_high_F", _tmpPos, [], 0, "CAN_COLLIDE"];
		Sleep .2;
		_mg2 setDir (_missionDirection-180);
		
		Sleep 2;
		
		//-------------------------
		// Verteidigungs Truppe 
		//-------------------------
		private ["_groupDefend"];
		_groupDefend = createGroup pixTown_ConfigSideRed;		
		private["_unitsDefend"];
		_unitsDefend = [_groupDefend, _missionPosition, pixTown_ConfigRedClassnames, 5] call fnc_TownSM_CreateGroup;		
		[_groupDefend, _missionPosition] call bis_fnc_taskDefend;

		Sleep 2;
		
		//-------------------------
		// Patrol Truppe 
		//-------------------------
		private ["_groupPatrol"];
		_groupPatrol = createGroup pixTown_ConfigSideRed;		
		private["_unitsPatrol"];
		_unitsPatrol = [_groupPatrol, _missionPosition, pixTown_ConfigRedClassnames, 5] call fnc_TownSM_CreateGroup;		
		[_groupPatrol, _missionPosition, 300] call bis_fnc_taskPatrol;

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
		deleteVehicle _bargate1;
		deleteVehicle _bargate2;
		deleteVehicle _bargate3;
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