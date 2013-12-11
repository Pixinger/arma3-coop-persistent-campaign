/* 
	Berechnet den zu den übergebenen Koordinaten gehörenden Index einer Zone.

Parameter:
	position: Die Position die geprüft werden soll.

Return: 
	Den ZonenIndex (0 basiert). Wenn keine Zone gefunden wurde, wird -1 zurückgegeben.

/*-------------------------------------------------------------------*/

private["_position"];
_position = [_this, 0, [0,0], [[]], [2,3]] call BIS_fnc_param;

/*-------------------------------------------------------------------*/

private["_posX"];
_posX = _position select 0;
private["_posY"];
_posY = _position select 1;

private["_result"];
_result = -1;
private["_index"];
_index = 0;
{
	/* kombinierte if's sind in arma nicht performant, deshalb alle einzeln schachteln*/
	if (_posX >= (_x select 0)) then
	{
		if (_posY >= (_x select 1)) then 
		{
			if (_posX <= (_x select 2)) then
			{
				if (_posY <= (_x select 3)) exitWith { _result = _index; };
			};
		};
	};
	_index = _index + 1;
} foreach pixZones_ZoneCoordinates;

_result;