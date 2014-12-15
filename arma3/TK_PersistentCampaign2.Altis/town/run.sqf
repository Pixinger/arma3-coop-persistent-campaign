//----------------------------------------------------------------------------------------------------------------
// _homes: 
//----------------------------------------------------------------------------------------------------------------
// _homes = [  [building-obj, [_room, _room, ...], searched],     [building-obj, [_room, _room, ...], searched],    ...   ]
// _room (frei)       = [[x,y,z]]
// _room (deaktviert) = [[x,y,z], classname]
// _room (aktviert)   = [[x,y,z], classname, unit-obj]
//----------------------------------------------------------------------------------------------------------------

if (isServer) then
{
	// -----------------------------------
	// Parameter auslesen
	// -----------------------------------
	private["_townCenter"];
	_townCenter = _this select 0;
	private["_townRadius"];
	_townRadius = _this select 1;
	private["_townName"];
	_townName = _this select 2;

	// -----------------------------------
	// Marker erstellen
	// -----------------------------------
	private["_townMarker"];
	_townMarker = createMarker[format["markerTown%1", _townName], _townCenter];
	_townMarker setMarkerShape "ELLIPSE";
	_townMarker setMarkerSize [_townRadius, _townRadius];
	_townMarker setMarkerColor "ColorBlack";
	_townMarker setMarkerAlpha 0.7;

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
	_townCivCount = 100;//DB		// Die Anzahl der Zivilisten in der Stadt (virtuell).
	private["_townRedCount"];
	_townRedCount = 10;//DB		// Die Anzahl der Feinde in der Stadt (virtuell).
	private["_townWeaponCount"];
	_townWeaponCount = 0;//DB		// Die Anzahl der Waffen in der Stadt (virtuell).
	private["_townWarlordCount"];
	_townWarlordCount = 0;//DB		// Die Anzahl der Warlords in der Stadt (virtuell).
	private["_townInjuredCount"];
	_townInjuredCount = 10;//DB		// Die Anzahl der verletzten in der Stadt (virtuell). Das können CIV und RED sein!

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
	// Globale Variablen anlegen
	// -----------------------------------
	private["_townExternData1"];
	_townExternData1 = [0,0,0,0]; //Mood, Healed, Water, Food
	//missionNamespace setVariable [format["pixTown%1_ExternalData", _townName], [0,0,0,0]]; // Water, Food, Power, BluKills, Healed, Weapons, Warlord, Rad+, Civ+, Mood, CivCount, RedCount, WarlordCount, MaxPop

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

	[_townName] call PC_fnc_Townparam_InjuredPull;
	[_townName] call PC_fnc_Townparam_WaterPull;
	[_townName] call PC_fnc_Townparam_FoodPull;
	[_townName] call PC_fnc_Townparam_MoodPull;
	
	// Parameter zur Datenübertragung.
	private["_townBluKills"];
	_townBluKills = 0;

	private["_lastServerTime"];
	_lastServerTime = serverTime;

	private["_heavyLoadTick"];
	_heavyLoadTick = 0;

	Sleep (1);
	while { true } do 
	{
		private["_deltaHours"];
		_deltaHours = (serverTime - _lastServerTime) / 3600.0;      
		_lastServerTime = serverTime;
		if (pixDebug) then { _deltaHours = 0.1; };
		
diag_log "-------------------------------------------------------------------------------";
diag_log format["_deltaHours=%1 time=%2 serverTime=%3", _deltaHours, time, serverTime];

		// -----------------------------------
		// Power simulieren
		// -----------------------------------
		//if (serverTime > _heavyLoadTick) then
		if (true) then
		{
			private["_powers"];
			_powers = nearestObjects [_townCenter, ["Land_PowerGenerator_F"], _townRadius];		
			_townStockPower = 0;
			{
				private["_index"];
				_index = pixTown_ConfigPowerClassnames find (typeOf _x);
				if (_index >= 0) then
				{
					_townStockPower = _townStockPower + pixTown_ConfigPowerValues select _index;
					diag_log format["INFO: %1 found generator: %2", _townName, _index];
				};
			} foreach _powers;
		};
diag_log format["_townStockPower=%1", _townStockPower];
		
		// -----------------------------------
		// Mood simulieren
		// -----------------------------------
		if (_townMood > 0) then
		{
			_townMood = _townMood - (pixTown_ConfigMoodSlabLevelPH * _deltaHours);
			if (_townMood < 0) then { _townMood = 0; };
		};
		_townMood = _townMood + ([_townName] call PC_fnc_Townparam_MoodPull);
		if (_townMood > 1) then { _townMood = 1; };
		if (_townMood < -1) then { _townMood = -1; };
diag_log format["_townMood=%1", _townMood];
		
		// -----------------------------------
		// RED Abzug bei Unterzahl
		// -----------------------------------
		if ((_townRedCount > 0) && (_townRedCount < 11)) then
		{		
		};
		
		// -----------------------------------
		// RED simulieren (_simulatedRedCount)
		// -----------------------------------
diag_log format["_townCivCount=%1  _townRedCount=%2", _townCivCount, _townRedCount];
		private["_simulatedRedCount"];
		_simulatedRedCount = _townRedCount;
		private["_simulatedCivCount"];
		_simulatedCivCount = _townCivCount;

		// Konvertierung berechnen
		if (_townMood < 0) then
		{
			private["_conversion"];
			_conversion = (pixTown_ConfigMaxRed2CivConversionPPH * _simulatedCivCount * _deltaHours) * (_townMood * -1);
diag_log format["RED _conversion=%1", _conversion];
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
		// CIV simulieren (_simulatedCivCount)
		// -----------------------------------
		// Konvertierung berechnen
		if (_townMood > 0) then
		{
			private["_conversion"];
			_conversion = (pixTown_ConfigMaxCiv2RedConversionPPH * _simulatedRedCount * _deltaHours) * _townMood;
diag_log format["CIV _conversion=%1", _conversion];
			_simulatedCivCount = _simulatedCivCount + _conversion;
			_simulatedRedCount = _simulatedRedCount - _conversion;
			if (_simulatedRedCount < 0) then { _simulatedRedCount = 0; };
		};

		// _Stock Veränderungen berechnen
		_townStockWater = _townStockWater - ((pixTown_ConfigWaterConsumptionPPH * _townPopulation) * _deltaHours);
		if (_townStockWater < 0) then { _townStockWater = 0; };
		_townStockWater = _townStockWater + ([_townName] call PC_fnc_Townparam_WaterPull);
diag_log format["_townStockWater=%1", _townStockWater];

		_townStockFood = _townStockFood - ((pixTown_ConfigFoodConsumptionPPH * _townPopulation) * _deltaHours);
		if (_townStockFood < 0) then { _townStockFood = 0; };
		_townStockFood = _townStockFood + ([_townName] call PC_fnc_Townparam_FoodPull);
diag_log format["_townStockFood=%1", _townStockFood];

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
		_count = _simulatedRedCount - _townRedCount;
		if (_count < 0) then { _count = ceil(_count); }	else { _count = floor(_count);	};
		private["_result"];
		_result = [_homes, pixTown_ConfigRedClassnames, _count] call PC_fnc_TownHome_SettleRooms;
		if (_count != _result) then
		{
			_townRedCount = floor(_townRedCount) + _result; //TODO: noch prüfen ob die RED auch korrekt verringert werden!
		}
		else
		{
			_townRedCount = _simulatedRedCount;
		};
diag_log format["_townRedCount=%1", _townCivCount];

		// ----------------------------------------------------------------------
		// _simulatedCivCount in Homes/_townCivCount übertragen (CIV)
		// ----------------------------------------------------------------------
		private["_count"];		
		_count = _simulatedCivCount - _townCivCount;
		if (_count < 0) then { _count = ceil(_count); }	else { _count = floor(_count);	};
		private["_result"];
diag_log format["_simulatedCivCount=%1 =>%2", _simulatedCivCount, _count];
		_result = [_homes, pixTown_ConfigCivClassnames, _count] call PC_fnc_TownHome_SettleRooms;
		if (_count != _result) then
		{
			_townCivCount = floor(_townCivCount) + _result; //TODO: noch prüfen ob die CIV auch korrekt verringert werden!
		}
		else
		{
			_townCivCount = _simulatedCivCount;
		};
diag_log format["_townCivCount=%1", _townCivCount];
		
		// -----------------------------------
		// Injured simulieren
		// -----------------------------------
		_townInjuredCount = _townInjuredCount + (pixTown_ConfigInjuredGrowFactorPPH * (_townRedCount + _townCivCount) * _deltaHours);
		_townInjuredCount = _townInjuredCount + ([_townName] call PC_fnc_TownParam_InjuredPull);		
		if (_townInjuredCount < 0) then { _townInjuredCount = 0; };
diag_log format["_townInjuredCount=%1", _townInjuredCount];
diag_log format["L _simulatedCivCount=%1  _simulatedRedCount=%2", _simulatedCivCount, _simulatedRedCount];
diag_log format["L _townCivCount=%1  _townRedCount=%2", _townCivCount, _townRedCount];
		

		
		
		
		
		
		
		
		
		
		
		
		
		
		// Ab jetzt kommt der Teil, den man sehen kann, wenn man in der Stadt ist.
		// -----------------------------------------------------------------------------------
		// Festlegen wieviele Einheiten in dieser Stadt aktiv sein sollen RED/CIV
		// -----------------------------------------------------------------------------------
		//TODO: Radiuus abhängig von der Anzahl der Feineinheiten machen
		if ([_townCenter, 1000] call PC_fnc_IsAnyPlayerNear) then
		{
player sidechat "online";
		
			// Einmalig eine Anzahl berechnen
			if (_civSOLL == 0) then
			{
				//TODO: Abhänging: Uhrzeit, Stadtgröße, Einwohner, Anzahl Feinde.
				//TODO: Noch implementieren!
				_civSOLL = 40;
				_redSOLL = 0;
			};		
			
			// RED Einheiten AKTIVIEREN / DEAKTIVEREN
			if (_redSOLL > _redActivesCount) then
			{
				private["_count"];
				_count = _redSOLL - _redActivesCount;
				if (_count > 5) then { _count = 5; };
				
				private["_i"];
				for "_i" from 1 to _count do
				{
					private["_room"]; //room: [position, classname, unit-obj]
					_room = [_homes, pixTown_ConfigRedClassnames] call PC_fnc_TownHome_GetInactiveRoom;
					if (count _room == 0) exitWith { diag_log "no spawn room found";};  // Wenn Spieler in der Nähe sind, kann es sein dass diese vorhandene Räume blockieren.

					private["_classname"];
					_classname = _room select 1;
					private["_unitPosition"];
					_unitPosition = _room select 0;
					if (count _unitPosition > 0) then
					{
						private ["_unitGroup"];
						_unitGroup = createGroup east;
						
						private["_unit"];
						_unit = _unitGroup createUnit [_classname, _unitPosition, [], 0, "FORM"];
						waitUntil {!isNil "_unit"};
						_unit setDir (floor(random 360));
						_unit setpos _unitPosition;
						if (_townInjuredCount > 1) then 
						{
							if (random 1 < 0.2) then
							{
diag_log "injured red";
								_townInjuredCount = _townInjuredCount - 1;
								_unit setDamage 0.5;	
					
								//TODO: noch prüfen
								removeAllWeapons _unit;								
							};
						};
						//_unit setBehaviour "CARELESS";
						//_unit setSpeedmode "FULL";
						_unit setVariable ["townName", _townName];
						_unit setVariable ["townCenter", _townCenter];
						_unit setVariable ["townRadius", _townRadius];
						_unit setVariable ["townHome", _unitPosition];
						_unit doFSM ["town\fsm\red.fsm", _unitPosition, _unit];							
						_room set [2, _unit];
						_redActivesCount set [(count _redActivesCount), [_unit, _unitGroup, _room]];		
diag_log format["created red: %1", _unit];
					};
				};				
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

				private["_i"];
				for "_i" from 1 to _count do
				{
					private["_room"]; //room: [position, classname, unit-obj]
					_room = [_homes, pixTown_ConfigCivClassnames] call PC_fnc_TownHome_GetInactiveRoom;
					if (count _room == 0) exitWith { diag_log "no spawn room found";};  // Wenn Spieler in der Nähe sind, kann es sein dass diese vorhandene Räume blockieren.

					private["_classname"];
					_classname = _room select 1;
					private["_unitPosition"];
					_unitPosition = _room select 0;
					if (count _unitPosition > 0) then
					{
						private ["_unitGroup"];
						_unitGroup = createGroup independent;
						
						private["_unit"];
						_unit = _unitGroup createUnit [_classname, _unitPosition, [], 0, "FORM"];
						waitUntil {!isNil "_unit"};
						_unit setDir (floor(random 360));
						_unit setpos _unitPosition;
						if (_townInjuredCount > 1) then 
						{
							if (random 1 < 0.5) then
							{
diag_log "injured civ";
								_townInjuredCount = _townInjuredCount - 1;
								_unit setDamage 0.5;									
							};
						};
						//_unit setBehaviour "CARELESS";
						//_unit setSpeedmode "FULL";
						_unit setVariable ["townName", _townName];
						_unit setVariable ["townCenter", _townCenter];
						_unit setVariable ["townRadius", _townRadius];
						_unit setVariable ["townHome", _unitPosition];
						_unit doFSM ["town\fsm\civ2.fsm", _unitPosition, _unit];							
						_room set [2, _unit];
						_civActives set [(count _civActives), [_unit, _unitGroup, _room]];		
diag_log format["created civ: %1", _unit];
					};
				};
			};			
			
			// "Fertige" CIV Einheiten DEAKTIVIEREN
			[_civActives] call PC_fnc_TownHome_Units_DeactivateFinished;
			_civActivesCount = count _civActives;		
diag_log format["_civActivesCount=%1", _civActivesCount];

		}
		else
		{
diag_log "town virtual. no player close engough.";

			// Alle Einheiten DEAKTIVIEREN
			if (_redActivesCount > 0) then
			{
diag_log "deactivate RED";

				_redSOLL = 0;
				[_redActives] call PC_fnc_TownHome_Units_DeactivateAll;
				_redActivesCount = 0;
			};
			if (_civActivesCount > 0) then
			{
diag_log "deactivate CIV";
				_civSOLL = 0;
				[_civActives] call PC_fnc_TownHome_Units_DeactivateAll;
				_civActivesCount = 0;
			};
		};
		
		Sleep(pixTown_ConfigMainLoopSleep);
	};


	/*

	{
		_position = [getpos (_x select 0) select 0, getpos (_x select 0) select 1, (getpos (_x select 0) select 2) + 10];
		_veh = "Sign_Arrow_Large_F" createVehicle _position;
		_veh setpos (_position);	
	} foreach _homes;

	*/

	//[_homes] call PC_fnc_TownHome_DebugHomes;
};