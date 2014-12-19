/*
Diese Funktion wird regelmäßig aufgerufen, um den aktuellen Zustand einer Stadt 
für die Öffentlichkeit zwischen zu speichern.
 
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

missionNamespace setVariable [format["TownStatus%1", _townName], _this];

true;