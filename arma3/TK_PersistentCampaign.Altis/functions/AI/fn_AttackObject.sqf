/* 
	Diese Funktion stellt sicher, dass eine Gruppe eine bestimmte Position patrolliert.
	
Parameter:
	group: Die Gruppe welche die Position verteidigen soll.
	attackPosition: Die Position die angegriffen werden soll.
	
	
Return: 
	Wenn erfolgreich true, sonst false.

/*-------------------------------------------------------------------*/

if (!isServer) exitWith {false};

private["_group"];
_group = [_this, 0, grpNull, [grpNull]] call BIS_fnc_param;
if (isNull _group) exitwith {["Invalid _group parameter"] call BIS_fnc_error; false};

private["_attackPosition"];
_attackPosition = [_this, 1, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
if (str(_attackPosition)=="[0,0,0]") exitwith {["Invalid _attackPosition parameter"] call BIS_fnc_error; false};

/*-------------------------------------------------------------------*/

/* Wegpunkt für die Gruppe */
private["_waypoint"];
_waypoint = _group addWaypoint [_attackPosition, 15];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointStatements ["True", ""];
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "AWARE";
_waypoint setWaypointCombatMode "RED";		
/*_waypoint setWaypointTimeout [10, 30, 60]; */
/*_waypoint setWaypointStatements ["true", "missionsRev_AttackFinished = true;"];*/

true