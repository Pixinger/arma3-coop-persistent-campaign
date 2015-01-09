/* 
Addiert die Zustandsvariable einer Stadt mit einem bestimmten Wert.

Parameter:
	_townName: Der Stadtname
	_house: object: das zu durchsuchende Haus

Return: 
	nichts	
*/

private["_townName"];
_townName = [_this, 0, "", [""]] call BIS_fnc_param;
private["_house"];
_house = [_this, 1, objNull, [objNull]] call BIS_fnc_param;
private["_caller"];
_caller = [_this, 2, objNull, [objNull]] call BIS_fnc_param;

//diag_log format["sb_ add: %1", _townName];

if (_townName != "") then
{
	private["_varname"];
	_varname = format["TownVarSerBui%1", _townName];
	(missionNamespace getVariable [_varname, []]) pushBack _house;
};