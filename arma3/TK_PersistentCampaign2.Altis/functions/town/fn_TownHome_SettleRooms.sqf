/*

Mit dieser Funktionen können inakvtive Wohneinheiten des Home-Arrays verändert werden (einziehen/ausziehen).
Wenn der Count-Parameter positiv ist, werden neue Bürger in die entsprechende Anzahl Wohneinheiten einziehen.
Wenn der Count-Parameter negativ ist, werden vorhandene Bürger aus der entsprechenden Anzahl Wohneinheiten ausziehen.
 
Parameter:
	_homes: Das zu belegende Home-Array.
	_classnames: Die Klassennamen der Bewohner.
	_count: Die gesamt Anzahl der zu einziehenden/ausziehenden Bewohner.

Return: 
	Wenn positiv: Die Anzahl der tatsächlich neu belegten Wohneinheiten.
	Wenn negativ: Die Anzahl der tatsächlich entfernten Wohneinheiten.
	Sollten nicht ausreichend inaktive Wohneinheiten gefunden werden, kann sich das Result von dem Count-Parameter unterscheiden. Aktive Wohneinheiten dürfen nicht verändert werden!

*/

private["_homes"];
_homes = _this select 0;
private["_classnames"];
_classnames = _this select 1;
private["_count"];
_count = _this select 2;

private["_result"];
_result = 0;

if (_count > 0) then
{
	while { _result < _count } do
	{
		private["_room"];
		_room = [_homes] call PC_fnc_TownHome_GetUnoccupiedRoom;
		if (count _room == 0) exitWith {};
		
		_result = _result + 1;
		_room set [1, [_classnames] call PC_fnc_RandomElement];
	};
}
else
{
	while { _result > _count } do
	{
		private["_room"];
		_room = [_homes, _classnames] call PC_fnc_TownHome_GetInactiveRoom;
		if (count _room == 0) exitWith {};
		
		_result = _result - 1;
		_room resize 1; // Wohneinheit frei machen
	};
};

_result;