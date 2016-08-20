private _centerPosition = _this select 0;
private _objectSize = _this select 1;
private _steps = if (count _this > 2) then { _this select 2; } else { 5 };

// Freien Platz suchen
private _distance = _steps;
private _position = [_centerPosition, 1, _distance, _objectSize, 0, 5, 0] call BIS_fnc_findSafePos;
while { count _position == 0 } do
{
	_distance = _distance + _steps;
	_position = [_centerPosition, 1, _distance, _objectSize, 0, 5, 0] call BIS_fnc_findSafePos;
};

_position;



/*
	File: findSafePos.sqf

	Description:
	Function to retrieve and dynamic position in the world according to several parameters.

	Parameter(s):
	_this select 0: center position (Array)
						Note: passing [] (empty Array), the world's safePositionAnchor entry will be used.
	_this select 1: minimum distance from the center position (Number)
	_this select 2: maximum distance from the center position (Number)
						Note: passing -1, the world's safePositionRadius entry will be used.
	_this select 3: minimum distance from the nearest object (Number)
	_this select 4: water mode (Number)
						0: cannot be in water
						1: can either be in water or not
						2: must be in water
	_this select 5: maximum terrain gradient (average altitude difference in meters - Number)
	_this select 6: shore mode (Number):
						0: does not have to be at a shore
						1: must be at a shore
	_this select 7: (optional) blacklist (Array of Arrays):
						(_this select 7) select X: Top-left and bottom-right coordinates of blacklisted area (Array)
	_this select 8: (optional) default positions (Array of Arrays):
						(_this select 8) select 0: default position on land (Array)
						(_this select 8) select 1: default position on water (Array)
	
	Returns:
	Coordinate array with a position solution.
	
	TODO:
	* Maybe allow passing several combinations of position, min and max dist ... so that you can 
	avoid several things?
	* Interpretation of minDist / maxDist is wrong. It's not true distance that is used. Too bad?
*/
