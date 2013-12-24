/* 
	Diese Funktion findet bestimme Classnames innerhalb einer bestimmten Entfernung und gibt den nahesten zurück.
	
Parameter:
	position: Die Position an der gesucht werden soll
	classnames: Ein Array mit den Classnames die berücksichtigt werden sollen.
	(optional) noFoundResult: Das Ergenis das zurückgegeben wird, wenn kein etnsprechende Fahrzeug in der Umgebung gefunden wurde. Default ("").
	(optional) radius: Der Radius der Suche. Default (50).
	
Return: 
	Wenn erfolgreich dann der "Classname", der 'noFoundResult' Parameter.

/*-------------------------------------------------------------------*/

private["_position"];
_position = [_this, 0, [0,0,0], [[]]] call BIS_fnc_param;
if (str(_position) == "[0,0,0]") exitwith {["Invalid _position parameter"] call BIS_fnc_error; false };

private["_classnames"];
_classnames = [_this, 1, [], [[]]] call BIS_fnc_param;
if (count _classnames == 0) exitwith {["Invalid _classnames parameter"] call BIS_fnc_error; false };

private["_noFoundResult"];
_noFoundResult = [_this, 2, "", [""]] call BIS_fnc_param;

private["_radius"];
_radius = [_this, 3, -1, [0]] call BIS_fnc_param;
if (_radius < 1) then { _radius = 50; };

/*-------------------------------------------------------------------*/

private["_objects"];
_objects = nearestObjects [_position, _classnames, _radius];
private["_vehicleClassname"];
if (count _objects > 0) then
{
	_vehicleClassname =  typeof (_objects select 0);
}
else
{
	_vehicleClassname = _noFoundResult;
};

_vehicleClassname