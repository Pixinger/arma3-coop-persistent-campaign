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
	// 10: Mission Start
	// 11: Mission fehlgeschlagen
	// 12: Mission erfolgreich		
	_townObject setVariable ["sideMission", 11];	
	
	// -----------------------------------
	// Marker erstellen
	// -----------------------------------
	private["_townMarker"];
	_townMarker = createMarker[format["markerTownSideMission%1", _townName], _townCenter];
	_townMarker setMarkerShape "ICON";
	_townMarker setMarkerSize [10, 10];
	_townMarker setMarkerType "mil_destroy";
	_townMarker setMarkerText "Warlord";
	_townMarker setMarkerAlpha 1;	
	_townMarker setMarkerColor "ColorRed";
	
	
	private ["_unitGroup"];
	_unitGroup = createGroup pixTown_ConfigSideRed;		
	private["_unit"];
	_unit = _unitGroup createUnit ["PC2_O_G_Story_Colonel_F", _townCenter, [], 0, "FORM"];
	waitUntil {!isNil "_unit"};
	if (!isNull _unit) then
	{							
		//_unit setBehaviour "CARELESS";
		if (random 1 < 0.5) then { _unit setSpeedmode "FULL"; } else { _unit setSpeedmode "LIMITED"; };
		//removeAllWeapons _unit;		

		while { alive _unit } do
		{			
			if (random 1 < 0.5) then
			{
				private["_building"];
				_building = nearestBuilding [(_townCenter select 0) - _townRadius + (random (_townRadius * 2)), (_townCenter select 1) - _townRadius + (random (_townRadius * 2)), 0];
				private["_buildingPos"];
				_buildingPos = _building buildingPos (([_building] call PC_fnc_GetMaxBuildingPositions) - 1);
				_unit moveTo _buildingPos;

				private["_doneHere"];
				_doneHere = false;
				while { !_doneHere } do
				{
					Sleep 10;
					if (moveToFailed _unit) then { _doneHere = true; };
					if (moveToCompleted _unit) then
					{ 
						Sleep (10 * 60);
						_doneHere = true; 
					};
				};
			}
			else
			{
				_unit moveTo [(_townCenter select 0) - _townRadius + (random (_townRadius*2)), (_townCenter select 1) - _townRadius + (random (_townRadius*2)), 0];			
				private["_doneHere"];
				_doneHere = false;
				while { !_doneHere } do
				{
					Sleep 10;
					if (moveToFailed _unit) then { _doneHere = true; };
					if (moveToCompleted _unit) then { _doneHere = true; };
				};				
			};		
		};
	}
	else
	{
		diag_log "ERROR: Unable to create sidemission 'Warlord'";
	};

	_townObject setVariable ["sideMission", 12]; //erfolgreich
	deleteMarker _townMarker;
};