/*
Diese Funktion wird aufgerufen, wenn von einer Stadt ein aktueller Zustand übermittelt wird.
 
Parameter:
	_townName = _this select 0;
	_townCivCount = _this select 1;
	_townRedCount = _this select 2;
	_townInjuredCount = _this select 3;
	_townMood = _this select 4;
	_townStockFood = _this select 5;
	_townStockWater = _this select 6;
	_townStockPower = _this select 7;

Return: 
	nix
*/

hint format["Stadt(%1), Civ(%2), Red(%3), Verletzte(%4), Stimmung(%5), Nahrung(%6), Wasser(%7), Strom(%8)", _this select 0, _this select 1, _this select 2, _this select 3, _this select 4, _this select 5, _this select 6, _this select 7];

true;