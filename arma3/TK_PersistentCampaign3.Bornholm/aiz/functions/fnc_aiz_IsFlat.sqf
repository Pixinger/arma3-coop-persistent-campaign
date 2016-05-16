/* 
	Prüft ob es sich um einen Flachen Bereich handelt, oder nicht.
	
Parameter:
	position: Die Position [0,0,0] / [0,0]
	areaSize: Größe des Bereiches in Metern (rechtecktig)
	areaMaxHeight: Maximaler Höhenunterschied in Metern 

Return: 
	true / false

/*-------------------------------------------------------------------*/

private["_position"];
_position = _this select 0;

private["_areaSize"];
_areaSize = _this select 1;

private["_areaMaxHeight"];
_areaMaxHeight = _this select 2;

//-------------------------------------------------------------------

private["_heightRef"];
_heightRef = getTerrainHeightASL _position; 

private ["_pos0"];
_pos0 = (_position select 0);
private ["_pos1"];
_pos1 = (_position select 1);

private["_height"];
_height = getTerrainHeightASL [_pos0 + _areaSize, _pos1];
if ((_height - _areaMaxHeight > _heightRef) || (_height + _areaMaxHeight < _heightRef)) exitWith { false; };
_height = getTerrainHeightASL [_pos0 - _areaSize, _pos1];
if ((_height - _areaMaxHeight > _heightRef) || (_height + _areaMaxHeight < _heightRef)) exitWith { false; };
_height = getTerrainHeightASL [_pos0, _pos1 + _areaSize];
if ((_height - _areaMaxHeight > _heightRef) || (_height + _areaMaxHeight < _heightRef)) exitWith { false; };
_height = getTerrainHeightASL [_pos0, _pos1 - _areaSize];
if ((_height - _areaMaxHeight > _heightRef) || (_height + _areaMaxHeight < _heightRef)) exitWith { false; };

true;