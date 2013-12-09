closeDialog 0;

private["_radius"];
_radius = 2000;

openMap [true, false] ;

private["_markerBaseName"];
_markerBaseName = "MarkerBunkerMap";

/* Alte Marker löschen */
player globalChat "Alte Markierungen werden gelöscht";
private["_i"];
_i = 0;
private["_markerName"];
_markerName = format["%1_%2", _markerBaseName, _i];
while { str(getMarkerPos _markerName) != "[0,0,0]" } do 
{
	deleteMarkerLocal _markerName; 
	_i = _i + 1;
	_markerName = format["%1_%2", _markerBaseName, _i];
};

/* Neue Objekte suchen */
player globalChat "Suche Anlagen... bitte einen Moment Geduld.";
private["_objects"];
_objects = (position player) nearEntities [["Land_BagBunker_Small_F", "Land_BagBunker_Large_F", "Land_BagBunker_Tower_F", "Land_Cargo_Patrol_V1_F", "Land_Medevac_HQ_V1_F", "Land_Cargo_House_V2_F", "Land_Cargo_House_V1_F", "Land_Cargo_HQ_V1_F"], _radius];

/* Neue Objekte zeichnen */
player globalChat "Anlagen werden gezeichnet...";
_i = 0;
{
	_markerName = format["%1_%2", _markerBaseName, _i];
	createMarkerLocal [_markerName, position _x];
	_markerName setMarkerDirLocal (direction _x);
	_markerName setMarkerShapeLocal "ICON";
	_markerName setMarkerTypeLocal "waypoint";
	_markerName setMarkerSizeLocal [.5, .5];
	_markerName setMarkerAlphaLocal 0.5;
	/*_markerName setMarkerColorLocal "ColorRed";*/
	/*_markerName setMarkerTextLocal "";*/
	_i = _i + 1;
} foreach _objects;

player globalChat format["Alle Anlagen im Unkreis von %1m wurden eingetragen.", _radius];
