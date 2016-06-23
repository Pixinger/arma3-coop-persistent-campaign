private _centerPosition = _this select 0;
private _classname = _this select 1;
private _steps = if (count _this > 2) then { _this select 2; } else { 5 };

// Freien Platz suchen
private _distance = _steps;
private _position = _centerPosition findEmptyPosition [0, _distance, _classname];
while { count _position == 0 } do
{
	_distance = _distance + _steps;
	_position = _centerPosition findEmptyPosition [0, _distance, _classname];
};
//diag_log format["_distance: %1", _distance];
_position;