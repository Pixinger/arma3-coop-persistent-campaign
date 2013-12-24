/* 
	Berechnet eine zufällige Position innerhalb einer Zone.

Parameter:
	zoneIndex: Der Index der Zone die den gültigen Bereich definiert.
	safetyBorder: Sicherheitsabstand zum Rand.

Return: 
	The random position. [0,0,0] if no position was found or markername was invalid.

/*-------------------------------------------------------------------*/

private["_zoneIndex"];
_zoneIndex = [_this, 0, 0, [0]] call BIS_fnc_param;
if (_zoneIndex < 0) then { _zoneIndex = 0; };
if (_zoneIndex >= pixZones_ZoneCount) then { ["ZoneIndex is too large (%1)", _zoneIndex] call BIS_fnc_error; _zoneIndex = 0; };

private["_safetyBorder"];
_safetyBorder = [_this, 1, 0, [0]] call BIS_fnc_param;
if (_safetyBorder < 0) then { _safetyBorder = 0; };

/*-------------------------------------------------------------------*/

private["_result"];
_result = [0,0,0];

private["_size"];
_size = getMarkerSize (pixZones_MarkerNames select _zoneIndex);
private["_sizeX"];
_sizeX = (_size select 0) - _safetyBorder;
private["_sizeY"];
_sizeY = (_size select 1) - _safetyBorder;
if ((_sizeX > 0) && (_sizeY > 0)) then
{
	private["_pos"];
	_pos = getMarkerPos (pixZones_MarkerNames select _zoneIndex);
	_result = [(_pos select 0) + (-_sizeX + (2 * random _sizeX)), (_pos select 1) + (-_sizeY + (2 * random _sizeY)), 0];
};

_result;