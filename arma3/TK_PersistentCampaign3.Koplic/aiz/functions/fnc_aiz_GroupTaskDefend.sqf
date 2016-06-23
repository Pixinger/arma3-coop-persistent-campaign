#include "..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

/*
	Zum Größtenteil basiert dieses Skript auf Code aus der Funktion: "BIS_fnc_taskDefend";	
	Das Verhalten ist sehr ähnlich, aber für unsere Zwecke angepasst.
*/
// ----------------------------------
// THIS
// ----------------------------------
params ["_group", "_position",["_guardRadius", 30]];
if (_guardRadius < 10) then { _guardRadius = 10; };

// ----------------------------------
// Die Gruppe komplett auf SAFE setzen
_group setBehaviour "SAFE";
// ----------------------------------
// All alten Wegpunkte entfernen
{ deleteWaypoint _x; } foreach (waypoints _group);

// ----------------------------------
// Der Gruppenführer soll stehen bleiben
private _units = (units _group);// - [leader _group]; 

// ----------------------------------
// Statische Waffen suchen
private _staticWeapons = _position nearObjects ["StaticWeapon", _guardRadius];
_emptyStaticWeapons = [];
{
	if ((_x emptyPositions "gunner") > 0) then { _emptyStaticWeapons pushBack _x; };
} forEach _staticWeapons;

// ----------------------------------
// Statische Waffe besetzen
{
	// Noch Einheiten verfügbar um Waffen zu besetzen?
	if ((count _units) > 0) then 
	{
		if ((random 1) > 0.2) then 
		{
			private _unit = (_units select ((count _units) - 1));
			
			_unit assignAsGunner _x;			
			_unit moveInGunner _x;
			
			_units resize ((count _units) - 1);
		};
	};
} forEach _emptyStaticWeapons;

// ----------------------------------
// Der Rest soll hier in der Gegend wache halten
{
	private _randomPosition = [([_position, _guardRadius] call CBA_fnc_randPos), "SoldierWB"] call PIX_fnc_FindEmptyPositionClosest;	
	//[_x, _randomPosition, true] spawn fnc_aiz_DoMoveEx;
	doStop _x;
	_x setPosATL (_randomPosition);
	_x setDir (random 360);
	_x setBehaviour "SAFE";
	_x setSpeedMode "NORMAL";
} foreach _units;