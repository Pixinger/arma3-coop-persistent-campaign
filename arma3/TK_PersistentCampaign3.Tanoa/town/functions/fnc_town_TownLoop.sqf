#include "..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

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
			(townInfos select _townIndex) params["_supplies", "_civilianCount", "_houseCount"];	

			//==========================================================================================
			// Auch Zivilisten verbrauchen Nahrung
			_supplies = _supplies - ceil(_houseCount / 20);

			//==========================================================================================
			// RED in der Nähe, dann Supplies klauen
			private _redsNear = false;
			private _redUnits = ((markerPos _markerName) nearEntities ["SoldierGB", 600]);
			{
				if ((alive _x) && { (captiveNum _x == 0) && { (damage _x < 0.1) }}) exitWith { _redsNear = true; };
			} foreach _redUnits;
			if (_redsNear) then 
			{
				_supplies = _supplies - 10;
				INFO_LOG_VAREX("TOWN: ENEMY NEAR. _townIndex=", _townIndex);
			};
			
			//==========================================================================================
			// Aktuellen Stand speichern
			if (_supplies < 0) then { _supplies = 0; }; 
			(townInfos select _townIndex) set [0, _supplies];
			INFO_LOG_VAREX2("TOWN: _townIndex/_supplies", _townIndex, _supplies);

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
			//player sidechat format["town %1: supplies: %2", _townIndex, _supplies];
			//_markerName setMarkerText format["%1", _supplies];
		};
	
		//==========================================================================================
		// Zur nächsten Stadt wechseln...
		_townIndex = _townIndex + 1;
		if (_townIndex >= townTownCount) then 
		{ 
			_townIndex = 0; 
			Sleep (60 * 10); // Wenn alle Städte durch sind, warten wir etwas länger.
		}
		else
		{
			Sleep 1;
		};
	};
};