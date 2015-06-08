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
			
			private["_iedClassnames"];
			_iedClassnames = ["ModuleExplosive_IEDUrbanSmall_F", "ModuleExplosive_IEDLandSmall_F", "ModuleExplosive_IEDUrbanBig_F", "ModuleExplosive_IEDLandBig_F"];
			private["_ieds"];
			_ieds = (getPos MapCenter) nearEntities [_iedClassnames, 15000];
			private["_lastIEDMarkerCount"];
			_lastIEDMarkerCount = count _ieds;

			if (_lastIEDMarkerCount > 0) then
			{
				/* Neue Marker erstellen */
				private ["_i", "_markerName"];
				for "_i" from 0 to (_lastIEDMarkerCount - 1) do
				{
					private["_markerName"];
					_markerName = createMarkerLocal [format["GpsIedMarkerA%1", _i], (getPos (_ieds select _i))];
					_markerName setMarkerAlphaLocal 1;
					_markerName setMarkerColorLocal "ColorRed";
					_markerName setMarkerShapeLocal "ICON";
					_markerName setMarkerTypeLocal "hd_warning";
					_markerName setMarkerSizeLocal [0.5, 0.5];
				};			
			};
		
			private["_lastMarkerCount"];
			_lastMarkerCount = 0;
			while { adminGps } do
			{	
				private["_units"];
				_units = entities "CAManBase";
				
				if (count _units != _lastMarkerCount) then
				{
					/* Alte Marker löschen */
					for "_i" from 0 to (_lastMarkerCount - 1) do
					{
						deleteMarkerLocal format["GpsMarkerA%1", _i];
					};
					
					/* Neue Marker erstellen */
					_lastMarkerCount = count _units;
					private ["_i", "_markerName"];
					for "_i" from 0 to (_lastMarkerCount - 1) do
					{
						private["_markerName"];
						_markerName = createMarkerLocal [format["GpsMarkerA%1", _i], [0,0,0]];
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
					_markerName = format["GpsMarkerA%1", _i];

					/* Einheit aktualisieren */
					private["_unit"];
					_unit = _units select _i;
					_markerName setMarkerPosLocal (getPos _unit);
					if (_unit isKindOf pixTown_ConfigBaseClassRed) then 
					{ 
						_markerName setMarkerColorLocal "ColorRed";//ColorOrange
					};
					if (_unit isKindOf pixTown_ConfigBaseClassBlu) then 
					{ 
						_markerName setMarkerColorLocal "ColorBlue";
					};
					if (_unit isKindOf pixTown_ConfigBaseClassCiv) then 
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
			
			for "_i" from 0 to (_lastMarkerCount - 1) do
			{
				deleteMarkerLocal format["GpsMarkerA%1", _i];
			};
			
			if (_lastIEDMarkerCount > 0) then
			{
				for "_i" from 0 to (_lastIEDMarkerCount - 1) do
				{
					deleteMarkerLocal format["GpsIedMarkerA%1", _i];
				};			
			};			
		};
	};
};
