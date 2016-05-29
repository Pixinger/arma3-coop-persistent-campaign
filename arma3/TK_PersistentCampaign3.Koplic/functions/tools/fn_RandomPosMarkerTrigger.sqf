/*
	Author: Pixinger (base on Karel Moricky BIS_fnc_RandomPosTrigger)

	Description:
	Selects random position withing trigger or Marker

	Parameter(s):
	_this select 0:
		OBJECT - trigger (automatically sets area param)
		STRING - marker

	Returns:
	ARRAY - [x,y,z]
*/
params ["_location"];

private "_area";
private "_position";

//--- Marker
if (typename _location == typename "") then 
{
	_area = (markersize _location) + [markerdir _location,markershape _location == "rectangle"];
	_position = markerpos _location;
}
else
{
	//--- Trigger
	if (typename _location == typename objnull) then 
	{
		_area = triggerarea _location;
		_position = position _location;
	};
};

//--- Position
private _positionX = _position select 0;
private _positionY = _position select 1;

//--- Area
private _areaX = _area select 0; 
private _areaY = _area select 1;
private _areaDir = _area select 2;

//--- Random position
private _vector = if (_area select 3) then
{	//--- Rectangle
	[
		(-_areaX + 2 * random _areaX),
		(-_areaY + 2 * random _areaY)
	];
} 
else 
{	//--- Ellipse
	private _ranDir = random 360;
	[
		(cos _ranDir * random _areaX),
		(sin _ranDir * random _areaY)
	];
};

//--- Rotate according to area
_vector = [_vector, -_areaDir] call BIS_fnc_rotateVector2D;

//--- Convert to world coordinates
[
	_positionX + (_vector select 0),
	_positionY + (_vector select 1),
	0
];