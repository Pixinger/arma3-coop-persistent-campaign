// Gibt einen "nicht von BlueFor bewachten" Repawn-Town zurück - falls verfügbar
params ["_position", "_radius"];
private _respawns = nearestObjects[_position, cfgAizCampTownClassnames, _radius];
private _result = objNull;
{
	if ((damage _x < 0.9) && ([getPos _x, cfgAizCampTownMinRespawnDistance] call fnc_aiz_IsBlueNear)) exitWith {_result=_x;};
} foreach _respawns;

_result;