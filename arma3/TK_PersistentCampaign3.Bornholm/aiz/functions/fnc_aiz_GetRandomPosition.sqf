/* 
	DESCRIPTION:
		Berechnet eine zufällige Position.
		Abhängig von der Anzahl der Parameter wird zwischen Rectagnle, Circle oder Marker unterschieden.

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
		_allowLand = _parameter select 0;
		_allowWater = _parameter select 1;
		_loopLimit = _parameter select 2;

	RETURN:
		[] bei Fehler
		sonst die Position in 0m ATL [x,y,0].
	
*/

//------------------------------------------------------------------
private _geoInfo = _this select 0;
private _parameter = _this select 1;
//-------------------------------------------------------------------
private _allowLand = _parameter select 0;
private _allowWater = _parameter select 1;
private _loopLimit = _parameter select 2;

private _result = [];

//------------------------------------------------------------------
//------------------------------------------------------------------
// Rectangle
//------------------------------------------------------------------
//------------------------------------------------------------------
if (count _geoInfo == 5) exitWith
{
diag_log "rect";
	private _centerX = _geoInfo select 0;
	private _centerY = _geoInfo select 1;
	private _width = _geoInfo select 2;
	private _height = _geoInfo select 3;
	private _safetyBorder = _geoInfo select 4;		

	// SafetyBorder abziehen
	_width = _width - _safetyBorder;
	if (_width < 0) then { _width = 0; };	
	_height = _height - _safetyBorder;
	if (_height < 0) then { _height = 0; };

	while { _loopLimit > 0 } do
	{
		// Position berechnen
		private _position = [_centerX + (-_width + random(2 *_width)), _centerY + (-_height + random(2 *_height)), 0];

		if (_allowLand && (!surfaceIsWater _position)) then { _result = _position; _loopLimit = 0; };
		if (_allowWater && (surfaceIsWater _position)) then { _result = _position; _loopLimit = 0; };
	};
	
diag_log format["rect _result = %1", _result];
	_result;
};

//------------------------------------------------------------------
//------------------------------------------------------------------
// Circle
//------------------------------------------------------------------
//------------------------------------------------------------------
if (count _geoInfo == 4) exitWith
{
diag_log "cric";
	private _centerX = _geoInfo select 0;
	private _centerY = _geoInfo select 1;
	private _radius = _geoInfo select 2;
	private _safetyBorder = _geoInfo select 3;	

	// SafetyBorder abziehen
	_radius = _radius - _safetyBorder;
	if (_radius < 0) then { _radius = 0; };
	
	while { _loopLimit > 0 } do
	{
		_loopLimit = _loopLimit - 1;	
		
		// Position berechnen
		private _rnd = random 360;	
		private _position = [_centerX + (cos _rnd * (random _radius)),_centerY +(sin _rnd * (random _radius)), 0];
	
		if (_allowLand && (!surfaceIsWater _position)) then { _result = _position; _loopLimit = 0; };
		if (_allowWater && (surfaceIsWater _position)) then { _result = _position; _loopLimit = 0; };
	};
	
diag_log format["circle _result = %1", _result];
	_result;
};

//------------------------------------------------------------------
//------------------------------------------------------------------
// Marker
//------------------------------------------------------------------
//------------------------------------------------------------------
if (count _geoInfo == 2) exitWith
{
	private _markerName = _geoInfo select 0;
	private _safetyBorder = _geoInfo select 1;	

	private _sizeX = ((markersize _markerName) select 0) - _safetyBorder;
	if (_sizeX < 0) then { _sizeX = 0; };
	private _sizeY = ((markersize _markerName) select 1) - _safetyBorder;
	if (_sizeY < 0) then { _sizeY = 0; };

	while { _loopLimit > 0 } do
	{
		_loopLimit = _loopLimit - 1;
		private _vector = if ((markershape _markerName) == "rectangle") then 
		{
			// Rectangle 
			[
				(-_sizeX + random (2 *_sizeX)),
				(-_sizeY + random (2 *_sizeY))
			];
		} 
		else 
		{
			// Ellipse 
			private _rnd = random 360;
			[
				(cos _rnd * (random _sizeX)),
				(sin _rnd * (random _sizeY))
			];
		};

		// Rotieren 
		_vector = [_vector, -(markerdir _markerName)] call bis_fnc_rotateVector2D;

		// Result erstellen 
		private _position = [
			((markerpos _markerName) select 0) + (_vector select 0),
			((markerpos _markerName) select 1) + (_vector select 1),
			0
		];
		
		if (_allowLand && (!surfaceIsWater _position)) then { _result = _position; _loopLimit = 0; };
		if (_allowWater && (surfaceIsWater _position)) then { _result = _position; _loopLimit = 0; };
	};	
	
	_result;
};

diag_log "ERROR: fnc_aiz_GetRandomPosition: Invalid Parameter count";
[0,0,0]