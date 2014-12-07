/*
Sucht innerhalb des Home-Arrays nach allen inaktiven "Rooms" die als Spawn für eine KI-Einheit verwendet werden könnten.
Dabei wird berücksichtigt, ob Spieler in der Nähe sind, oder nicht.
 
Parameter:
	_homes: Das zu belegende Home-Array.
	_classnames: Eine Liste mit den Classnames, die vorgeben von welchen Typ der "Room" bewohnt wird.
	             Wenn _classnames=[] ist, dann wird nur geprüft, ob der "Room" inaktiv ist.

Return: 
	[] wenn kein verfügbarer "Room" gefunden werden konnte, sonst [room, room, ...].
	
*/

private["_homes"];
_homes = _this select 0;

private["_classnames"];
_classnames = _this select 1;

private["_players"];
_players = [] call PC_fnc_GetNearestPlayers;

private["_rooms"];
_rooms = [];

private["_countHomes"];
_countHomes = count _homes;

private["_homeIndex"];
_homeIndex = 0;	
while { (_homeIndex < _countHomes) } do
{
	private["_home"];
	_home = _homes select _homeIndex;

	private["_countRooms"];
	_countRooms = count (_home select 1);

	private["_roomIndex"];
	_roomIndex = 0;
	while { ((!_found) and (_roomIndex < _countRooms)) } do
	{
		private["_room"];
		_room = (_home select 1) select _roomIndex;
		
		if (count _room == 2) then // if _room is occopied, but not active
		{
			if ((_room select 1) in _classnames) then
			{
				if (!([_room select 0, 100] call PC_fnc_IsAnyPlayerNear)) then
				{
					_rooms set [count _rooms, _room]; // Ein (weiterer) passender "Room" gefunden.
				};
			};
		}

		_roomIndex = _roomIndex + 1;
	};
	
	_homeIndex = _homeIndex + 1;
};

_rooms;