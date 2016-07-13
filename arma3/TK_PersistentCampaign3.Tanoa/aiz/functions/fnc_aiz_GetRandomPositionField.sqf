/* 
	DESCRIPTION:
		Berechnet eine zufällige Position.
		Abhängig von der Anzahl der Parameter wird zwischen Rectagnle, Circle oder Marker unterschieden.
		Die Position muss auf dem "freien Feld" liegen.

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
		_maxElevation = _parameter select 0;

	RETURN:
		[0,0,0] bei Fehler
		sonst die Position in 0m ATL [x,y,0].
	
*/

#define LOOP_LIMIT	100

//-------------------------------------------------------------------
private["_geoInfo"];
_geoInfo = _this select 0;
private["_parameter"];
_parameter = _this select 1;
//-------------------------------------------------------------------
private["_maxElevation"];
_maxElevation = _parameter select 0;
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
		if (count (_position nearObjects ["House", 20]) == 0) then
		{
			if (count (_position nearRoads 20) == 0) then
			{
				if (_maxElevation <= 100) then
				{
					if ([_position, 10, _maxElevation] call PIX_fnc_IsFlat) then
					{
						_result = _position;
						_loopLimit = 0; // Exit 
					};
				}
				else
				{
					_result = _position;
					_loopLimit = 0; // Exit 
				};
			};
		};
	};
};

_result;
