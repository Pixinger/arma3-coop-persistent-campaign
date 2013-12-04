private["_markerName"];
_markerName = _this select 0;
private["_blackList"];
_blackList = _this select 1;
if (isNil "_blackList") then { _blackList = []; };
private["_blackListDistance"];
_blackListDistance = _this select 2;
if (isNil "_blackListDistance") then { _blackListDistance = 100; };
private["_obfuscatedMarkerRadius"];
_obfuscatedMarkerRadius = _this select 3;
if (isNil "_obfuscatedMarkerRadius") then { _obfuscatedMarkerRadius = 0; };


private["_result"];
_result = [[0,0,0],0];

private["_loopLimit"];
_loopLimit = 100;
while { _loopLimit > 0 } do
{ 
	_loopLimit = _loopLimit - 1;
	private["_position"];	
	_position = [_markerName, true, false, 50] call fn_missionsOpt_RandomPositionMarker;
	
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
	
			if ([_pos1, _blackList] call fn_missionsOpt_GetMinDistance > _blackListDistance) then
			{	
				if (_obfuscatedMarkerRadius > 0) then
				{
					private["_obfuscatedMarker"];
					_obfuscatedMarker = [_pos1, _obfuscatedMarkerRadius] call fn_missionsOpt_GetObfuscatedMarker;
					_result = [_pos1, _direction, _obfuscatedMarker select 0, _obfuscatedMarker select 1];
				}
				else
				{
					_result = [_pos1, _direction, [0,0], 0];
				};				
				_loopLimit = 0;
			};
		};
	};
};

_result;
