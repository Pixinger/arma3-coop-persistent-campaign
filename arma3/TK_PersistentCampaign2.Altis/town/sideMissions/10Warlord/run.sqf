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
	_townMarker setMarkerSize [1, 1];
	_townMarker setMarkerType "mil_destroy";
	_townMarker setMarkerText "Warlord";
	_townMarker setMarkerAlpha 1;	
	_townMarker setMarkerColor "ColorRed";
	
	
	private["_unitPos"];
	_unitPos = [_townCenter, _townRadius] call fnc_TownSM_GetRandomPositionCircleHousePos;
	if (str(_unitPos) != "[[0,0,0],0]") then
	{			
		private ["_unitGroup"];
		_unitGroup = createGroup pixTown_ConfigSideRed;		
		private["_unit"];
		_unit = _unitGroup createUnit ["PC2_O_G_Story_Colonel_F", _unitPos select 0, [], 0, "FORM"];
		waitUntil {!isNil "_unit"};
		if (!isNull _unit) then
		{							
			//_unit setBehaviour "CARELESS";
			if (random 1 < 0.5) then { _unit setSpeedmode "FULL"; } else { _unit setSpeedmode "LIMITED"; };
			//removeAllWeapons _unit;		

			while { alive _unit } do
			{			
				// Neues Bewegungsziel beauftragen
				private["_zufall"];
				_zufall = random 1;
				if (_zufall < 0.5) then
				{
					_unitPos = [_townCenter, _townRadius] call fnc_TownSM_GetRandomPositionCircleHousePos;
					if (str(_unitPos) != "[[0,0,0],0]") then
					{
						_unit doMove (_unitPos select 0);
					}
					else
					{
					};
				}
				else
				{
					_unit doMove [(_townCenter select 0) - _townRadius + (random (_townRadius*2)), (_townCenter select 1) - _townRadius + (random (_townRadius*2)), 0];			
				};

				// Warten bis angekommen, oder blockiert
				private["_oldPos"];
				_oldPos = [0,0,0];
				private["_doneHere"];
				_doneHere = false;
				while { (alive _unit) and (!_doneHere) } do
				{
					Sleep 10;
					if (_oldPos distanceSqr _unit < 1) then
					{
						// Warten wir hier ein wenig, danach geht es dann weiter
						private["_warten"];
						_warten = time + (300);
						while { (alive _unit) && (_warten > time) } do
						{
							Sleep 10;
						};
						_doneHere = true; 						
					}
					else
					{
						_oldPos = getPos _unit;
					};
				};
			};
		}
		else
		{
			diag_log "ERROR: Unable to create sidemission 'Warlord'";
		};
	}
	else
	{
		diag_log "ERROR: Unable to find initial position 'Warlord'";
	};

	_townObject setVariable ["sideMission", 12]; //erfolgreich
	deleteMarker _townMarker;
};