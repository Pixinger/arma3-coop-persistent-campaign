/* 
Fragt die Zustandsvariable einer Stadt ab und setzt sie automatisch auf 0.

Parameter:
	_townName: Der Stadtname

Return: 
	nix
*/

private["_townName"];
_townName = [_this, 0, "", [""]] call BIS_fnc_param;
private["_varname"];
_varname = format["TownVarSerBui%1", _townName];
missionNamespace setVariable [_varname, []];

//diag_log format["sb_ init: %1", _townName];

true;