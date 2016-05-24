// Gibt einen "nicht von BlueFor bewachten" Repawn-Field zurück - falls verfügbar
params ["_position", "_radius"];
private _respawns = nearestObjects[_position, aizCampFieldClassnames, _radius];
private _result = objNull;
{
	if ((damage _x < 0.9) && ([getPos _x, aizCampFieldMinRespawnDistance] call fnc_aiz_IsBlueNear)) exitWith {_result=_x;};
}} foreach _respawns;

_result;