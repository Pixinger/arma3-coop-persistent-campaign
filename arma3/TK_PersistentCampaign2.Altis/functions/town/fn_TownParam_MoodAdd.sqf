/* 
Addiert die Zustandsvariable einer Stadt mit einem bestimmten Wert.

Parameter:
	_townName: Der Stadtname
	_value: Der Wert um den der Originalwert verändert werden soll.

Return: 
	nichts	
*/

private["_townName"];
_townName = [_this, 0, "", [""]] call BIS_fnc_param;
private["_value"];
_value = [_this, 1, 0, [2000]] call BIS_fnc_param;

if (_townName != "") then
{
	private["_varname"];
	_varname = format["TownVarMood%1", _townName];
	missionNamespace setVariable [_varname, (missionNamespace getVariable [_varname, 0]) + _value];
};