/* 
	DESCRIPTION:
		Berechnet eine zufällige Position.
		Abhängig von der Anzahl der Parameter wird zwischen Rectagnle, Circle oder Marker unterschieden.
		Die Position muss auf einer Strasse liegen.

	THIS:
		_geoInfo = _this select 0;
		_parameter = !! keine !!
		
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
		!! keine !!

	RETURN:
		[] bei Fehler
		sonst die Position in 0m ATL [[x,y,0], direction].
	
*/
#include "..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

#define LOOP_LIMIT	100

//-------------------------------------------------------------------
private["_geoInfo"];
_geoInfo = _this select 0;
//-------------------------------------------------------------------

private["_result"];
_result = [];

private["_loopLimit"];
_loopLimit = LOOP_LIMIT;
while { _loopLimit > 0 } do
{ 
	_loopLimit = _loopLimit - 1;

	private["_position"];	
	_position = [_geoInfo, [true, false, 100]] call fnc_aiz_GetRandomPosition;	
	if (count _position > 0) then
	{	
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
};

_result;
