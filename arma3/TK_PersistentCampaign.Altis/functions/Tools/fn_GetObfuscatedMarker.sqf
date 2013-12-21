/* 
	Berechnet eine verschleierte Position (typischer Weise die eines Markers).

Parameter:
	position: Die Position die verschleiert werden soll. [0,0,0]
	radius: Der maximale Radius der Verschleierung. 

Return: 
	Die verschleierte Position. [[x,y,0], radius]

/*-------------------------------------------------------------------*/

private["_position"];
_position = [_this, 0, [0,0,0], [[]], [2,3]] call BIS_fnc_param;

private["_radius"];
_radius = [_this, 1, 0, [0]] call BIS_fnc_param;

private["_result"];
_result = [[0,0,0],0];
if ((str(_position) != "[0,0,0]") && (_radius > 0)) then
{
	private["_markerX"];
	_markerX = _position select 0;
	private["_markerY"];
	_markerY = _position select 1;
	private["_translationDistance"];
	_translationDistance = random _radius;
	private["_translationAngle"];
	_translationAngle = random 359;

	_markerX = _markerX + (_translationDistance * cos(_translationAngle));
	_markerY = _markerY + (_translationDistance * sin(_translationAngle));

	_result = [[_markerX, _markerY], _radius];
};

_result