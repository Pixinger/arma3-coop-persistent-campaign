private["_markerName"];
_markerName = _this select 0;
private["_blackList"];
_blackList = _this select 1;
if (isNil "_blackList") then { _blackList = []; };
private["_blackListDistance"];
_blackListDistance = _this select 2;
if (isNil "_blackListDistance") then { _blackListDistance = 100; };

private["_result"];
_result = [[0,0,0],0];

private["_loopLimit"];
_loopLimit = 100;
while { _loopLimit > 0 } do
{ 
	_loopLimit = _loopLimit - 1;
	private["_position"];	
	_position = [_markerName, true, false, 125] call fn_pixZones_RandomPositionMarker;
	
	private["_houses"];
	_houses = _position nearObjects ["House", 100];
	if (count _houses > 0) then
	{
		private["_house"];
		_house = _houses select (floor(random(count _houses)));		
		_position = getPos _house;
	
		if (!surfaceIsWater _position) then
		{
			if ([_position, _blackList] call fn_pixZones_GetMinDistance > _blackListDistance) then
			{
				private["_maxIndex"];
				_maxIndex = 0;
				while { str(_house buildingPos _maxIndex) != "[0,0,0]" } do { _maxIndex = _maxIndex + 1;};
				
				_result = [_position, floor random (_maxIndex)];
				_loopLimit = 0;			
			};	
		};
	};
};

_result;
