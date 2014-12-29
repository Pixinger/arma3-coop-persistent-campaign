if (!isServer || !isDedicated) then
{
	waitUntil { player == player };
	Sleep 2;
	
	private["_lastMarkerCount"];
	_lastMarkerCount = 0;
	while {true} do
	{	
		private["_units"];
		_units = entities "CAManBase";
		
		if (count _units != _lastMarkerCount) then
		{
			/* Alte Marker löschen */
			for "_i" from 0 to (_lastMarkerCount - 1) do
			{-
				deleteMarkerLocal format["GpsMarker%1", _i];
			};
			
			/* Neue Marker erstellen */
			_lastMarkerCount = count _units;
			private ["_i", "_markerName"];
			for "_i" from 0 to (_lastMarkerCount - 1) do
			{
				private["_markerName"];
				_markerName = createMarkerLocal [format["GpsMarker%1", _i], [0,0,0]];
				_markerName setMarkerAlphaLocal 0;
				_markerName setMarkerColorLocal "ColorBlack";
				_markerName setMarkerShapeLocal "ICON";
				_markerName setMarkerTypeLocal "o_inf";
				_markerName setMarkerSizeLocal [0.3, 0.3];
			};
		};
		
		/* Alle Marker aktualisieren */	
		for "_i" from 0 to _lastMarkerCount-1 do
		{
			/* Variablen vorbereiten */
			_markerName = format["GpsMarker%1", _i];

			/* Einheit aktualisieren */
			private["_unit"];
			_unit = _units select _i;
			_markerName setMarkerPosLocal (getPos _unit);
			if (_unit isKindOf "SoldierGB") then 
			{ 
				_markerName setMarkerColorLocal "ColorRed";//ColorOrange
			};
			if (_unit isKindOf "SoldierWB") then 
			{ 
				_markerName setMarkerColorLocal "ColorBlue";
			};
			if (_unit isKindOf "Civilian_F") then 
			{ 
				_markerName setMarkerColorLocal "ColorGreen";
			};
			
			if (alive _unit) then 
			{
				_markerName setMarkerAlphaLocal 0.8; 
			}
			else 
			{ 
				_markerName setMarkerAlphaLocal 0.4; 
			};			
		};
		
		Sleep 2;
	};
};
