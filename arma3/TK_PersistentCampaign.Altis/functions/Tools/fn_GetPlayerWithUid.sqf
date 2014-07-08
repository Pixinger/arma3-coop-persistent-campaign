/* 
	Gibt die Anzahl der aktuell verbundenen Spieler zurück. Auf einem Client-Server ist die Anzahl festgelegt. 
 
Parameter:
	_this select 0: UID

Return: 
	Den Spieler zur UID

/*-------------------------------------------------------------------*/

private["_result"];
_result = objNull;
{
	if (getPlayerUID _x == _this select 0) exitWith { _result = _x; _result; };
	{
		
	};
} foreach playableUnits;

_result;