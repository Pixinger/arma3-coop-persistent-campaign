waitUntil { aizLoaded };

/*
	BIS_fnc_TaskDefend
	File: taskDefend.sqf
	Author: Joris-Jan van 't Land

	Description:
	Group will man nearby static defenses and guard the position.

	Parameter(s):
	_this select 0: group (Group)
	_this select 1: defense position (Array)
	
	Returns:
	Boolean - success flag
*/




/*
	File: taskAttack.sqf
	Author: Joris-Jan van 't Land

	Description:
	Group will attack the position.

	Parameter(s):
	_this select 0: group (Group)
	_this select 1: attack position (Array)
	
	Returns:
	Boolean - success flag
*/


/*
	File: taskPatrol.sqf
	Author: Joris-Jan van 't Land

	Description:
	Create a random patrol of several waypoints around a given position.

	Parameter(s):
	_this select 0: the group to which to assign the waypoints (Group)
	_this select 1: the position on which to base the patrol (Array)
	_this select 2: the maximum distance between waypoints (Number)
	_this select 3: (optional) blacklist of areas (Array)
	
	Returns:
	Boolean - success flag
*/
