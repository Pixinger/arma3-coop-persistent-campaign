//----------------------------------------------------------------------------------------------------------------
// _homes: 
//----------------------------------------------------------------------------------------------------------------
// _homes = [  [building-obj, [_room, _room, ...], searched],     [building-obj, [_room, _room, ...], searched],    ...   ]
// _room (frei)       = [[x,y,z]]
// _room (deaktviert) = [[x,y,z], classname]
// _room (aktviert)   = [[x,y,z], classname, unit-obj]
//----------------------------------------------------------------------------------------------------------------

// -----------------------------------
// Parameter auslesen
// -----------------------------------
private["_townCenter"];
_townCenter = _this select 0;
_townCenter = [_townCenter select 0, _townCenter select 2, _townCenter select 1]; // Konvertierung der MarkerPosition in eine normale Position.
private["_townName"];
_townName = _this select 1;
private["_townRadius"];
_townRadius = _this select 2;

// -----------------------------------
// Wohnungen erstellen (Home-Array)
// -----------------------------------
private["_homes"];
_homes = [_townCenter, _townRadius] call PC_fnc_TownHome_Create;

// ----------------------------------------------------------------------
// Stadtparameter auslesen (aus der Datenbank)
// ----------------------------------------------------------------------
private["_townStockWater"];	// Der Lagerbestand an Wasser
_townStockWater = 0;//DB
private["_townStockFood"];     // Der Lagerbestand an Nahrungsmitteln
_townStockFood = 0;//DB
private["_townStockPower"];    // Der Lagerbestand an Strom
_townStockPower = 0;//DB
private["_townMood"];
_townMood = 0;//DB			// Die Stimmung in der Stadt: -1 Red < 0 < Blu +1.
private["_townCivCount"];
_townCivCount = 10;//DB		// Die Anzahl der Zivilisten in der Stadt (virtuell).
private["_townRedCount"];
_townRedCount = 10;//DB		// Die Anzahl der Feinde in der Stadt (virtuell).
private["_townWeaponCount"];
_townWeaponCount = 0;//DB		// Die Anzahl der Waffen in der Stadt (virtuell).
private["_townWarlordCount"];
_townWarlordCount = 0;//DB		// Die Anzahl der Warlords in der Stadt (virtuell).
private["_townInjuredCount"];
_townInjuredCount = 0;//DB		// Die Anzahl der verletzten in der Stadt (virtuell). Das können CIV und RED sein!

// -----------------------------------
// In die Wohnungen einziehen
// -----------------------------------
private["_result"];
_result = [_homes, _townRedCount, _townCivCount] call PC_fnc_TownHome_SettleAllResidents;
private["_townMaxPopulation"];
_townMaxPopulation = _result select 2; // Die maximal mögliche Bevölkerung (abhängig von den Wohneinheiten).
player globalchat format["_result: %1(Red, Civ, Max)", _result];
_result = nil;

// -----------------------------------
// Parameter prüfen
// -----------------------------------
if (_townCivCount > _townMaxPopulation) then { _townCivCount = _townMaxPopulation; };
if (_townCivCount + _townRedCount > _townMaxPopulation) then { _townRedCount = _townMaxPopulation - _townCivCount; };
if (_townCivCount + _townRedCount + _townWarlordCount > _townMaxPopulation) then { _townWarlordCount = _townMaxPopulation - (_townCivCount + _townRedCount); };
if (_townInjuredCount < 0) then { _townInjuredCount = 0; };
if (_townWeaponCount < 0) then { _townWeaponCount = 0; };
if (_townMood > 1) then { _townMood = 1; };
if (_townMood < -1) then { _townMood = -1; };
if (_townStockFood < 0) then { _townStockFood = 0; };
if (_townStockWater < 0) then { _townStockWater = 0; };
if (_townStockPower < 0) then { _townStockPower = 0; };

// -----------------------------------
// Parameter errechnen
// -----------------------------------
private["_townPopulation"];
_townPopulation = _townCivCount + _townRedCount + _townWarlordCount;

