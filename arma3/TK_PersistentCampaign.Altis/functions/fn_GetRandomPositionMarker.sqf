/* 
Based on: Karel Moricky
Berechnet eine zufällige Position innerhalb eines Markers. 

Parameter:
	markerName: Der Markername als String. Innerhalb dieses Markers wird die Zufällige Position liegen.

Return: 
	The random position. [0,0] if no position was found or markername was invalid.

/*-------------------------------------------------------------------*/

private["_markerName"];
_markerName = [_this, 0, objNull, [objNull, ""]] call BIS_fnc_param;

private["_safetyBorder"];
_safetyBorder = [_this, 0, 0, [0]] call BIS_fnc_param;
if (_safetyBorder < 0) then { _safetyBorder = 0; };

/*-------------------------------------------------------------------*/

private["_result"];
_result = [0,0];
if (!isNull _markerName) then
{
	private["_sizeX"];
	_sizeX = ((markersize _markerName) select 0) - _safetyBorder;
	private["_sizeY"];
	_sizeY = ((markersize _markerName) select 1) - _safetyBorder;

	if ((_sizeX > 0) && (_sizeY > 0)) then
	{
		private["_loopLimit"];
		_loopLimit = 200;
		while { _loopLimit > 0 } do
		{
			_loopLimit = _loopLimit - 1;
			_vector = if ((markershape _markerName) == "rectangle") then 
			{
				/* Rectangle */
				[
					(-_sizeX + 2 * random _sizeX),
					(-_sizeY + 2 * random _sizeY)
				];
			} 
			else 
			{
				/* Ellipse */
				private ["_rnd"];
				_rnd = random 360;
				[
					(cos _rnd * (random _sizeX)),
					(sin _rnd * (random _sizeY))
				];
			};

			/* Rotieren */
			_vector = [_vector, -(markerdir _markerName)] call bis_fnc_rotateVector2D;

			/* Result erstellen */
			private["_position"];
			_position = [
				((markerpos _markerName) select 0) + (_vector select 0),
				((markerpos _markerName) select 1) + (_vector select 1),
				0
			];
			if (_allowLand && (!surfaceIsWater _position)) then { _result = _position; _loopLimit = 0;};
			if (_allowWater && (surfaceIsWater _position)) then { _result = _position; _loopLimit = 0;};
		};	
	};
};

_result;