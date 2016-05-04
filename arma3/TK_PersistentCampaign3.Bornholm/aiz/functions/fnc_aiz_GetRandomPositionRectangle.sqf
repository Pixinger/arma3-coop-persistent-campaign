/* 
	Berechnet eine zufällige Position innerhalb einees Rechtecks.

Parameter:
	_centerX
	_centerY
	_width
	_height
	_safetyBorder (optional)

Return: 
	The random position. [0,0,0] if no position was found or markername was invalid.

/*-------------------------------------------------------------------*/

private["_centerX"];
_centerX = [_this, 0, 0, [0]] call BIS_fnc_param;
if (_centerX < 0) then { _centerX = 0; };

private["_centerY"];
_centerY = [_this, 1, 0, [0]] call BIS_fnc_param;
if (_centerY < 0) then { _centerY = 0; };

private["_width"];
_width = [_this, 2, 0, [0]] call BIS_fnc_param;
if (_width < 0) then { _width = 0; };

private["_height"];
_height = [_this, 3, 0, [0]] call BIS_fnc_param;
if (_height < 0) then { _height = 0; };

private["_safetyBorder"];
_safetyBorder = [_this, 4, 0, [0]] call BIS_fnc_param;
if (_safetyBorder < 0) then { _safetyBorder = 0; };

/*-------------------------------------------------------------------*/

private["_result"];
_result = [_centerX + (-(_width - _safetyBorder) + (2 * random (_width - _safetyBorder))), _centerY + (-(_height - _safetyBorder) + (2 * random (_height - _safetyBorder))), 0];

_result;