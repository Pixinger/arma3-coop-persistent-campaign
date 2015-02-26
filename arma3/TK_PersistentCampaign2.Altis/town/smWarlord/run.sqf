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
			Sleep 10;
		};
	}
	else
	{
		diag_log "ERROR: Unable to create sidemission unit 'PC2_O_G_Story_Colonel_F'";
	};
	
	_townObject setVariable ["sideMission", 0];
	deleteMarker _townMarker;
};