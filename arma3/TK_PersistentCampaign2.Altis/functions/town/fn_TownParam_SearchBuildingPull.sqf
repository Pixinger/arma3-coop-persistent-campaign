/* 
Fragt die Zustandsvariable einer Stadt ab und setzt sie automatisch auf 0.

Parameter:
	_townName: Der Stadtname

Return: 
	Der aktuelle Wert der Variablen
*/

private["_townName"];
_townName = [_this, 0, "", [""]] call BIS_fnc_param;

private["_varname"];
_varname = format["TownVarSerBui%1", _townName];
private["_result"];
_result = missionNamespace getVariable _varname;
if (count _result > 0) then { missionNamespace setVariable [_varname, []]; };
//diag_log format["sb_ pull: %1 %2 %3", _townName, _varname, _result];
	
_result;