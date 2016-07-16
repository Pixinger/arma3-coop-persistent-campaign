private _markerNames = [];

// ------------------------------------------------------------------------
PRIVATE _ii = 0;
{
	private _camps = allMissionObjects _x;
	{
		_ii = _ii + 1;
		private["_markerName"];
		_markerName = createMarkerLocal [format["MarkerCampTownReveal%1", _ii], (getPos _x)];
		_markerName setMarkerShapeLocal "ICON";
		_markerName setMarkerTypeLocal "o_inf";
		_markerName setMarkerSizeLocal [0.2, 0.2];
		_markerName setMarkerTextLocal format["town %1", _ii];
		_markerName setMarkerColorLocal "ColorBlue"; 
		_markerNames pushBack _markerName;
	} foreach _camps;
} foreach cfgAizCampTownClassnames; 

// ------------------------------------------------------------------------
{
	private _camps = allMissionObjects _x;
	{
		_ii = _ii + 1;
		private["_markerName"];
		_markerName = createMarkerLocal [format["MarkerCampTownReveal%1", _ii], (getPos _x)];
		_markerName setMarkerShapeLocal "ICON";
		_markerName setMarkerTypeLocal "o_inf";
		_markerName setMarkerSizeLocal [0.2, 0.2];
		_markerName setMarkerTextLocal format["field %1", _ii];
		_markerName setMarkerColorLocal "ColorBlue"; 
		_markerNames pushBack _markerName;
	} foreach _camps;
} foreach cfgAizCampFieldClassnames;

// ------------------------------------------------------------------------
_markerNames spawn {
	Sleep 60;
	{ deleteMarkerLocal _x;	} foreach _this;
};