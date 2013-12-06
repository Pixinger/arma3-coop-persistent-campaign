/* 
	Prüft, ob eine bestimmte Position innerhalb einer bestimmten Zone liegt.

Parameter:
	zoneIndex: Der Index der Zone die den gültigen Bereich definiert.
	position: Die Position die geprüft werden soll.
	(optional)safetyBorder: Sicherheitsabstand zum Rand.

Return: 
	true, wenn die Position innerhalb des ZonenIndex liegt. 
	false, wenn die Position außerhalb des ZonenIndex liegt. 

/*-------------------------------------------------------------------*/

private["_zoneIndex"];
_zoneIndex = [_this, 0, 0, [0]] call BIS_fnc_param;
private["_position"];
_position = [_this, 1, objNull, [objNull, []], [2,3]] call BIS_fnc_param;
private["_safetyBorder"];
_safetyBorder = [_this, 2, 0, [0]] call BIS_fnc_param;
if (_safetyBorder < 0) then { _safetyBorder = 0; };

/*-------------------------------------------------------------------*/

private["_result"];
_result = false;
if (_zoneIndex < pixZones_ZoneCount) then
{
	private["_zoneCoordinates"];
	_zoneCoordinates = pixZones_ZoneCoordinates select _zoneIndex;
	
	private["_posX","_posY"];
	_posX = _position select 0;
	_posY = _position select 1;

	/* Kombinierte if's sind in arma nicht performant, deshalb alle einzeln schachteln */
	if (_posX >= (_zoneCoordinates select 0) + _safetyBorder) then
	{
		if (_posY >= (_zoneCoordinates select 1) + _safetyBorder) then 
		{
			if (_posX <= (_zoneCoordinates select 2) - _safetyBorder) then
			{
				if (_posY <= (_zoneCoordinates select 3) - _safetyBorder) then 
				{ 
					_result = true; 
				};
			};
		};
	};
};

_result;