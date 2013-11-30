if (isServer && !isDedicated) then
{
	private["_group"];
	_group = _this select 0;
	
	/* Marker erstellen */
	private["_markernames"];
	_markernames = [];
	private["_markername"];
	_markername = [] call fn_missionsOpt_GetUniqueMarkerName;
	_markernames = _markernames + [_markername];
	createMarkerLocal [_markerName,  [0,0,0]];
	_markerName setMarkerShapeLocal "ELLIPSE";
	_markerName setMarkerSizeLocal [25, 25];
	_markerName setMarkerAlphaLocal 1;
	_markerName setMarkerColorLocal "ColorRed";
	
	/* Marker aktualisieren */
	private["_i"];
	_i = 0;
	while { (pixZones_ActiveIndex != -1) } do
	{
		_markerName setMarkerPosLocal (getPos (leader _group));/*(getPos _group);*/
		if (_i == 5) then
		{
			/* Marker erstellen */
			private["_markername2"];
			_markername2 = [] call fn_missionsOpt_GetUniqueMarkerName;
			createMarkerLocal [_markername2, (getPos (leader _group))];
			_markernames = _markernames + [_markername2];
			_markerName2 setMarkerShapeLocal "ELLIPSE";
			_markerName2 setMarkerSizeLocal [10, 10];
			_markerName2 setMarkerAlphaLocal 1;
			_markerName2 setMarkerColorLocal "ColorRed";
			_i = 0;
		} else
		{
			_i = _i + 1;
		};
		Sleep 2;		
	};	
	
	/* Marker löschen */
	{ deleteMarkerLocal _x } foreach _markernames; 
	_markerName = nil;
};