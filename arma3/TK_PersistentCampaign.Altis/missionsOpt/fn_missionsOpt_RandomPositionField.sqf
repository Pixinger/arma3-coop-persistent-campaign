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
_result = [[0,0,0],0,[0,0],0];

private["_loopLimit"];
_loopLimit = 100;
while { _loopLimit > 0 } do
{ 
	_loopLimit = _loopLimit - 1;
	private["_position"];	
	_position = [_markerName, true, false, 50] call fn_missionsOpt_RandomPositionMarker;
	
	if (count (_position nearObjects ["House",25]) == 0) then
	{
		if (count (_position nearRoads 25) == 0) then
		{
			if ([_position, _blackList] call fn_missionsOpt_GetMinDistance > _blackListDistance) then
			{	
				if (_obfuscatedMarkerRadius > 0) then
				{
					private["_obfuscatedMarker"];
					_obfuscatedMarker = [_position, _obfuscatedMarkerRadius] call fn_missionsOpt_GetObfuscatedMarker;
					_result = [_position, random 360, _obfuscatedMarker select 0, _obfuscatedMarker select 1];
				}
				else
				{
					_result = [_position, random 360, [0,0], 0];
				};				
				_loopLimit = 0;
			};		
		};
	};
};

_result;
