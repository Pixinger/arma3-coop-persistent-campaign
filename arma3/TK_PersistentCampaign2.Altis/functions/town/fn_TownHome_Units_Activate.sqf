/*
Aktiviert Einheiten in einem Home-Array.
Die Anzahl der zu aktivierenden Einheiten wird als Parameter übergeben.
 
Parameter:
	_homes: Das zu belegende Home-Array.
	_classnames: Eine Liste mit den Classnames, die vorgeben von welchen Typ der "Room" bewohnt wird.
	             Wenn _classnames=[] ist, dann wird nur geprüft, ob der "Room" inaktiv ist.
	_count: Die Anzahl der zu aktivierenden Einheiten.

Return: 
	Die Anzahl der aktivierten Einheiten.	
	Wenn keine Einheit erstellt werden konnte, kann das daran liegen, dass ein Spieler in der Nähe ist und das Spawnen dadurch verhindert.	
*/

private["_homes"];
_homes = _this select 0;
private["_classnames"];
_classnames = _this select 1;
private["_unitsActive"];
_unitsActive = _this select 2;
private["_count"];
_count = _this select 3;
private["_side"];
_side = _this select 4;
private["_fsm"];
_fsm = _this select 5;
private["_externData1"];
_externData1 = _this select 6;

private["_result"];
_result = 0;

private["_i"];
for "_i" from 1 to _count do
{
	private["_room"]; //room: [position, classname, unit-obj]
	_room = [_homes, _classnames] call PC_fnc_TownHome_GetInactiveRoom;
	
	if (count _room != 0) then // Wenn Spieler in der Nähe sind, kann es sein dass diese vorhandene Räume blockieren.
	{
		private["_classname"];
		_classname = _room select 1;
		private["_unitPosition"];
		_unitPosition = _room select 0;
		if (count _unitPosition > 0) then
		{
			private ["_unitGroup"];
			_unitGroup = createGroup _side;
			
			private["_unit"];
			_unit = _unitGroup createUnit [_classname, _unitPosition, [], 0, "FORM"];
			waitUntil {!isNil "_unit"};
			_unit setDir (floor(random 360));
			_unit setpos _unitPosition;
			_unit setSpeedmode "FULL";
			_unit setVariable ["townExternData1", _externData1];
			_unit doFSM [_fsm, _unitPosition, _unit];
			
			_room set [2, _unit];
			
			_unitsActive set [(count _unitsActive), [_unit, _unitGroup, _room]];			
			
			_result = _result + 1;
			
			player globalchat "unit created";
		};
	};
};

_result;