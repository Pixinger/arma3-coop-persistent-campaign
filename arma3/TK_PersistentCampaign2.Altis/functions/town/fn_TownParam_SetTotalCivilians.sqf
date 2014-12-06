/* 
Ändert eine Zustandsvariable einer Stadt

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
	missionNamespace setVariable ["TownVar_TotalCivilians_" + _townName,3]; 	
};