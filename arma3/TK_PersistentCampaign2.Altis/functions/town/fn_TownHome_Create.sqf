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
		private["_pos1"];
		_pos1 = ATLtoASL _buildingPos;
		_pos1 set [2, (_pos1 select 2) + 0.5];
		private["_pos2"];
		_pos2 = ATLtoASL _buildingPos;
		_pos2 set [2, (_pos2 select 2) + 4];
		
		//TODO: Welches ist der schnellste Weg?
		//if (count lineintersectsobjs [_pos1, _pos2, objnull, objnull, false, 4] > 0) then
		//if (lineIntersects [_pos1, _pos2]) then
		if (count lineIntersectsWith [_pos1, _pos2] > 0) then
		{		
			//private["_sign"];
			//_sign = "Sign_Arrow_Large_F" createVehicle _buildingPos;
			//_sign setPos _buildingPos;		
			_rooms pushBack [_buildingPos];
		};
		_maxIndex = _maxIndex + 1;
		_buildingPos = _x buildingPos _maxIndex;		
	};
	
	_homes pushBack [_x, _rooms];
} foreach _buildingsAvailable;

_homes;