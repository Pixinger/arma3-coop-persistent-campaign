/* 
	Berechnet eine zufällige Position innerhalb einer Zone.
	Die Position muss auf dem "freien Feld" liegen.
	
Parameter:
	_objectPosition: Die Position
	_objectRadius: Der Radius	

Return: 
	The random location. [[0,0,0], 0] ([position, road direction]) 
	If no position was found or markername is invalid: [[0,0,0],0]

/*-------------------------------------------------------------------*/

private["_objectPosition"];
_objectPosition = [_this, 0, [0,0,0], [[]], [2,3]] call BIS_fnc_param;

private["_objectRadius"];
_objectRadius = [_this, 1, 0, [0]] call BIS_fnc_param;

/*-------------------------------------------------------------------*/

private["_result"];
_result = [[0,0,0],0];

private["_loopLimit"];
_loopLimit = 100;
while { _loopLimit > 0 } do
{ 
	_loopLimit = _loopLimit - 1;

	private["_position"];	
	_position = [_objectPosition, _objectRadius] call fnc_aiz_GetRandomPositionCircle;
	
	private["_roads"];
	_roads = _position nearRoads 50;
	if (count _roads > 0) then
	{
		private["_road"];
		_road = _roads select (floor(random(count _roads)));		
		private["_road2"];
		_road2 = roadsConnectedTo _road;
		
		if (count _road2 > 0) exitWith
		{
			_road2 = _road2 select 0;
			
			private["_pos1"];
			_pos1 = getPos _road;
			private["_pos2"];
			_pos2 = getPos _road2;
	
			private["_x1"];
			_x1 = _pos1 select 0;
			private["_y1"];
			_y1 = _pos1 select 1;
			private["_x2"];
			_x2 = _pos2 select 0;
			private["_y2"];
			_y2 = _pos2 select 1;
			private["_direction"];
			_direction = (_x2 - _x1) atan2 (_y2 - _y1);
	
			_result = [_pos1, _direction];
			_loopLimit = 0;
		};
	};
};

_result;
