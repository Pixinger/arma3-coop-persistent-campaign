// Return: [_mapSize, [_mapCenterX,_mapCenterY,_mapCenterZ]]

private _mapSize = getNumber(configFile >> "CfgWorlds" >> worldName >> "MapSize");

// By Config: MapSize
if(_mapSize > 0) exitWith {[_mapSize, [(_mapSize/2), (_mapSize/2), 0]]};

// By Marker
if ((getMarkerPos "center" select 0) > (getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition") select 0)) exitWith { [(getMarkerPos "center" select 0) * 2, getMarkerPos "center"] };

// By Config: MapSize
private _mapCenter = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");
_mapCenter set [2,0];

[(_mapCenter select 0) * 2, _mapCenter]