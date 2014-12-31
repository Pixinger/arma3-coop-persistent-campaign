if (!isServer || !isDedicated) then
{
	waitUntil { player == player };
	Sleep 2;
	
	private["_lastMarkerCount"];
	_lastMarkerCount = 0;
	while {true} do
	{	
		private["_units"];
		_units = playableUnits;
		
		if (count _units != _lastMarkerCount) then
		{
			/* Alte Marker löschen */
			for "_i" from 0 to (_lastMarkerCount - 1) do
			{
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
				_markerName setMarkerColorLocal "ColorBlue";
				_markerName setMarkerShapeLocal "ICON";
				_markerName setMarkerTypeLocal "o_inf";
				_markerName setMarkerSizeLocal [0.5, 0.5];
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
			_markerName setMarkerColorLocal "ColorBlue";
			_markerName setMarkerAlphaLocal 0.7;
			_markerName setMarkerTextLocal (name _unit);
		};
		
		Sleep 2;
	};
};
