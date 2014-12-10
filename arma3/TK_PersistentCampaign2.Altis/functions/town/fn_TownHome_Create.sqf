/*
Diese Funktion analysiert die Häuser einer Stadt und erstellt ein Array mit bewohnbaren Positionen 
 
Parameter:
	_townCenter: Der Mittelpunkt der zu analysieren ist. 
	_townRadius: Der Durchmesser der zu analysieren ist.

Return: 
	_homes
	----------------------------------------------------------------------------------------------------------------
	_maxResidents: Anzahl der insgesamt bewohnbaren Positionen.
	_homes: Das Array mit den bewohnbaren Positionen.
	----------------------------------------------------------------------------------------------------------------
	_homes = [  [building-obj, [_room, _room, ...]],     [building-obj, [_room, _room, ...]],    ...   ]
	_room (frei)       = [[x,y,z]]
	_room (deaktviert) = [[x,y,z], classname]
	_room (aktviert)   = [[x,y,z], classname, unit-obj]
*/

private["_townCenter"];
_townCenter = _this select 0;
private["_townRadius"];
_townRadius = _this select 1;

private["_homes"];
_homes = [];
private["_buildingsAvailable"]; 
_buildingsAvailable = nearestObjects [_townCenter, pixTown_ConfigHomeClassnames, _townRadius];
{
	private["_rooms"];
	_rooms = [];	
	private["_maxIndex"];
	_maxIndex = 0;
	private["_buildingPos"];
	_buildingPos = _x buildingPos _maxIndex;
	while { str(_buildingPos) != "[0,0,0]" } do 
	{
		_rooms set [count _rooms, [_buildingPos]];		
		_maxIndex = _maxIndex + 1;
		_buildingPos = _x buildingPos _maxIndex;
	};
	
	_homes set [count _homes, [_x, _rooms]];
} foreach _buildingsAvailable;

_homes;