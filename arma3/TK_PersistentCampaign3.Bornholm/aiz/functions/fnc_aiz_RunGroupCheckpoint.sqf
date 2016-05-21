diag_log format["fnc_aiz_RunGroupCheckpoint: _this = %1", _this];
waitUntil { aizLoaded };

private _zoneIndex = _this select 0;		
private _checkpoint = _this select 1;		// z.B.: [_positionArray, _direction]

#define STATE_START		0
#define STATE_STOP		1
#define STATE_REDUCEGROUP	2
#define STATE_EXPANDGROUP	3

//================================================================================
// Einheiten erstellen
//================================================================================
private _group = [_checkpoint select 0, EAST, 5] call BIS_fnc_spawnGroup;

[_group, _checkpoint select 0] spawn bis_fnc_taskDefend;


//================================================================================
// Warten bis inaktiv
//================================================================================
while { true } do
{
	Sleep 5;
	if (!(aizZoneActive select _zoneIndex)) exitWith {diag_log "inactive 1";diag_log format["%1 %2", aizZoneActive select _zoneIndex, aizZoneActive];};
};

//================================================================================
// Gruppe auflösen
//================================================================================
{ deleteVehicle _x; } foreach (units _group);
{ deleteWaypoint _x; } foreach (waypoints _group);
deleteGroup _group;
diag_log format["RunGroupCheckpoint%1: Gruppe aufgeloest: %2", _zoneIndex, _group];

private _stateMachine = STATE_START;
while { true } do 
{
	switch (_condition) do 
	{
		case STATE_START: 
		{ 
			hint "1" 
		};
		case STATE_STOP: 
		{ 
			hint "2" 
		};
		case STATE_REDUCEGROUP:
		{
			// Gruppe reduzieren
			while { (count units _group > 1) } do
			{
				_unit = (units _group) select (count (units _group)-1);		
				deleteVehicle _unit;		
			};			
		};
		case STATE_EXPANDGROUP:
		{
			// Grupper erweitern
			for "_i" from 1 to (count _unitClassnames)-1 do
			{
				_unit = _group createUnit [_unitClassnames select _i, (getPos (leader _group)), [], 0, "FORM"];
				_unit setDir (getDir (leader _group));
				_unit setUnitAbility (random 1);	
			};
		};
		default 
		{ 
			diag_log "Invalid state in statemachine";
		};
	};
};};