// -----------------------------------
// Dauerschleife beginnen
// -----------------------------------
private["_civSOLL"];
_civSOLL = 0;
private["_civActives"];
_civActives = [];
private["_civActivesCount"];
_civActivesCount = 0;
private["_redSOLL"];
_redSOLL = 0;
private["_redActives"];
_redActives = [];
private["_redActivesCount"];
_redActivesCount = 0;

// Parameter zur Datenübertragung.
private["_townBluKills"];
_townBluKills = 0;

private["_lastServerTime"];
_lastServerTime = serverTime;

Sleep (1);
while { true } do 
{
	private["_deltaHours"];
	_deltaHours = 0.1;
	//_deltaHours = (serverTime - _lastServerTime) / 3600.0;      

	private["_newRedCount"];
	_simulatedRedCount = _townRedCount;
	private["_newCivCount"];
	_simulatedCivCount = _townCivCount;
	
	// -----------------------------------
	// RED simulieren
	// -----------------------------------
	// Konvertierung berechnen
	if (_townMood < 0) then
	{
		private["_conversion"];
		_conversion = (pixTown_ConfigMaxRed2CivConversionPPH * _CivCount * _deltaHours) * (_Mood * -1);
		_simulatedRedCount = _simulatedRedCount + _conversion;
		_simulatedCivCount = _simulatedCivCount - _conversion;
		if (_simulatedCivCount < 0) then { _simulatedCivCount = 0; };
	};

	// Blu-Force kills fördern das Wachstum
	_simulatedRedCount = _simulatedRedCount + (pixTown_ConfigRedGrowPerBluKill * _townBluKills);

	// Ein Warlord fördert das Wachstum
	private["_factor"];
	if (_townWarlordCount > 0) then { _factor = (pixTown_ConfigRedGrowFactorPerWarlord * _townWarlordCount); } else { _factor = 1; };

	// Wachstum berechnen und hinzufügen
	_simulatedRedCount = _simulatedRedCount + ((pixTown_ConfigRedGrowRatePPH * _simulatedRedCount * _deltaHours) * _factor);
	if (_townPopulation > _townMaxPopulation) then { _simulatedRedCount = _townMaxPopulation - _simulatedCivCount - _townWarlordCount; };
		
	// -----------------------------------
	// CIV simulieren
	// -----------------------------------
	// Konvertierung berechnen
	if (_townMood > 0) then
	{
		private["_conversion"];
		_conversion = (pixTown_ConfigMaxCiv2RedConversionPPH * _simulatedRedCount * _deltaHours) * _townMood;
		_simulatedCivCount = _simulatedCivCount + _conversion;
		_simulatedRedCount = _simulatedRedCount - _conversion;
		if (_simulatedRedCount < 0) then { _simulatedRedCount = 0; };
	};

	// _Stock Veränderungen berechnen
	_townStockWater = _townStockWater - ((pixTown_ConfigWaterConsumptionPPH * _townPopulation) * _deltaHours);
	if (_townStockWater < 0) then { _townStockWater = 0; };
	_townStockFood = _townStockFood - ((pixTown_ConfigFoodConsumptionPPH * _townPopulation) * _deltaHours);
	if (_townStockFood < 0) then { _townStockFood = 0; };
	if (_townStockPower < 0) then { _townStockPower = 0; };

	// Berechnen wie sich das Lager auf das Wachstum auswirkt.
	private["_factor"];
	_factor = pixTown_ConfigCivGrowFactorMinimum;
	if (_townStockWater > 0) then { _factor = _factor + pixTown_ConfigCivGrowFactorWater; };
	if (_townStockFood > 0) then { _factor = _factor + pixTown_ConfigCivGrowFactorFood; };
	if (_townStockPower > 0) then { _factor = _factor + pixTown_ConfigCivGrowFactorPower; };

	// Wachstum berechnen und hinzufügen
	_simulatedCivCount = _simulatedCivCount + (pixTown_ConfigCivGrowRatePPH * _simulatedCivCount * _deltaHours * _factor);
	if (_townPopulation > _townMaxPopulation) then { _simulatedCivCount = _townMaxPopulation - _townRedCount - _townWarlordCount; };

	// ----------------------------------------------------------------------
	// _simulatedRedCount in Homes/_townRedCount übertragen (RED)
	// ----------------------------------------------------------------------
	private["_count"];		
	_count = floor(_simulatedRedCount) - floor(_townRedCount);
	private["_result"];
	_result = [_homes, pixTown_ConfigRedClassnames, _count] call PC_fnc_TownHome_SettleRooms;
	if (_count != _result) then
	{
		_townRedCount = floor(_townRedCount) + _result;
	}
	else
	{
		_townRedCount = _simulatedRedCount;
	};

	// ----------------------------------------------------------------------
	// _simulatedCivCount in Homes/_townCivCount übertragen (CIV)
	// ----------------------------------------------------------------------
	private["_count"];		
	_count = floor(_simulatedCivCount) - floor(_townCivCount);
	private["_result"];
	_result = [_homes, pixTown_ConfigCivClassnames, _count] call PC_fnc_TownHome_SettleRooms;
	if (_count != _result) then
	{
		_townCivCount = floor(_townCivCount) + _result;
	}
	else
	{
		_townCivCount = _simulatedCivCount;
	};
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	// Ab jetzt kommt der Teil, den man sehen kann, wenn man in der Stadt ist.
	// -----------------------------------------------------------------------------------
	// Festlegen wieviele Einheiten in dieser Stadt aktiv sein sollen RED/CIV
	// -----------------------------------------------------------------------------------
	if ([_townCenter, _townRadius] call PC_fnc_IsAnyPlayerNear) then
	{
		// Einmalig eine Anzahl berechnen
		if (_civSOLL == 0) then
		{
			_civSOLL = 20;
			_redSOLL = 20;
		};		
		
		// RED Einheiten AKTIVIEREN / DEAKTIVEREN
		if (_redSOLL > _redActivesCount) then
		{
			private["_count"];
			_count = _redSOLL - _redActivesCount;
			if (_count > 5) then { _count = 5; };
			
			[_homes, pixTown_ConfigRedClassnames, _redActives, _count, east, "town\fsm\red.fsm"] call PC_fnc_TownHome_Units_Activate;
		};			
		// "Fertige" RED Einheiten DEAKTIVIEREN
		[_redActives] call PC_fnc_TownHome_Units_DeactivateFinished;
		_redActivesCount = count _redActives; // Zähler aktualisieren
		

		// CIV Einheiten AKTIVIEREN / DEAKTIVEREN
		if (_civSOLL > _civActivesCount) then
		{
			private["_count"];
			_count = _civSOLL - _civActivesCount;
			if (_count > 5) then { _count = 5; };
			
			[_homes, pixTown_ConfigCivClassnames, _civActives, _count, independent, "town\fsm\civ.fsm"] call PC_fnc_TownHome_Units_Activate;		
		};			
		// "Fertige" CIV Einheiten DEAKTIVIEREN
		[_civActives] call PC_fnc_TownHome_Units_DeactivateFinished;
		_civActivesCount = count _civActives;		
	}
	else
	{
		player globalchat "not near";

		// Alle Einheiten DEAKTIVIEREN
		if (_redActivesCount > 0) then
		{
			player globalchat "deaktivate RED";

			_redSOLL = 0;
			[_redActives] call PC_fnc_TownHome_Units_DeactivateAll;
			_redActivesCount = 0;
		};
		if (_civActivesCount > 0) then
		{
			player globalchat "deaktivate CIV";
			_civSOLL = 0;
			[_civActives] call PC_fnc_TownHome_Units_DeactivateAll;
			_civActivesCount = 0;
		};
	};
	
	Sleep(10);
};


/*

{
	_position = [getpos (_x select 0) select 0, getpos (_x select 0) select 1, (getpos (_x select 0) select 2) + 10];
	_veh = "Sign_Arrow_Large_F" createVehicle _position;
	_veh setpos (_position);	
} foreach _homes;

*/

//[_homes] call PC_fnc_TownHome_DebugHomes;
