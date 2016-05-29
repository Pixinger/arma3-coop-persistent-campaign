/* 
	DESCRIPTION:
		Prüft ob es sich um ein vernünftiges Haus handelt, oder nicht.

	SAMPLE:
		_house call fnc_aiz_GetHouseCount;

	THIS:
		_house = _this;

	RETURN:
		true oder false

*/

if (_this call PIX_fnc_GetMaxBuildingPositions > 3) exitWith { true; };

false;