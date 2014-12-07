/*
Diese Funktion schreibt das Homes Array in die RPT und gibt im Chat eine Übersicht aus.
 
Parameter:
	_homes: Das Home-Array
	
Return: 
*/

private["_homes"];
_homes = _this select 0;

diag_log "---HOMES---INACTIVE---BEGIN---";
diag_log format["%1 @%2", _townCenter, _townRadius];

private["_homeCount"];
_homeCount = count _homes;
private["_homeIndex"];
_homeIndex = 0;	
while { (_homeIndex < _homeCount) } do
{
	private["_home"];
	_home = _homes select _homeIndex;
	private["_roomCount"];
	_roomCount = count (_home select 1);

	private["_roomIndex"];
	_roomIndex = 0;
	while { (_roomIndex < _roomCount) } do
	{
		private["_room"];
		_room = (_home select 1) select _roomIndex;
		if (count _room == 2) then
		{
			diag_log format[" home %1 / room %2 / %3", _homeIndex, _roomIndex, _room];
		};
		_roomIndex = _roomIndex + 1;
	};
	
	_homeIndex = _homeIndex + 1;
};

diag_log "---HOMES---ACTIVE---END---";