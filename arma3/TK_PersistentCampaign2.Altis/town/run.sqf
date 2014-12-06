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
// _homes = [  [building-obj, [_room, _room, ...]],     [building-obj, [_room, _room, ...]],    ...   ]
// _room (frei)       = [[x,y,z]]
// _room (deaktviert) = [[x,y,z], classname, isEnemy]
// _room (aktviert)   = [[x,y,z], classname, isEnemy, unit-obj]
//----------------------------------------------------------------------------------------------------------------

// Wohnungen erstellen (Home-Array)
private["_homes"];
_homes = [_townCenter, _townRadius] call PC_fnc_TownHome_Create;
player globalChat format["found %1 homes", count _homes];

private["_maxResidents"];
_maxResidents = [_homes] call PC_fnc_TownHome_MaxResidents;
player globalChat format["found %1 maxResidents", _maxResidents];

// In die Wohnungen einziehen
private["_settleResult"];
_settleResult = [_homes, 100, 100]call PC_fnc_TownHome_SettleAllResidents;
player globalchat format["_settleResult: %1", _settleResult];


{
	_position = [getpos (_x select 0) select 0, getpos (_x select 0) select 1, (getpos (_x select 0) select 2) + 10];
	_veh = "Sign_Arrow_Large_F" createVehicle _position;
	_veh setpos (_position);
	
} foreach _homes;

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

*/


