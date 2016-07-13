/* 
	DESCRIPTION:
		Gibt di Anzahl "wirklicher" Häuser in einem bestimmten Umkreis zurück.

	SAMPLE:
		[_position,_radius] call fnc_aiz_GetHouseCount;

	THIS:
		_position = _this select 0;
		_radius = _this select 1; 

	RETURN:
		Anzahl der Häuser

*/

//-------------------------------------------------------------------
params["_position", "_radius"];

private _houses = nearestObjects [_position, ["House", "Building"], _radius];

private _result = 0;

{
	if (_x call fnc_aiz_IsHouseReal) then { _result = _result + 1; };
} foreach _houses;

_result;