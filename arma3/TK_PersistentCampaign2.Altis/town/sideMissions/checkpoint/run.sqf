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
	_townMarker setMarkerText "Roadblock";
	_townMarker setMarkerAlpha 1;	
	_townMarker setMarkerColor "ColorRed";
	
	
	private["_missionPosition"];
	_missionPosition = [_townCenter, _townRadius * 2] call fnc_TownSM_GetRandomPositionRoad;
	if (str(_missionPosition) != "[[0,0,0],0]") then
	{
		private["_missionDirection"];
		_missionDirection = _missionPosition select 1;
		_missionPosition = _missionPosition select 0;
		
		private["_groups"];
		_groups = [];
		private["_vehicles"];
		_vehicles = [];
		private["_buildings"];
		_buildings = [];

		/* Als erstes die Schranke erstellen, da sich alles um diese Schranke dreht. */
		private["_bargate"];
		_missionPosition set [2,0];
		_bargate = createVehicle ["Land_BarGate_F", _missionPosition, [], 0, "NONE"];
		Sleep .2;
		_bargate setDir _missionDirection;	 
		_bargate setPos _missionPosition;
		_tmp = _bargate addEventHandler ["HandleDamage", {false}];
		_buildings = _buildings + [_bargate];
		Sleep .2;
		
		/* Position korrigieren, da die Schranke nicht mittig steht */
		_missionPosition = _bargate modelToWorld [7,0,0]; 
		_missionPosition set [2,0];
		_bargate setPos _missionPosition;

		
		/* Bunker1 erstellen */
		private["_bunkerPos"];
		_bunkerPos = _bargate modelToWorld [6.5,-2,-2];
		_bunkerPos set [2, 0];
		private["_bunker1"];
		_bunker1 = createVehicle ["Land_BagBunker_Small_F", _bunkerPos, [], 0, "NONE"];
		Sleep .2;
		_bunker1 setDir _missionDirection;
		_buildings = _buildings + [_bunker1];
		
		/* Bunker2 erstellen */
		_bunkerPos = _bargate modelToWorld [-8,-2,-2],;
		_bunkerPos set [2, 0];
		private["_bunker2"];
		_bunker2 = createVehicle ["Land_BagBunker_Small_F", _bunkerPos, [], 0, "NONE"];
		Sleep .2;
		_bunker2 setDir _missionDirection;
		_buildings = _buildings + [_bunker2];
		
		/* MG1 erstellen */
		private["_mg1"];
		_mg1 = createVehicle ["I_HMG_01_high_F", getPos _bunker1, [], 0, "CAN_COLLIDE"];
		Sleep .2;
		_mg1 setDir (_missionDirection-180);
		_buildings = _buildings + [_mg1];
		/* MG2 erstellen */
		private["_mg2"];
		_mg2 = createVehicle ["I_HMG_01_high_F", getPos _bunker2, [], 0, "CAN_COLLIDE"];
		Sleep .2;
		_mg2 setDir (_missionDirection-180);
		_buildings = _buildings + [_mg2];
		
		
		/*----------------------------------*/
		/* Vorbereitungen für die Einheiten */
		/*----------------------------------*/
		private["_unittypes"];
		_unittypes = ["O_Soldier_SL_F", "O_Soldier_AT_F", "O_medic_F", "O_Soldier_AR_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_F"];
		
		/* Einheiten an der Schranke */
		private["_groupBargate"];
		_groupBargate = createGroup east;
		private["_unitBargate"];
		_unitBargate = _groupBargate createUnit ["O_Soldier_SL_F", _missionPosition, [], 0, "NONE"];
		sleep .2;
		doStop _unitBargate;
		_groups = _groups + [_groupBargate];
		_relevantGroups = _relevantGroups + [_groupBargate];

		/* Einheit im Bunker1 */
		private["_groupBunker1"];
		_groupBunker1 = createGroup east;
		private["_unitBunker1"];
		_unitBunker1 = _groupBunker1 createUnit [(_unittypes call BIS_fnc_selectRandom), _missionPosition, [], 0, "NONE"];
		sleep .5;
		_unitBunker1 action ["getInGunner",_mg1];
		doStop _unitBunker1;
		_groups = _groups + [_groupBunker1];
		_relevantGroups = _relevantGroups + [_groupBunker1];
		
		/* Einheit im Bunker2 */
		private["_groupBunker2"];
		_groupBunker2 = createGroup east;
		private["_unitBunker2"];
		_unitBunker2 = _groupBunker2 createUnit [(_unittypes call BIS_fnc_selectRandom), _missionPosition, [], 0, "NONE"];
		sleep .5;
		_unitBunker2 action ["getInGunner",_mg2];
		doStop _unitBunker2;
		_groups = _groups + [_unitBunker2];
		_relevantGroups = _relevantGroups + [_unitBunker2];

		
		//-------------------------
		// Patroullierende Truppen 
		//-------------------------
		for "_i" from 0 to _patrolCount do 
		{
			private["_groupInfos"];
			_groupInfos = [_missionPosition, 600] call fnc_TownSM_AIPatrol;
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
		_groupInfos = [_missionPosition] call fnc_TownSM_AIGuard;
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
		private["_relevantUnits"];
		_relevantUnits = [];
		{
			_relevantUnits = _relevantUnits + (units _x);		
		} foreach _relevantGroups;
		
		private["_aliveUnits"];
		_aliveUnits = 65000;
		while { (_aliveUnits > 1) } do
		{
			Sleep 10;
			_aliveUnits = 0;
			{ if (alive _x) then { _aliveUnits = _aliveUnits + 1;};} foreach _relevantUnits;
		};
			
		

		/* Gruppen aufräumen */
		for "_g" from 0 to ((count _groups)-1) do 
		{
			/* Einheiten */
			{ deleteVehicle _x; } foreach (units (_groups select _g));
			
			/* Gruppe */
			deleteGroup (_groups select _g);		
		};
			
		/* Buildings aufräumen */
		{ deleteVehicle _x; } foreach _buildings;
	}
	else
	{
		diag_log "ERROR: Unable to create sidemission 'AmmoBox'.";
	};

	_townObject setVariable ["sideMission", 0];
	deleteMarker _townMarker;
};