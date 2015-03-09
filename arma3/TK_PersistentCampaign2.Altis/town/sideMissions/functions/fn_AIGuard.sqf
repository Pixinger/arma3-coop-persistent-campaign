private["_centerPosition"];
_centerPosition = [_this, 0, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
if (str(_centerPosition)=="[0,0,0]") exitwith {["Invalid centerPosition parameter"] call BIS_fnc_error; false};