/*
	Zum Größtenteil basiert dieses Skript auf Code aus der Funktion: "BIS_fnc_taskDefend";	
	Das Verhalten ist sehr ähnlich, aber für unsere Zwecke angepasst.
*/
_this params ["_group", "_position"];
private _guardRadius = if (count _this < 3) then { 30 } else { _this select 2 };
private _staticWeapons = _position nearObjects ["StaticWeapon", _guardRadius + 70];
private _units = (units _group) - [leader _group]; //The Gruppenführer sollte keine Waffen besetzen
_emptyStaticWeapons = [];
{
	if ((_x emptyPositions "gunner") > 0) then { _emptyStaticWeapons pushBack _x; };
} forEach _staticWeapons;

// Statische Waffe besetzen
{
	// Noch Einheiten verfügbar um Waffen zu besetzen?
	if ((count _units) > 0) then 
	{
		if ((random 1) > 0.2) then 
		{
			private _unit = (_units select ((count _units) - 1));
			
			_unit assignAsGunner _x;			
			_unit moveInGunner _x;	//[_unit] orderGetIn true;
			
			_units resize ((count _units) - 1);
		};
	};
} forEach _emptyStaticWeapons;

// Der Rest soll an der Position Wache schieben
private _waypointGuard = _group addWaypoint [_position, _guardRadius];
_waypointGuard setWaypointType "GUARD";

// Einige Einheiten hinsetzen lassen
private _handle = _units spawn 
{
	sleep 5;

	{
		sleep random 5;
		if ((random 1) > 0.4) then 
		{
			doStop _x;			
			sleep 0.5;			
			_x action ["SitDown", _x];	
		};	
	} forEach _this;
};
