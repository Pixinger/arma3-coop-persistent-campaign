/*
Diese Funktion sucht eine unbewohnte Position in dem übergebenen Home-Array.
 
Parameter:
	_homes: Das zu belegende Home-Array.

Return: 
	_room: der unbewohnte _room.
	
*/

private["_result"];
_result = [];

private["_homes"];
_homes = _this select 0;

// Zunächst versuchen eine Position ZUFÄLLIG zu bestimmen.
private["_countHomes"];
_countHomes = count _homes;

if (_countHomes > 0) then
{
	private["_found"];
	_found = false;
	private["_limiter"];
	_limiter = 10;
	while { ((!_found) and (_limiter > 0)) } do
	{
		private["_homeIndex"];
		_homeIndex = floor(random _countHomes);
		
		private["_home"];
		_home = _homes select _homeIndex;
		
		private["_rooms"];
		_rooms = _home select 1;
		
		private["_roomIndex"];
		_roomIndex = floor(random (count _rooms));
		
		private["_room"];
		_room = _rooms select _roomIndex;
		
		if (count _room == 1) then // if _room is not occupied, then
		{
			_found = true;
			_result = _room;
		}
		else
		{
			_limiter = _limiter - 1;
		};
	};

	// Wenn noch nichts gefunden haben, dann suchen wir nun LINIEAR.
	private["_homeIndex"];
	_homeIndex = 0;	
	while { ((!_found) and (_homeIndex < _countHomes)) } do
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
			
			if (count _room == 1) then // if _room is not occupied, then
			{
				_found = true;
				_result = _room;
			}
			else
			{
				_roomIndex = _roomIndex + 1;
			};
		};
		
		_homeIndex = _homeIndex + 1;
	};
};

_result; // _room