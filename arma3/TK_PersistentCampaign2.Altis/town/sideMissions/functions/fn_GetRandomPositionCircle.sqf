/* 
	Berechnet eine zufällige Position innerhalb eines Kreises mit definiertem Radius.

Parameter:
	_objectPosition: Die Position
	_objectRadius: Der Radius

Return: 
	The random position. [0,0,0] if no position was found or parameter was invalid.

/*-------------------------------------------------------------------*/

private["_objectPosition"];
_objectPosition = [_this, 0, [0,0,0], [[]], [2,3]] call BIS_fnc_param;

private["_objectRadius"];
_objectRadius = [_this, 1, 0, [0]] call BIS_fnc_param;

/*-------------------------------------------------------------------*/

private["_result"];
_result = [0,0,0];

if ((str(_objectPosition) != "[0,0,0]") && (_objectRadius > 0)) then
{
	private ["_rnd"];
	_rnd = random 360;
	_result = [(_objectPosition select 0) + (cos _rnd * (random _objectRadius)),(_objectPosition select 1) +(sin _rnd * (random _objectRadius)), 0];
};					

_result;