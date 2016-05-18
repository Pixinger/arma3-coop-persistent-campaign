diag_log format["fnc_aiz_RunGroup: _this = %1", _this];
waitUntil { aizLoaded };

private _zoneIndex = _this select 0;
private _waypointCount = 5; // _this select 0;
private _unitClassnames = ["O_recon_TL_F", "O_soldierU_AT_F", "O_support_MG_F", "O_spotter_F", "O_diver_F"];

//================================================================================
// Startbedingungen prüfen
//================================================================================
if (isNil format["aizWaypointPoolZone%1", _zoneIndex]) exitWith	{ [format["No waypoints for zoneIndex %1 found.", _zoneIndex]] call BIS_fnc_error; false; };
diag_log "waypoints OK";

private "_waypointPool";
call compile format["_waypointPool = aizWaypointPoolZone%1", _zoneIndex];
if (count _waypointPool < 3) exitWith { [format["Not enough waypoints for zoneIndex %1 found.", _zoneIndex]] call BIS_fnc_error; false; };
if (count _waypointPool < _waypointCount) then { _waypointCount = count _waypointPool; };

//================================================================================
// Haupteinheit erstellen
//================================================================================
private _group = createGroup east;
private _unit = _group createUnit [_unitClassnames select 0, _waypointPool call fnc_aiz_RandomElement, [], 0, "FORM"];
_unit setUnitAbility (random 1);	//[_unit,6] call bis_fnc_setRank; //["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"];

//================================================================================
// Wegunkte erstellen
//================================================================================
for "_i" from 1 to _waypointCount - 1 do
{
	private ["_wp", "_newPos"];

	private _waypoint = _group addWaypoint [_waypointPool call fnc_aiz_RandomElement, 0];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointCompletionRadius 20;

	// Am ersten Wegpunkt Formation und Geschwindigkeit setzen.
	if (_i == 1) then
	{
		_waypoint setWaypointSpeed "LIMITED";
		_waypoint setWaypointFormation "STAG COLUMN";
	};
};

// Zurück zum ersten Wegpunkt gehen
private _waypoint = _group addWaypoint [_waypointPool call fnc_aiz_RandomElement, 0];
_waypoint setWaypointType "CYCLE";
_waypoint setWaypointCompletionRadius 20;

private["_markerName"];
_markerName = createMarkerLocal [format["markerUT%1_%2", _zoneIndex, random 999999], (getPos (leader _group))];
_markerName setMarkerShapeLocal "ICON";
_markerName setMarkerTypeLocal "o_inf";
_markerName setMarkerSizeLocal [0.3, 0.3];
_markerName setMarkerColorLocal "ColorRed"; 
_markerName setMarkerAlphaLocal 0.4;
//================================================================================
// Überwachung der Gruppe beginnen
//================================================================================
while { true } do
{
	// Zustand "reduced"	
	while { true } do 
	{
		Sleep 5;
		_markerName setMarkerPosLocal (getPos (leader _group));
		if (!(aizZoneActive select _zoneIndex)) exitWith {diag_log "inactive 1";diag_log format["%1 %2", aizZoneActive select _zoneIndex, aizZoneActive];};
		if (count ((getPos (leader _group)) nearEntities ["SoldierWB", 600]) > 0 ) exitWith {diag_log "enemy near";};
diag_log "RunGroup: ist reduziert";
	};

	if (!(aizZoneActive select _zoneIndex)) exitWith {diag_log "inactive 2";};
diag_log "RunGroup: wird erweitert";
	
	// expand group
	for "_i" from 1 to (count _unitClassnames)-1 do
	{
		_unit = _group createUnit [_unitClassnames select _i, (getPos (leader _group)), [], 0, "FORM"];
		_unit setUnitAbility (random 1);	
diag_log format["RunGroup: Einheit erweitert: %1", _unit];
	};

	// Zustand "expanded"	
	while { true } do
	{
		Sleep 5;
		_markerName setMarkerPosLocal (getPos (leader _group));
		if (!(aizZoneActive select _zoneIndex)) exitWith {diag_log "inactive 3";};
		if (count ((getPos (leader _group)) nearEntities ["SoldierWB", 600]) == 0) exitWith {diag_log "enemy near";};
diag_log "RunGroup: ist erweitert";
	};
	
	if (!(aizZoneActive select _zoneIndex)) exitWith {diag_log "inactive 4";};
diag_log "RunGroup: wird reduziert";

	// reduce group
	while { (count units _group > 1) } do
	{
		_unit = (units _group) select (count (units _group)-1);		
diag_log format["RunGroup: Einheit reduziert: %1", _unit];
		deleteVehicle _unit;		
	};	
};

diag_log format["RunGroup: Gruppe wird aufgelöst: %1", _group];
//================================================================================
// Gruppe auflösen
//================================================================================
{ deleteWaypoint _x; } foreach (waypoints _group);
{ deleteVehicle _unit; } foreach (units _group);
deleteGroup _group;
diag_log "RunGroup: ist aufgelöst";