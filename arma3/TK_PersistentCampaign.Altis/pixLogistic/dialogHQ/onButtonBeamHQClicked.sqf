closeDialog 0;

openMap [true, true];

pixZonesHqBeamClicked = [];

private["_hqs"];
_hqs = nearestObjects [player, pixlogisticHQs, 5000];
if (count _hqs > 0) then
{
	/* Marker an den Positionen erstellen */
	private ["_i", "_markerName"];
	_i = 0;
	{
		_i = _i + 1;
		_markerName = format["pixZonesHqBeamMarker%1", _i];
		createMarkerLocal [_markerName, getPos _x ];
		
		_markerName setMarkerColorLocal "ColorYellow";
		_markerName setMarkerShapeLocal "ICON";				
		_markerName setMarkerTypeLocal "selector_selectable";
		_markerName setMarkerTextLocal format["HQ-%1", _i];
		_markerName setMarkerAlphaLocal 1;
		//_markerName setMarkerSizeLocal [0.5, 0.5];
	} foreach _hqs;


	/* Mapclick freigeben */
	player globalChat "Bitte gewünschtes HQ anklicken...";
	
	onMapSingleClick "pixZonesHqBeamClicked = _pos; onMapSingleClick ''; openMap [true, false]; openMap [false, false]; true;";

	/* warten bis geklickt wurde */
	waitUntil {(count pixZonesHqBeamClicked) > 0};

	private["_clickedHQs"];
	_clickedHQs = nearestObjects [pixZonesHqBeamClicked, pixlogisticHQs, 100];
	if (count _clickedHQs > 0) then
	{
		private["_clickedHQ"];
		_clickedHQ = _clickedHQs select 0;
		
		private["_zoneIndex"];
		_zoneIndex = [(getPos _clickedHQ)] call PC_fnc_GetZoneIndex;
		
		if ([_zoneIndex] call PC_fnc_IsZoneBlueFor) then
		{
			player setPos (getpos _clickedHQ);
		}
		else
		{
			player globalChat "ERROR: HQ liegt in feindlicher Zone.";
		};
	}
	else
	{
		player globalchat "ERROR: Kein HQ in der Nähe dieser Position";
	};

	/* Marker wieder löschen */
	while { _i > 0 } do
	{
		_markerName = format["pixZonesHqBeamMarker%1", _i];
		deleteMarkerLocal _markerName;	
		_i = _i - 1;
	};
	
	pixZonesHqBeamClicked = nil;
};