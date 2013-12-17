if (!isServer || !isDedicated) then
{
	waitUntil { player == player };
	Sleep 2;
	
	private["_slotCount"];
	_slotCount = playableSlotsNumber west;

	/* Einmal alle Marker erstellen und unsichtbar machen */
	private ["_i", "_markerName"];
	for "_i" from 0 to (_slotCount-1) do
	{
		private["_markerName"];
		_markerName = createMarkerLocal [format["GpsMarker%1", _i], [0,0,0]];
		_markerName setMarkerAlphaLocal 0;
		_markerName setMarkerColorLocal "ColorBlue";
		_markerName setMarkerShapeLocal "ICON";
		_markerName setMarkerTypeLocal "o_inf";
		_markerName setMarkerSizeLocal [0.5, 0.5];
	};
	
	while {true} do
	{	
		for "_i" from 1 to _slotCount do
		{
			/* Variablen vorbereiten */
			_markerName = format["GpsMarker%1", _i];

			/* Einheit aktualisieren */
			if (call compile format["!isNil""Unit%1""", _i]) then
			{
				private["_unit"];
				call compile format["_unit = Unit%1;", _i];
				_markerName setMarkerPosLocal (getPos _unit);
				if (captive _unit) then 
				{ 
					_markerName setMarkerColorLocal "ColorBlack"; 
					_markerName setMarkerAlphaLocal 0.4;
					_markerName setMarkerTextLocal "*help*";
				} 
				else 
				{
					_markerName setMarkerColorLocal "ColorBlue";
					_markerName setMarkerAlphaLocal 0.7;
					_markerName setMarkerTextLocal (name _unit);
				};
			}
			else
			{
				/* Diese Einheit wird gerade nicht bespielt */
				_markerName setMarkerAlphaLocal 0;				
			};
		};
		
		Sleep 1;
	};
};
