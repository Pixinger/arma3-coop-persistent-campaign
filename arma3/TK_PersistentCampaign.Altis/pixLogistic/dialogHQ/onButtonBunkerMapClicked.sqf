closeDialog 0;

private["_radius"];
_radius = 5000;

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
/*_objects = (position player) nearEntities [["Land_BagBunker_Small_F", "Land_BagBunker_Large_F", "Land_BagBunker_Tower_F", "Land_Cargo_Patrol_V1_F", "Land_Medevac_HQ_V1_F", "Land_Cargo_House_V2_F", "Land_Cargo_House_V1_F", "Land_Cargo_HQ_V1_F"], _radius];*/
_objects = nearestObjects [(position player), ["Land_BagBunker_Small_F", "Land_BagBunker_Large_F", "Land_BagBunker_Tower_F", "Land_Cargo_Patrol_V1_F", "Land_Cargo_HQ_V1_F"], _radius];
/* Neue Objekte zeichnen */
player globalChat "Anlagen werden gezeichnet...";
_i = 0;
{
	/*_boundingBox = boundingBoxReal _x; /* An array with the extreme points of the model. Format [[x1,y1,z1],[x2,y2,z2]]. */
	/*private["_p1"];
	_p1 = _boundingBox select 0; 
	private["_p2"];
	_p2 = _boundingBox select 1; 
	private["_maxWidth"];
	_maxWidth = abs ((_p2 select 0) - (_p1 select 0)); 
	private["_maxLength"];
	_maxLength = abs ((_p2 select 1) - (_p1 select 1)); 
	private["_maxHeight"];
	_maxHeight = abs ((_p2 select 2) - (_p1 select 2));
	_markerName setMarkerSizeLocal [_maxWidth / 2, 1];
		*/

	_markerName = format["%1_%2", _markerBaseName, _i];
	createMarkerLocal [_markerName, position _x];
	_markerName setMarkerDirLocal (direction _x);
	_markerName setMarkerShapeLocal "ICON";
	_markerName setMarkerSizeLocal [1,1];
	_markerName setMarkerAlphaLocal 0.9;
	if (typeof(_x) == "Land_Cargo_HQ_V1_F") then
	{
		_markerName setMarkerTypeLocal "n_hq";
		_markerName setMarkerColorLocal "ColorBlue";
		_markerName setMarkerTextLocal "HQ";
	}
	else
	{
		if (typeof(_x) == "Land_Cargo_Patrol_V1_F") then
		{
			_markerName setMarkerTypeLocal "loc_bunker";
			_markerName setMarkerColorLocal "ColorBlue";
		}
		else
		{
			_markerName setMarkerTypeLocal "loc_bunker";
			_markerName setMarkerColorLocal "ColorBlack";
		};
	};
	_i = _i + 1;
} foreach _objects;

player globalChat format["Alle Anlagen im Umkreis von %1m wurden eingetragen.", _radius];
