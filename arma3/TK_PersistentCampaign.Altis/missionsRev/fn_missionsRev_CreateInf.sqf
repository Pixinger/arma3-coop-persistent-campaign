private["_result"];
_result = [];

if (isServer) then
{	
	/* _this parameter */
	private["_zonenIndex"];
	_zonenIndex = _this select 0;
	private["_stopPosition"];
	_stopPosition = _this select 1;

	/* Start Position berechnen */
	private["_markerName"];
	_markerName = format["Zone%1", _zonenIndex];
	private["_startPosition"];
	_startPosition = ([_markerName, [], 0, 0] call fn_missionsOpt_RandomPositionField) select 0;
	if (str(_startPosition) != "[0,0,0]") then
	{
		/* Rückgabe-Arrays initialisieren */
		private["_units"];
		_units = [];
		private["_groups"];
		_groups = [];
		private["_waypoints"];
		_waypoints = [];
		private["_vehicles"];
		_vehicles = [];
		
		/* Infantrie Gruppe erzeugen */
		private["_group"];
		_group = [_startPosition, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
		[_group] call fn_missionsOpt_SetSkill;
		_groups = _groups + [_group];
		_units = _units + (units _group);

		/* Wegpunkt für die Gruppe */
		private["_waypoint"];
		_waypoint = _group addWaypoint [_stopPosition, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointStatements ["True", ""];
		_waypoint setWaypointSpeed "FULL";
		_waypoint setWaypointBehaviour "AWARE";
		_waypoint setWaypointCombatMode "RED";		
		/*_waypoint setWaypointTimeout [10, 30, 60]; */
		/*_waypoint setWaypointStatements ["missionsRev_Engage", "missionsRev_EngageFinished = true;"];*/
		_waypoints = _waypoints + [_waypoint];
		
		/* Rückgabe-Ergebnis fertig machen */
		_result = [_units, _groups, _vehicles, _waypoints]; /* [units, groups, vehicles, waypoints] */	
	};
};

_result;