if (hasInterface) then
{
	[] spawn {
		if (isNil "adminGps") then {adminGps = false;};

		if (adminGps) then
		{
			adminGps = false;
		}
		else
		{	
			adminGps = true;
			hint "GPS aktiviert";
		
			private["_lastMarkerCount"];
			_lastMarkerCount = 0;
			while { adminGps } do
			{	
				/* Units suchen */
				private["_units"];
				_units = entities "CAManBase";

				/* Neue Marker erstellen */
				_lastMarkerCount = count _units;
				private ["_i", "_markerName"];
				for "_i" from 0 to (_lastMarkerCount - 1) do {
					private["_unit"];
					_unit = _units select _i;
					private["_markerName"];
					_markerName = createMarkerLocal [format["GpsMarkerA%1", _i], [0,0,0]];
					_markerName setMarkerShapeLocal "ICON";
					_markerName setMarkerTypeLocal "o_inf";
					_markerName setMarkerSizeLocal [0.2, 0.2];
					if (isPlayer _unit) then {
						_markerName setMarkerTextLocal (name _unit);
						_markerName setMarkerColorLocal "ColorBlue"; 
					};
					_markerName setMarkerPosLocal (getPos _unit);
					_markerName setMarkerColorLocal "ColorBlack";
					if (_unit isKindOf "SoldierGB") then { _markerName setMarkerColorLocal "ColorRed"; };
					if (_unit isKindOf "Civilian_F") then { _markerName setMarkerColorLocal "ColorGreen"; };
					if (alive _unit) then { _markerName setMarkerAlphaLocal 0.8; } else { _markerName setMarkerAlphaLocal 0.4; };			
				};
				
				Sleep 2;

				for "_i" from 0 to (_lastMarkerCount - 1) do {
					deleteMarkerLocal format["GpsMarkerA%1", _i];
				};
			};		
			
			hint "GPS beendet";			
		};
	};
};
