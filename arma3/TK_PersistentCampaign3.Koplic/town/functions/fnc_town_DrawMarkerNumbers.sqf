for "_i" from 0 to townTownCount-1 do 
{
	private _markerName = format["markerTown%1", _i];
	if (markerType _markerName != "") then
	{
		
		private _marker = createMarkerLocal [format["markerTownNumer%1", _i], (getMarkerPos _markerName)];
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerTypeLocal "o_inf";
		_marker setMarkerSizeLocal [0.4, 0.4];
		_marker setMarkerColorLocal "ColorBlack"; 
		_marker setMarkerAlphaLocal 1;
		_marker setMarkerTextLocal format["%1", _i];
	};
};