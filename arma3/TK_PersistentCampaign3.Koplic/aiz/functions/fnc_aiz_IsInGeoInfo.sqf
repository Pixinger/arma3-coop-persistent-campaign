/* 
	DESCRIPTION:
		Prüft, ob sich eine Position innerhalb einer GeoInfo-Zone befindet.

	THIS:
		_geoInfo = _this select 0;
		_parameter = _this select 1;
		_position = _this select 2;
		
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

		==============
		==_position==
		==============
		[0,0] oder [0,0,0]

	RETURN:
		true oder false
	
*/
#include "..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

//------------------------------------------------------------------
private _geoInfo = _this select 0;
private _parameter = _this select 1;
private _position = _this select 2;
//-------------------------------------------------------------------
private _allowLand = _parameter select 0;
private _allowWater = _parameter select 1;
//-------------------------------------------------------------------
private _result = true;

//------------------------------------------------------------------
//------------------------------------------------------------------
// Rectangle
//------------------------------------------------------------------
//------------------------------------------------------------------
if (count _geoInfo == 5) exitWith
{
	// _geoInfo auslesen
	private _centerX = _geoInfo select 0;
	private _centerY = _geoInfo select 1;
	private _width = _geoInfo select 2;
	private _height = _geoInfo select 3;
	private _safetyBorder = _geoInfo select 4;		

	// SafetyBorder abziehen
	_width = _width - _safetyBorder;
	_height = _height - _safetyBorder;

	if (_width < 0) then { _width = 0; };	
	if (_height < 0) then { _height = 0; };

	if (!_allowLand && (!surfaceIsWater _position)) exitWith { _result = false; };
	if (!_allowWater && (surfaceIsWater _position)) exitWith { _result = false; };

	if (_position select 0 < _centerX - _width) exitWith { _result = false; };
	if (_position select 0 > _centerX + _width) exitWith { _result = false; };
	if (_position select 1 < _centerY - _height) exitWith { _result = false; };
	if (_position select 1 > _centerY + _height) exitWith { _result = false; };
	
diag_log format["DEBUG: fnc_aiz_IsInGeoInfo _result Rect = %1", _result];
	_result;
};

//------------------------------------------------------------------
//------------------------------------------------------------------
// Circle
//------------------------------------------------------------------
//------------------------------------------------------------------
if (count _geoInfo == 4) exitWith
{
	// _geoInfo auslesen
	private _centerX = _geoInfo select 0;
	private _centerY = _geoInfo select 1;
	private _radius = _geoInfo select 2;
	private _safetyBorder = _geoInfo select 3;	

	// SafetyBorder abziehen
	_radius = _radius - _safetyBorder;
	if (_radius < 0) then { _radius = 0; };
	
	if (!_allowLand && (!surfaceIsWater _position)) exitWith { _result = false; };
	if (!_allowWater && (surfaceIsWater _position)) exitWith { _result = false; };

	_result =((_position distance2D [_centerX, _centerY]) <= _radius);
diag_log format["DEBUG: fnc_aiz_IsInGeoInfo _result Circ = %1", _result];
	_result;
};

//------------------------------------------------------------------
//------------------------------------------------------------------
// Marker
//------------------------------------------------------------------
//------------------------------------------------------------------
if (count _geoInfo == 2) exitWith
{
	// _geoInfo auslesen
	private _markerName = _geoInfo select 0;
	private _safetyBorder = _geoInfo select 1;	

	private _markerPos = markerPos _markerName;
	private _markerDir = markerdir _markerName;
	private _sizeX = ((markersize _markerName) select 0) - _safetyBorder;
	private _sizeY = ((markersize _markerName) select 1) - _safetyBorder;

	if (_sizeX < 0) then { _sizeX = 0; };
	if (_sizeY < 0) then { _sizeY = 0; };
	
	if (!_allowLand && (!surfaceIsWater _position)) exitWith { _result = false; };
	if (!_allowWater && (surfaceIsWater _position)) exitWith { _result = false; };

	if ((markershape _markerName) == "rectangle") then 
	{
		// RECTANGLE
		private _reldir = _markerDir - (_markerPos getDir _position);
		private _adis = abs (_sizeX / cos (90 - _reldir));
		private _bdis = abs (_sizeY / cos _reldir);
		_result = ((_position distance2D _markerPos) - _adis min _bdis) <= 0;
	} 
	else 
	{
		// ELLIPSE
		if (_sizeX < _sizeY) then
		{
			_markerDir = _markerDir + 90;
			private _tmp = _sizeX; _sizeX = _sizeY; _sizeY = _tmp;
		};
		_markerDir = _markerDir + 90;
		private	_e = sqrt(_sizeX ^ 2 - _sizeY ^ 2);
		private _posF1 = _markerPos vectorAdd [sin _markerDir * _e, cos _markerDir * _e, 0];
		private _posF2 = _markerPos vectorAdd [-sin _markerDir * _e, -cos _markerDir * _e, 0];
		_result = (((_position distance2D _posF1) + (_position distance2D _posF2)) - 2 * _sizeX) * 0.5;
	};
	
	_result;
};

diag_log "ERROR: fnc_aiz_IsInGeoInfo: Invalid Parameter count";
false