// Statische Variablen
private["_townCenter"];
_townCenter = _this select 0;
private["_townRadius"];
_townRadius = _this select 1;
private["_townName"];
_townName = _this select 2;

//----------------------------------------------------------------------------------------------------------------
// _homes: 
//----------------------------------------------------------------------------------------------------------------
// _homes = [  [building-obj, [_room, _room, ...], searched],     [building-obj, [_room, _room, ...], searched],    ...   ]
// _room (frei)       = [[x,y,z]]
// _room (deaktviert) = [[x,y,z], classname]
// _room (aktviert)   = [[x,y,z], classname, unit-obj]
//----------------------------------------------------------------------------------------------------------------

// Wohnungen erstellen (Home-Array)
private["_homes"];
_homes = [_townCenter, _townRadius] call PC_fnc_TownHome_Create;

//private["_maxResidents"];
//_maxResidents = [_homes] call PC_fnc_TownHome_MaxResidents;
//player globalChat format["found %1 maxResidents", _maxResidents];

// In die Wohnungen einziehen
private["_settleResult"];
_settleResult = [_homes, 0, 100]call PC_fnc_TownHome_SettleAllResidents;
player globalchat format["_settleResult: %1", _settleResult];
//[_homes] call PC_fnc_TownHome_DebugHomes;


private["_civilianSOLL"];
_civilianSOLL = 20;
private["_civiliansActive"];
_civiliansActive = [];

while { true } do 
{
	Sleep(10);
	if (_civilianSOLL > (count _civiliansActive)) then
	{
		private["_count"];
		_count = _civilianSOLL - (count _civiliansActive);
		if (_count > 5) then { _count = 5; };
		
		for "_i" from 1 to _count do
		{
			//room: [position, classname, isEnemy, unit-obj]
			private["_room"];
			_room = [_homes, pixTown_CivilianClassnames] call PC_fnc_TownHome_GetInactiveRoom;
			if (count _room != 0) then // Wenn Spieler in der Nähe sind, kann es sein dass diese vorhandene Räume blockieren.
			{
				private["_classname"];
				_classname = _room select 1;
				private["_unitPosition"];
				_unitPosition = _room select 0;//(_room select 0) findEmptyPosition [0, 100, _classname];
				if (count _unitPosition > 0) then
				{
					private ["_unitGroup"];
					_unitGroup = createGroup independent;
					
					private["_unit"];
					_unit = _unitGroup createUnit [_classname, _unitPosition, [], 0, "FORM"];
					waitUntil {!isNil "_unit"};
					_unit setDir (floor(random 360));
					_unit setpos _unitPosition;
					_unit setSpeedmode "FULL";
					//_unit doMove (getPos player);
					_unit doFSM ["town\fsm\civilian.fsm", _unitPosition, _unit];
					
					_room set [2, _unit];
					
					_civiliansActive set [(count _civiliansActive), [_unit, _unitGroup, _room]];					
					player globalchat "civilian created";
					//player setpos (getpos _unit);
				};
			}
			else
			{
				player globalchat format["WARN: Town: %1. Es konnte kein ROOM gefunden werden in dem eine Einheit gespawnt werden kann. Evtl ist ein Spieler in der Nähe.", _townName];
			};
		};		
	};	
	
	private["_index"];
	_index = 0;
	while { (_index < count _civiliansActive) } do
	{
		if (isNull ((_civiliansActive select _index) select 0)) then 
		{
			deleteGroup ((_civiliansActive select _index) select 1); // gruppe löschen
			((_civiliansActive select _index) select 2) resize 2; // room inaktivieren
			_civiliansActive deleteAt _index; // Aus der Liste nehmen		
			_civilianSOLL = _civilianSOLL - 1;			
		}
		else
		{
			_index = _index + 1;
		};
	};

	diag_log format["alive: %1", count _civiliansActive];	
	[_homes] call PC_fnc_TownHome_DebugHomesActive;
	//[_homes] call PC_fnc_TownHome_DebugHomesInActive;
	player globalchat format["alive: %1", count _civiliansActive];	
};


/*
// Noch ist die Stadt DEAKTIVIERT. 
player sidechat "starting town";
while { true } do
{
	// Solange keine Spieler in die Nähe kommen
	while { !([_townCenter, 1000] call PC_fnc_IsAnyPlayerNear) } do
	{
	
		player sidechat "calc offline";
		// CODE: Stadt weiter verwalten (DEAKTIVIERT)
		Sleep(1);
	};
	
	// CODE: Stadt aktivieren
	// CODE: Festlegen in welchen Wohnungen Feinde wohnen und in welchen Wohnungen Waffen liegen.
	// CODE: Erzeuge _maxVisibleCivilians Zivilisten in der Stadt
		
	// Solange Spieler in der Nähe bleiben
	player sidechat "Stadt aktivert";
	while { ([_townCenter, 1500] call PC_fnc_IsAnyPlayerNear) } do
	{
		player sidechat "calc ONLINE";
		// CODE: Stadt weiter verwalten (AKTIVERT)
		
		
		Sleep(1);
	};
		
	// CODE: Stadt deaktivieren
	// CODE: Alle "durchsuchten" Wohnungen demarkieren
	player sidechat "Stadt deaktivert";
};









/*



Sleep 1;
private ["_tmpGroup"];
_tmpGroup = createGroup east;

private["_myarray"];
private["_mysubarray1"];
_mysubarray1 = [1,2,3];
private["_mysubarray2"];
_mysubarray2 = [4,5,6];
_myarray = [_mysubarray1, _mysubarray2];
player globalchat format["_myarray %1", _myarray];

private["_freePosition"];
_freePosition = (position player) findEmptyPosition [0, 100, "C_man_1_1_F"];
if (count _freePosition > 0) then
{
	_unit = _tmpGroup createUnit ["C_man_1_1_F", _freePosition, [], 0, "FORM"];
	_unit setDir 180;
	_unit setVariable["test", _mysubarray1];
	private["_lll"];
	_lll= _unit getVariable "test";
	player globalchat format["lll %1", _lll];
	
	_lll set [1,100];
	player globalchat format["_myarray %1", _myarray];
	player globalchat format["lll %1", _lll];
};




{
	_position = [getpos (_x select 0) select 0, getpos (_x select 0) select 1, (getpos (_x select 0) select 2) + 10];
	_veh = "Sign_Arrow_Large_F" createVehicle _position;
	_veh setpos (_position);
	
} foreach _homes;

*/

