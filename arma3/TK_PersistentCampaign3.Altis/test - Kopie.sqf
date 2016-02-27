allLocationTypes = [];

"allLocationTypes pushBack configName _x" configClasses (configFile >> "CfgLocationTypes");

//allLocationTypes = ["respawn_air", "respawn_motor", "Strategic"];
systemChat str(allLocationTypes);
_i = 0;
{

	if (type _x != "Mount") then
	{
	_i = _i + 1;
	private["_markerName"];
	_markerName = createMarkerLocal [format["Location%1", _i], (getPos _x)];
	_markerName setMarkerAlphaLocal 1;
	_markerName setMarkerColorLocal "ColorRed";
	_markerName setMarkerShapeLocal "ICON";
	_markerName setMarkerTypeLocal "hd_warning";
	_markerName setMarkerTextLocal format["%1 / %2 %3", type _x, text _x, name _x];
	_markerName setMarkerSizeLocal [0.5, 0.5];	
	};
	
} forEach nearestLocations [player, allLocationTypes, 50000];
