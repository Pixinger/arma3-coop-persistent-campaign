/* 
Ändert eine Zustandsvariable einer Stadt

Parameter:
	_townName: Der Stadtname

Return: 
	_value: Der Wert der Zustandsvariablen
*/

private["_townName"];
_townName = [_this, 0, "", [""]] call BIS_fnc_param;

private["_result"];
if (_townName != "") then
{
	_result = missionNamespace getVariable "TownVar_TotalCivilians_" + _townName;
}
else
{
	_result = 0;
};
_result