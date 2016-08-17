// Gibt die Anzahl der Repawn-Town Punkte zurück, unabhängig davon ob BlueFor in der Nähe ist, oder nicht.
params ["_position", "_radius"];

private _mortars = nearestObjects[_position, ["I_Mortar_01_F"], _radius];
private _result = objNull;
{
	if (canFire _x ) exitWith { _result=_x;};
} foreach _mortars;

_result;