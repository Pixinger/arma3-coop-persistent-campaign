/*
 Aktualisiert die Farben von allen Zonen-Markern
*/

/* Staus ID's:
	0 = Sperrzone
	1 = Aktivierte/Angegriffene Zone
	2 = Freundliche Zone */

/*if (pixDebug) then { player globalChat format["INFO: fn_pixZones_UpdateMarkerColor: pvehPixZones_ZoneStatus=%1", pvehPixZones_ZoneStatus]; };*/
	
private["_i"];
for "_i" from 0 to (pixZones_ZoneCount-1) do
{
	if (_i < count pvehPixZones_ZoneStatus) then
	{
		private["_status"];
		_status = pvehPixZones_ZoneStatus select _i;
		switch (_status) do 
		{ 
			/* Sperrzone / Angreifbar */
			case 0: 
			{ 
				if ([_i] call PC_fnc_CanBlueforEngageZone) then
				{
					/* Angreifbar */
					(pixZones_MarkerNames select _i) setMarkerColorLocal "ColorOrange"; 
					(pixZones_MarkerNames select _i) setMarkerAlphaLocal .4;
				}
				else
				{
					/* Sperrzone */
					(pixZones_MarkerNames select _i) setMarkerColorLocal "ColorRed"; 
					(pixZones_MarkerNames select _i) setMarkerAlphaLocal .7;
				};
			};
			/* Aktivierte/Angegriffene Zone*/
			case 1: 
			{ 
				(pixZones_MarkerNames select _i) setMarkerColorLocal "ColorGreen"; 
				(pixZones_MarkerNames select _i) setMarkerAlphaLocal .2;
			};
			/* Freundliche Zone */
			case 2: 
			{
				(pixZones_MarkerNames select _i) setMarkerColorLocal "ColorGreen"; 
				(pixZones_MarkerNames select _i) setMarkerAlphaLocal 0;
			};
			/* Unbekannte Zone */
			default 
			{ 
				(pixZones_MarkerNames select _i) setMarkerColorLocal "ColorBlack"; 
				(pixZones_MarkerNames select _i) setMarkerAlphaLocal 1;
			};
		};
	}
	else
	{
		(pixZones_MarkerNames select _i) setMarkerColorLocal "ColorBlack"; 
		(pixZones_MarkerNames select _i) setMarkerAlphaLocal .8;
	};
};