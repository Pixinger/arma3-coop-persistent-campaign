/* 
	DESCRIPTION:
		Sucht eine zufällige Hausposition innerhalb eines Markers.

	SAMPLE:
		["markerTown5"] call fnc_aiz_GetRandomPositionHouse;

	THIS:
		_markerName = _this select 0;
		
	RETURN:
		[] bei Fehler
		sonst 
		[_house, _housPosition]
	
*/

#define LOOP_LIMIT	100

//-------------------------------------------------------------------
private _markerName = _this select 0;
private _loopLimit = LOOP_LIMIT;
private _result = [];
while { _loopLimit > 0 } do
{ 
	_loopLimit = _loopLimit - 1;

	private _randomPosition = [_markerName] call PIX_fnc_RandomPosMarkerTrigger;
	private _house = nearestBuilding _randomPosition;
	if (!isNull _house) then
	{		
		if ([_markerName, _house] call BIS_fnc_inTrigger) exitWith
		{				
			_result = [_house, floor(random(_house call PIX_fnc_GetMaxBuildingPositions))];
			_loopLimit = 0;
		};
	};
};

_result;