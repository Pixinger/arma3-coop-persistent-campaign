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
	// 40: Mission Start
	// 41: Mission fehlgeschlagen
	// 42: Mission erfolgreich		
	_townObject setVariable ["sideMission", 41];	
	
	// -----------------------------------
	// Marker erstellen
	// -----------------------------------
	private["_townMarker"];
	_townMarker = createMarker[format["markerTownSideMission%1", _townName], _townCenter];
	_townMarker setMarkerShape "ICON";
	_townMarker setMarkerSize [1, 1];
	_townMarker setMarkerType "mil_destroy";
	_townMarker setMarkerText "Luftabwehr";
	_townMarker setMarkerAlpha 1;	
	_townMarker setMarkerColor "ColorRed";	
	
	private["_missionPosition"];
	_missionPosition = [_townCenter, _townRadius * 2] call fnc_TownSM_GetRandomPositionCircleField;
	if (str(_missionPosition) != "[[0,0,0],0]") then
	{
		_missionPosition = _missionPosition select 0;
		if (pixDebug) then { _townMarker setMarkerPos _missionPosition;};

		private["_antiair1"];
		_antiair1 = "O_APC_Tracked_02_AA_F" createVehicle _missionPosition;
		_antiair1 setdir random 360;
		_antiair1 setVectorUp surfaceNormal (position _antiair1);
		_antiair1 allowDamage false;
		createVehicleCrew _antiair1; 

		private["_antiair2"];
		_antiair2 = "O_APC_Tracked_02_AA_F" createVehicle _missionPosition;
		_antiair2 setdir random 360;
		_antiair2 setVectorUp surfaceNormal (position _antiair2);
		_antiair2 allowDamage false;
		createVehicleCrew _antiair2; 

		//-------------------------
		// Patrol Truppe 
		//-------------------------
		private ["_groupPatrol"];
		_groupPatrol = createGroup pixTown_ConfigSideRed;		
		private["_unitsPatrol"];
		_unitsPatrol = [_groupPatrol, _missionPosition, pixTown_ConfigRedClassnames, 5] call fnc_TownSM_CreateGroup;		
		[_groupPatrol, _missionPosition, 75] call bis_fnc_taskPatrol;

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
		private["_ammobox1PosX"];
		_ammobox1PosX = (getPos _ammobox1) select 0;
		private["_ammobox2PosX"];
		_ammobox2PosX = (getPos _ammobox2) select 0;

		while { (damage _antiair1 < 0.8) } do {	Sleep 10;};
		while { (damage _antiair2 < 0.8) } do {	Sleep 10;};

		_townObject setVariable ["sideMission", 42]; // erfolgreich
		deleteMarker _townMarker;
		Sleep 5*60;

		// Löschen und freigeben
		{ deleteVehicle _x; } foreach _unitsPatrol;
		deleteGroup _groupPatrol;
	}
	else
	{
		_townObject setVariable ["sideMission", 0]; // erfolgreich
		deleteMarker _townMarker;
-		diag_log "ERROR: Unable to create sidemission 'Antiair'.";
	};		
};
