/* 
	Berechnet eine zufällige Position innerhalb einer Zone.
	Die Position muss auf dem "freien Feld" liegen.
	
Parameter:
	zoneIndex: Der Index der Zone die den gültigen Bereich definiert.
	(optional) safetyBorder: Sicherheitsabstand zum Rand. (Default 25)
	(optional) objectPosition: Wenn angegeben, dann wird nicht nur die Zone, sondern auch diese Position und der folgende Radius verwendet um die Ergenis-Position zu bestimmen. 
	(optional) objectRadius: Der Radius (siehe objectPosition).
	

Return: 
	The random location. [[0,0,0], 0] ([position, buildingPos-Index]) 
	If no position was found or markername is invalid: [[0,0,0],0]

/*-------------------------------------------------------------------*/

private["_zoneIndex"];
_zoneIndex = [_this, 0, 0, [0]] call BIS_fnc_param;
if (_zoneIndex < 0) then { _zoneIndex = 0; };
if (_zoneIndex >= pixZones_ZoneCount) then { ["ZoneIndex is too large (%1)", _zoneIndex] call BIS_fnc_error; _zoneIndex = 0; };

private["_safetyBorder"];
_safetyBorder = [_this, 1, 25, [0]] call BIS_fnc_param;
if (_safetyBorder < 0) then { _safetyBorder = 0; };

private["_objectPosition"];
_objectPosition = [_this, 2, [0,0,0], [[]], [2,3]] call BIS_fnc_param;

private["_objectRadius"];
_objectRadius = [_this, 3, 0, [0]] call BIS_fnc_param;

/*-------------------------------------------------------------------*/

private["_result"];
_result = [[0,0,0],0];

private["_loopLimit"];
_loopLimit = 100;
while { _loopLimit > 0 } do
{ 
	_loopLimit = _loopLimit - 1;

	private["_position"];	
	if ((str(_objectPosition) == "[0,0,0]") || (_objectRadius == 0)) then
	{
		_position = [_zoneIndex, _safetyBorder] call PC_fnc_GetRandomPositionZone;
	}
	else
	{
		_position = [_zoneIndex, _safetyBorder, _objectPosition, _objectRadius] call PC_fnc_GetRandomPositionZoneObject;
	};
	
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
