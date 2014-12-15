/* 
Fragt die Zustandsvariable einer Stadt ab und setzt sie automatisch auf 0.

Parameter:
	_townName: Der Stadtname

Return: 
	Der aktuelle Wert der Variablen
*/

private["_townName"];
_townName = [_this, 0, "", [""]] call BIS_fnc_param;
private["_result"];

private["_varname"];
_varname = format["TownVarFood%1", _townName];
_result = missionNamespace getVariable [_varname, 0];		
missionNamespace setVariable [_varname, 0];
_result;