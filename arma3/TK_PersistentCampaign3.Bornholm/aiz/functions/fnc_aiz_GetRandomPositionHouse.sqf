/* 
	DESCRIPTION:
		Berechnet eine zufällige Position.
		Abhängig von der Anzahl der Parameter wird zwischen Rectagnle, Circle oder Marker unterschieden.

	SAMPLE:
		[["markerAiz5",0], [true]] call fnc_aiz_GetRandomPositionHouse;
		[["markerAiz5",0], [true, [5, 300]]] call fnc_aiz_GetRandomPositionHouse;

	THIS:
		_geoInfo = _this select 0;
		_parameter = _this select 1; 
		
		============
		==_geoInfo==
		============
		[Marker]
		_markerName = _geoInfo select 0;
		_safetyBorder = _geoInfo select 1;	

		[Circle]
		_centerX = _geoInfo select 0;
		_centerY = _geoInfo select 1;
		_radius = _geoInfo select 2;
		_safetyBorder = _geoInfo select 3;	

		[Rectangle]
		_centerX = _geoInfo select 0;
		_centerY = _geoInfo select 1;
		_width = _geoInfo select 2;
		_height = _geoInfo select 3;
		_safetyBorder = _geoInfo select 4;	
		
		==============
		==_parameter==
		==============
		_randomPositionInHouse = _parameter select 0;
		_housesNearby = _parameter select 1; [optional]; _housesNearby=[minNumberNearby,nearbyDistance]

	RETURN:
		[] bei Fehler
		sonst 
		[_house, _housPosition]
	
*/

#define LOOP_LIMIT	100

//-------------------------------------------------------------------
private _geoInfo = _this select 0;
private _parameter = _this select 1;
//-------------------------------------------------------------------
private _randomPositionInHouse = _parameter select 0;
private _housesNearby = if (count _parameter >= 2) then { _parameter select 1 } else { nil };
//-------------------------------------------------------------------
private _result = [];

private _loopLimit = LOOP_LIMIT;
while { _loopLimit > 0 } do
{ 
	_loopLimit = _loopLimit - 1;

	private _position = [_geoInfo, [true, false, 100]] call fnc_aiz_GetRandomPosition;	
	if (count _position > 0) then
	{	
		private _house = nearestObject [_position, "house"];
		if (!isNull _house) then
		{		
			if ([_geoInfo, [true, false], getPos _house] call fnc_aiz_IsInGeoInfo) then
			{
				
				//diag_log format["nearby %1", (nearestObjects [getPos _house, ["house"], (_housesNearby select 1)])];
				if ( (isNil "_housesNearby") || {(count ((getPos _house) nearObjects ["House", (_housesNearby select 1)]) >= _housesNearby select 0)} ) then
				{
					private _maxIndex = 0;
					while { str(_house buildingPos _maxIndex) != "[0,0,0]" } do { _maxIndex = _maxIndex + 1;};
					if ((_maxIndex < 8) && (_maxIndex > 3)) then
					{
						if (_randomPositionInHouse) then { _maxIndex = floor(random(_maxIndex)); };
						_result = [_house, _maxIndex];
						_loopLimit = 0;
					};
				};
			};
		};
	};
};

_result