// Gibt die Anzahl der Repawn-Town Punkte zurück, unabhängig davon ob BlueFor in der Nähe ist, oder nicht.
params ["_position", "_radius"];
private _respawns = nearestObjects[_position, cfgAizCampFieldClassnames, _radius];
private _result = 0;
{
	if (damage _x < 0.9) then {_result=_result+1;};
} foreach _respawns;

_result;