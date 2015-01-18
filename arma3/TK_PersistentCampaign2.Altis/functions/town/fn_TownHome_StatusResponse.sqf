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
	_townMaxPopulation = _this select 7;

Return: 
	nix
*/

if ((getPlayerUID player) in admin_ConfigPlayerUIDs) then
{
	hint format["Stadt(%1), Civ(%2), Red(%3), Verletzte(%4), Stimmung(%5), Nahrung(%6), Wasser(%7), MaxPop(%8)", _this select 0, _this select 1, _this select 2, _this select 3, _this select 4, _this select 5, _this select 6, _this select 7];
}
else
{
	private["_rnd"];
	_rnd = random 1;
	
	// CivCount
	if (_rnd <= (1 / 4) * 1) exitWith 
	{
		hintC format["Wir haben hier in der Stadt in etwas %1 Bewohner. Davon sind %2 Wiederständler. Die Stadt hat noch %3 freie Wohnungen.", (_this select 1) + (_this select 2), (_this select 2), (_this select 7) - ((_this select 1) + (_this select 2))];
	};

	// Stimmung
	if (_rnd <= (1 / 4) * 2) exitWith 
	{
		hintC format["Aktuelle Stimmung: %1", (_this select 4)];
	};

	// Lagerbestand
	if (_rnd <= (1 / 4) * 3) exitWith 
	{
		hintC format["Unser Wasserlager ist zu %1 % gefüllt. Unser Nahrungsmittellager ist zu 2% % gefüllt", round((_this select 6)*100), round((_this select 5)*100)];
	};

	// Verletzte
	hintC format["Wir haben momentan %1 Verletzte hier in der Stadt.", (_this select 3)];
};

true;