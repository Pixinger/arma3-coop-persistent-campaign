/* 
	Diese Funktion erstellt überwacht eine Gruppe und zeichnet die Bewegungen auf der Map ein.
	Diese Funktion muss mit "spawn" gestartet werden.
	
Parameter:
	group: 		Die zu überwachende Gruppe.
	history:	Gibt an, ob der Weg mit bleibenden Punkten markiert werden soll, oder nicht.
	
Return: 
	nix:
	
/*-------------------------------------------------------------------*/

if (!isServer || isDedicated) exitWith {};

private["_group"];
_group = [_this, 0, grpNull, [grpNull]] call BIS_fnc_param;
if (isNull _group) exitWith {["Empty group passend in parameter"] call BIS_fnc_error; };

private["_history"];
_history = [_this, 1, false, [false]] call BIS_fnc_param;

private["_color"];
_color = [_this, 2, "ColorRed", [""]] call BIS_fnc_param;

private["_text"];
_text = [_this, 3, "", [""]] call BIS_fnc_param;

/*-------------------------------------------------------------------*/

/* Waypoints */
private["_markernames"];
_markernames = [];
private["_markername"];
/*private["_waypoints"];
_waypoints = waypoints _group;
for "_i" from 0 to (count _waypoints - 1) do
{
	_markername = [] call PC_fnc_GetUniqueMarkerName;
	_markernames = _markernames + [_markername];
	createMarkerLocal [_markerName,  waypointPosition (_waypoints select _i)];
	_markerName setMarkerShapeLocal "ICON";
	_markerName setMarkerTypeLocal "waypoint";
	_markerName setMarkerSizeLocal [.5, .5];
	_markerName setMarkerAlphaLocal 0.8;
	_markerName setMarkerColorLocal _color;
	_markerName setMarkerTextLocal format["%1", _i];
	_markernames = _markernames + [_markername];
};*/

/* Marker erstellen */
_markername = [] call PC_fnc_GetUniqueMarkerName;
_markernames = _markernames + [_markername];
createMarkerLocal [_markerName,  [0,0,0]];
_markerName setMarkerShapeLocal "ICON";
_markerName setMarkerTypeLocal "o_unknown";
_markerName setMarkerSizeLocal [.5, .5];
_markerName setMarkerAlphaLocal 1;
_markerName setMarkerColorLocal _color;
_markerName setMarkerTextLocal _text;

/* Marker aktualisieren */
private["_i"];
_i = 0;
while { (pixZones_ActiveIndex != -1) } do
{
	_markerName setMarkerPosLocal (getPos (leader _group));/*(getPos _group);*/
	if (_history) then
	{
		if (_i == 5) then
		{
			/* Marker erstellen */
			private["_markername2"];
			_markername2 = [] call PC_fnc_GetUniqueMarkerName;
			createMarkerLocal [_markername2, (getPos (leader _group))];
			_markernames = _markernames + [_markername2];
			_markerName2 setMarkerShapeLocal "ELLIPSE";
			_markerName2 setMarkerSizeLocal [10, 10];
			_markerName2 setMarkerAlphaLocal 1;
			_markerName2 setMarkerColorLocal _color;
			_i = 0;
		} else
		{
			_i = _i + 1;
		};
	};
	Sleep 2;		
};	

/* Marker löschen */
{ deleteMarkerLocal _x } foreach _markernames; 
_markerName = nil;
