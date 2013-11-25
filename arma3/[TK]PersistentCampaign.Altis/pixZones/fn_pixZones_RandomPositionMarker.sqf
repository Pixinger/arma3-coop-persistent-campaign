/* 
Based on: Karel Moricky
Berechnet eine zufällige Position innerhalb eines Markers. 
*/
private["_markerName"];
_markerName = _this select 0;
private["_allowLand"];
_allowLand = _this select 1;
private["_allowWater"];
_allowWater = _this select 2;
private["_border"];
_border = _this select 3;
if (isNil "_border") then { _border = 0; };

private["_sizeX"];
_sizeX = ((markersize _markerName) select 0) - _border;
private["_sizeY"];
_sizeY = ((markersize _markerName) select 1) - _border;

private["_result"];
_result = [0,0];

private["_loopLimit"];
_loopLimit = 100;
while { _loopLimit > 0 } do
{
	_loopLimit = _loopLimit - 1;
	_vector = if ((markershape _markerName) == "rectangle") then 
	{
		/* Rectangle */
		[
			(-_sizeX + 2 * random _sizeX),
			(-_sizeY + 2 * random _sizeY)
		];
	} 
	else 
	{
		/* Ellipse */
		private ["_rnd"];
		_rnd = random 360;
		[
			(cos _rnd * (random _sizeX)),
			(sin _rnd * (random _sizeY))
		];
	};

	/* Rotieren */
	_vector = [_vector, -(markerdir _markerName)] call bis_fnc_rotateVector2D;

	/* Result erstellen */
	private["_position"];
	_position = [
		((markerpos _markerName) select 0) + (_vector select 0),
		((markerpos _markerName) select 1) + (_vector select 1),
		0
	];
	if (_allowLand && (!surfaceIsWater _position)) then { _result = _position; _loopLimit = 0;};
	if (_allowWater && (surfaceIsWater _position)) then { _result = _position; _loopLimit = 0;};
};	

_result;