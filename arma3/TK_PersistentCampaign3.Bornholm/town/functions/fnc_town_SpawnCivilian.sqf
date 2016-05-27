diag_log format["fnc_town_SpawnCivilian: _this = %1", _this];
//==========================================================================================
// THIS
//==========================================================================================
params["_townIndex"];

//==========================================================================================
// HÄUSLE suchen
private _position = [[format["markerTown%1",_townIndex],0], [true]] call fnc_aiz_GetRandomPositionHouse;
if (count _position == 0) exitWith { [format["No Spawnposition for civilian found: townIndex=%1", _townIndex]] call BIS_fnc_error; };
_position = (_position select 0) buildingPos (_position select 1);

//==========================================================================================
// Unit erstellen
private _group = createGroup civilian;
private _unit = _group createUnit [townCivClassnames call fnc_aiz_RandomElement, _position, [], 0, "FORM"];
_unit setPos _position;
_unit setDir (random 360);
_unit setUnitAbility 0;
_unit setBehaviour "CARELESS";

private["_markerName"];
_markerName = createMarker [format["markerCiv%1_%2", _townIndex, floor(random 999999)], (getPos _unit)];
_markerName setMarkerShape "ICON";
_markerName setMarkerType "o_inf";
_markerName setMarkerSize [0.4, 0.4];
_markerName setMarkerColor "ColorBlue";
_markerName setMarkerAlpha 1;

#define STATE_RELAXING			1
#define STATE_THINKING			2
#define STATE_WALKING			3
#define STATE_WALKING_HOME		4
#define STATE_WALKING_SUPPLY	5
#define STATE_EXIT				6
#define STATE_SEARCH_SUPPLIES	7
#define STATE_GOHOME 			8
#define STATE_GOSOMEWHERE		9

private _ttl = 0;
private _target = [];
private _supply = objNull;
private _minDistance = [0,0] distanceSqr [10,0];

private _state = 0;
private _run = (townActive select _townIndex);
while { _run } do 
{
	_markerName setMarkerPos (getPos _unit);
	
	switch (_state) do 
	{
		case STATE_THINKING: 
		{ 
			// Early out
			if (townActive select _townIndex) exitWith { _state = STATE_EXIT; };

			// Supplies suchen ist immer das Wichtigste!
			private _supplies = nearestObjects [_unit, townSupplyClassnames, townSupplySearchRadius];
			if (count _supplies > 0) then
			{
				_target = [0,0,0];//(getPos (_supplies select 0));
				_unit doMove _target;
				_state = STATE_WALKING;			
			}
			else
			{
				switch (floor(random 3)) do 
				{
					case 1: 
					{
						_state = STATE_GOHOME;
					};
					case 2:
					{
						_state = STATE_GOSOMEWHERE;
					};
					default
					{
						_state = STATE_RELAXING;
					};
				};
			};			
		};
		case STATE_GOHOME:
		{ 
			_target = _position;
			_unit doMove _target;
			_state = STATE_WALKING;			
			_ttl = 100;
		};		
		case STATE_GOSOMEWHERE:
		{ 
			_target = (getPos _unit);
			_target set [0, (_target select 0) - 1000 + random 500];
			_target set [1, (_target select 1) - 1000 + random 500];
			_target = _target findEmptyPosition [0, 100, "SoldierWB"];
			if (count _target == 0) then { _state = STATE_RELAXING; }
			else
			{
				_unit doMove _target;
				_state = STATE_WALKING;
				_ttl = 100;
			};						
		};
		case STATE_RELAXING:
		{ 
			private _idleTime = random 60;
			
			if (_idleTime > 10) then
			{
				if (random 1 < 0.5) then
				{
					doStop _unit;
					sleep 0.5;			
					_unit action ["SitDown", _unit];
				};
			};
			
			while { _idleTime > 0 } do
			{
				Sleep 2;
				_idleTime = _idleTime - 2;
				
				// Town Inactive
				if (townActive select _townIndex) exitWith { _state = STATE_EXIT; };

				// Alive
				if (!alive _unit) exitWith { _state = STATE_EXIT; };
			};
			
			_state = STATE_THINKING;
		};
		case STATE_WALKING:
		{
			while {true} do
			{
				Sleep 2;
				
				_ttl = _ttl - 1;
				if (_ttl == 0) exitWith { _state = STATE_THINKING; };
				
				// Town Inactive
				if (townActive select _townIndex) exitWith { _state = STATE_EXIT; };

				// Alive
				if (!alive _unit) exitWith { _state = STATE_EXIT; };

				if (_target distanceSqr (getPos _unit) < _minDistance) exitWith
				{
					Sleep 2; // Noch mal kurz warten
					
					_state = STATE_THINKING;
				};
			};			
		};		
		case STATE_WALKING_HOME: 
		{
			while {true} do
			{
				Sleep 2;

				_ttl = _ttl - 1;
				if (_ttl == 0) exitWith { _state = STATE_EXIT; };
				
				// Town Inactive
				if (townActive select _townIndex) exitWith { _state = STATE_EXIT; };

				// Alive
				if (!alive _unit) exitWith { _state = STATE_EXIT; };

				// Ziel erreicht
				if (_target distanceSqr (getPos _unit) < _minDistance) exitWith
				{
					if (random 1 > 0.5) then {_state = STATE_EXIT;}
					else {_state = STATE_RELAXING;};
				};
			};			
		};		
		case STATE_WALKING_SUPPLY: 
		{
			while {true} do
			{
				Sleep 2;
				
				_ttl = _ttl - 1;
				if (_ttl == 0) exitWith { _state = STATE_THINKING; };

-				// Town Inactive
				if (townActive select _townIndex) exitWith { _state = STATE_EXIT; };
				
				// Alive
				if (!alive _unit) exitWith { _state = STATE_EXIT; };

				// Ziel erreicht
				if (_target distanceSqr (getPos _unit) < _minDistance) exitWith
				{
					Sleep 2; // Noch mal kurz warten
					private _supplies = nearestObjects [getPos _unit, townSupplyClassnames, 10];
					if (count _supplies > 0) then
					{
						private _supply = _supplies select 0;
						_supply setDamage ((damage _supply) - 0.1);
						if (damage _supply <= 0) then { deleteVehicle _supply; };
						
						private "_townData";
						call compile format["_townData = townData%1;", _townIndex];
						_townData params["_supplies"];
						_supplies = _supplies + 10;
						_townData set [0, _supplies];
					};

					_state = STATE_GOHOME;				
				};
			};			
		};		
		case STATE_EXIT: 
		{ 
			diag_log "STATE_EXIT";
			_run = false;
		};
		default 
		{ 
			[format["Invalid state for state-machine: _state=%1", _state]] call BIS_fnc_error;
			_run = false; // Emergency exit
		};
	};

};

//==========================================================================================
// Nachschub spawnen
if (townActive select _townIndex) then { [_townIndex] call fnc_town_SpawnCivilian; };

//==========================================================================================
// Aufräumen
if (alive _unit) then {deleteVehicle _unit;};
deleteGroup _group;

deleteMarker _markerName;