//==========================================================================================
// Permanent Loop starten
//==========================================================================================
[] spawn {

	private _townIndex = 0;
	while { true } do 
	{
		//==========================================================================================
		// Stadt prüfen
		private _markerName = format["markerTown%1", _townIndex];
		if (markerType _markerName != "") then 
		{ 		
			private "_townData";
			call compile format["_townData = townData%1;", _townIndex];
			_townData params["_supplies"];

			//==========================================================================================
			// Auch Zivilisten verbrauchen Nahrung
			_supplies = _supplies - 1;

			//==========================================================================================
			// RED in der Nähe, dann Supplies klauen
			private _redsNear = count ((markerPos _markerName) nearEntities ["SoldierEB", 1500]); 
			if (_redsNear > 0) then 
			{
				_supplies = _supplies - 10;
			};
			
			//==========================================================================================
			// Aktuellen Stand speichern
			if (_supplies < 0) then { _supplies = 0; }; 
			_townData set [0, _supplies];

			//==========================================================================================
			// Marker Farbe aktualisieren
			if (_supplies <= 0) then
			{
				_markerName setMarkerColor "ColorRed";
			}
			else
			{
				if (_supplies <= 33) then
				{
					_markerName setMarkerColor "ColorOrange";
				}
				else
				{
					if (_supplies <= 66) then
					{
						_markerName setMarkerColor "ColorYellow";
					}
					else
					{
						_markerName setMarkerColor "ColorGreen";
					};
				};
			};
			player sidechat format["supplies: %1", _supplies];
			//_markerName setMarkerText format["%1", _supplies];
		};
	
		//==========================================================================================
		// Zur nächsten Stadt wechseln...
		_townIndex = _townIndex + 1;
		if (_townIndex >= townTownCount) then 
		{ 
			_townIndex = 0; 
			Sleep 60 * 10; // Wenn alle Städte durch sind, warten wir etwas länger.
		}
		else
		{
			Sleep 10;
		};
	};
};