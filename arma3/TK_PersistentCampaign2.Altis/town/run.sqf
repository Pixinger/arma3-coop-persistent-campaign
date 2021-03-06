//----------------------------------------------------------------------------------------------------------------
// _homes: 
//----------------------------------------------------------------------------------------------------------------
// _homes = [  [building-obj, [_room, _room, ...], searched],     [building-obj, [_room, _room, ...], searched],    ...   ]
// _room (frei)       = [[x,y,z]]
// _room (deaktviert) = [[x,y,z], classname]
// _room (aktviert)   = [[x,y,z], classname, unit-obj]
//----------------------------------------------------------------------------------------------------------------

if (ExecuteHeadlessCode) then
{
	// -----------------------------------
	// "_this" auslesen
	// -----------------------------------
	private["_townObject"];
	_townObject = _this select 0;

	// -----------------------------------
	// "_townObject" auslesen
	// -----------------------------------
	_townObject enableSimulationGlobal false;
	hideObjectGlobal _townObject;

	private["_townCenter"];
	_townCenter = getPos _townObject;
	private["_townRadius"];
	_townRadius = _townObject getVariable "townRadius";
	private["_townName"];
	_townName = _townObject getVariable "townName";

	// -----------------------------------
	// Wohnungen erstellen (Home-Array)
	// -----------------------------------
	private["_homes"];
	_homes = [_townCenter, _townRadius] call PC_fnc_TownHome_Create;

	// -----------------------------------
	// Marker erstellen
	// -----------------------------------
	private["_townMarker"];
	_townMarker = createMarker[format["markerTown%1", _townName], _townCenter];
	_townMarker setMarkerShape "ELLIPSE";
	_townMarker setMarkerSize [_townRadius, _townRadius];
	_townMarker setMarkerAlpha 0.7;

	// ----------------------------------------------------------------------
	// Stadtparameter auslesen (aus der Datenbank)
	// ----------------------------------------------------------------------
	private["_townStockWater"];
	private["_townStockFood"];     
	private["_townMood"];
	private["_townCivCount"];
	private["_townRedCount"];
	private["_townWeaponCount"];
	private["_townInjuredCount"];
	private["_townMaxPopulation"];
	private["_dbResult"];	
	_dbResult = "Arma2NET" callExtension format["PC town|load|%1", _townName];
	if ("Arma2NET" callExtension format["PC isok|%1", _dbResult] == "OK") then
	{
		_dbResult = call compile _dbResult;
		_townStockWater = _dbResult select 1;		// Der Lagerbestand an Wasser
		_townStockFood = _dbResult select 2;		// Der Lagerbestand an Nahrungsmitteln
		_townMood = _dbResult select 3;			// Die Stimmung in der Stadt: -1 Red < 0 < Blu +1.
		_townCivCount = _dbResult select 4;			// Die Anzahl der Zivilisten in der Stadt (virtuell).
		_townRedCount = _dbResult select 5;			// Die Anzahl der Feinde in der Stadt (virtuell).
		_townWeaponCount = _dbResult select 6;		// Die Anzahl der Waffen in der Stadt (virtuell).
		_townObject setVariable ["sideMission", _dbResult select 7];	// Die Id oder der Status der Sidemission der Stadt (virtuell).
		_townInjuredCount = _dbResult select 8;		// Die Anzahl der verletzten in der Stadt (virtuell). Das können CIV und RED sein!
		_townMaxPopulation = _dbResult select 9;	// maximale Anzahl an Wohnungen. Wird später im Code erneut berechnet, falls sich die Häuser geändert haben
		diag_log format["Town loaded from DB: %1", _dbResult];
	}
	else
	{
		_townStockWater = 0;
		_townStockFood = 0;
		_townMood = 0;
		_townCivCount = 100;
		_townRedCount = 100;
		_townWeaponCount = 0;
		_townObject setVariable ["sideMission", 0];
		_townInjuredCount = 0;
		_townMaxPopulation = 0;				// maximale Anzahl an Wohnungen. Wird später im Code erneut berechnet, falls sich die Häuser geändert haben
		diag_log format["ERROR: %1 konnte Daten aus Datenbank nicht laden: %2", _townName, _dbResult];
	};

	// -----------------------------------
	// Side-Missions
	// -----------------------------------
	if (_townObject getVariable "sideMission" != 0) then
	{
		private["_sideMission"];
		_sideMission = _townObject getVariable "sideMission";

		// Warlord
		if ((_sideMission >= 10) && (_sideMission <= 19)) then
		{
			if (_sideMission == 11) then // Fehlgeschlagen
			{
				_townMood = _townMood - 1;
				if (_townMood < -1) then { _townMood = -1; };
				private["_increase"];
				_increase = round(_townCivCount / 2);
				_townCivCount = _townCivCount - _increase;
				_townRedCount = _townRedCount + _increase;
				_townWeaponCount = _increase * 4;
				_townObject setVariable ["sideMission", 0];
			};
			if (_sideMission == 12) then // Erfolgreich
			{
				_townMood = _townMood + 1;
				if (_townMood > 1) then { _townMood = 1; };
				private["_increase"];
				_increase = round(_townCivCount / 2);
				_townCivCount = _townCivCount + _increase;
				_townRedCount = _townRedCount - _increase;
				_townObject setVariable ["sideMission", 0];
			};
			if (_sideMission == 10) then // Starten
			{
				private["_tmp"];
				_tmp = [_townObject] execVM "town\sideMissions\10Warlord\run.sqf";
				_townObject setVariable ["offline", false, true]; // Stadt in den Online Modus zwingen.		
			};
		};

		// Waffenlager
		if ((_sideMission >= 20) && (_sideMission <= 29)) then
		{
			if (_sideMission == 21) then // Fehlgeschlagen
			{
				_townMood = _townMood - 1;
				if (_townMood < -1) then { _townMood = -1; };
				private["_increase"];
				_increase = round(_townCivCount / 2);
				_townCivCount = _townCivCount - _increase;
				_townRedCount = _townRedCount + _increase;
				_townWeaponCount = _increase * 4;
				_townObject setVariable ["sideMission", 0];
			};
			if (_sideMission == 22) then // Erfolgreich
			{
				_townMood = _townMood + 1;
				if (_townMood > 1) then { _townMood = 1; };
				private["_increase"];
				_increase = round(_townCivCount / 2);
				_townCivCount = _townCivCount + _increase;
				_townRedCount = _townRedCount - _increase;
				_townObject setVariable ["sideMission", 0];
			};
			if (_sideMission == 20) then // Starten
			{
				private["_tmp"];
				_tmp = [_townObject] execVM "town\sideMissions\20Waffenlager\run.sqf";
				_townObject setVariable ["offline", false, true]; // Stadt in den Online Modus zwingen.		
			};
		};

		// Checkpoint
		if ((_sideMission >= 30) && (_sideMission <= 39)) then
		{
			if (_sideMission == 31) then // Fehlgeschlagen
			{
				_townMood = _townMood - 1;
				if (_townMood < -1) then { _townMood = -1; };
				private["_increase"];
				_increase = round(_townCivCount / 4);
				_townCivCount = _townCivCount - _increase;
				_townRedCount = _townRedCount + _increase;
				_townStockFood = 0;
				_townStockWater = 0;
				_townObject setVariable ["sideMission", 0];
			};
			if (_sideMission == 32) then // Erfolgreich
			{
				_townMood = _townMood + 1;
				if (_townMood > 1) then { _townMood = 1; };
				private["_increase"];
				_increase = round(_townCivCount / 6);
				_townCivCount = _townCivCount + _increase;
				_townRedCount = _townRedCount - _increase;
				_townObject setVariable ["sideMission", 0];
			};
			if (_sideMission == 30) then // Starten
			{
				private["_tmp"];
				_tmp = [_townObject] execVM "town\sideMissions\30Checkpoint\run.sqf";
				_townObject setVariable ["offline", false, true]; // Stadt in den Online Modus zwingen.		
			};
		};

		// AntiAir
		if ((_sideMission >= 40) && (_sideMission <= 49)) then
		{
			if (_sideMission == 41) then // Fehlgeschlagen
			{
				_townMood = _townMood - 1;
				if (_townMood < -1) then { _townMood = -1; };
				_townWeaponCount = _townWeaponCount + 100;
				_townObject setVariable ["sideMission", 0];
			};
			if (_sideMission == 42) then // Erfolgreich
			{
				_townMood = _townMood + 1;
				if (_townMood > 1) then { _townMood = 1; };
				private["_increase"];
				_increase = round(_townCivCount / 6);
				_townCivCount = _townCivCount + _increase;
				_townRedCount = _townRedCount - _increase;
				_townObject setVariable ["sideMission", 0];
			};
			if (_sideMission == 40) then // Starten
			{
				private["_tmp"];
				_tmp = [_townObject] execVM "town\sideMissions\40Antiair\run.sqf";
				_townObject setVariable ["offline", false, true]; // Stadt in den Online Modus zwingen.		
			};
		};
	};

	// -----------------------------------
	// Townmarker erstellen
	// -----------------------------------
	if (_townRedCount / 10 > _townCivCount) then 
	{
		_townMarker setMarkerColor "ColorRed";
	}
	else
	{
		if (_townCivCount / 10 > _townRedCount) then 
		{
			_townMarker setMarkerColor "ColorGreen";
		}
		else
		{
			_townMarker setMarkerColor "ColorBlack";
		};
	};

	// -----------------------------------
	// IEDs erstellen
	// -----------------------------------
	private["_result"];
	_result = [_townCenter, _townRadius] execVM "ied\createTownIEDs.sqf";

	if (_townObject getVariable ["offline", false]) then
	{
		// ----------------------------------------------------------------------
		// ----------------------------------------------------------------------
		// INAKTIVE STADT
		// ----------------------------------------------------------------------
		// ----------------------------------------------------------------------
		
		while { true } do
		{
			// ----------------------------------------------------------------------
			// Inaktive Städte speichern nur alle 60 Sekunden die Datenbank, ansonsten sind sie tot.
			// Dadruch wird die SideMission in die Datenbank übertragen, wenn eine für die Stadt erstellt wurde.
			// ----------------------------------------------------------------------
			Sleep(60);
			private["_dbResult"];	
			_dbResult = "Arma2NET" callExtension format["PC town|update|%1|%2|%3|%4|%5|%6|%7|%8|%9|%10", _townName, _townStockWater, _townStockFood, _townMood, _townCivCount, _townRedCount, _townWeaponCount, _townObject getVariable["sideMission", 0], _townInjuredCount, _townMaxPopulation];
			if ("Arma2NET" callExtension format["PC isok|%1", _dbResult] != "OK") then
			{
				diag_log format["ERROR: Town.Update failed: %1", _dbResult];
			};
		};
	}
	else
	{
		// ----------------------------------------------------------------------
		// ----------------------------------------------------------------------
		// AKTIVE STADT
		// ----------------------------------------------------------------------
		// ----------------------------------------------------------------------

		// -----------------------------------
		// In die Wohnungen einziehen
		// -----------------------------------
		_result = [_homes, _townRedCount, _townCivCount] call PC_fnc_TownHome_SettleAllResidents;
		_townMaxPopulation = _result select 2; // Die maximal mögliche Bevölkerung (abhängig von den Wohneinheiten).
		_result = nil;

		// -----------------------------------
		// Parameter prüfen
		// -----------------------------------
		if (_townCivCount > _townMaxPopulation) then { _townCivCount = _townMaxPopulation; };
		if (_townCivCount + _townRedCount > _townMaxPopulation) then { _townRedCount = _townMaxPopulation - _townCivCount; };
		if (_townInjuredCount < 0) then { _townInjuredCount = 0; };
		if (_townWeaponCount < 0) then { _townWeaponCount = 0; };
		if (_townMood > 1) then { _townMood = 1; };
		if (_townMood < -1) then { _townMood = -1; };
		if (_townStockFood < 0) then { _townStockFood = 0; };
		if (_townStockWater < 0) then { _townStockWater = 0; };
		pixTown_TotalRooms = pixTown_TotalRooms + _townMaxPopulation;
		pixTown_TotalPopulation = pixTown_TotalPopulation + _townCivCount + _townRedCount;
		[_townName, _townCivCount, _townRedCount, _townInjuredCount, _townMood, _townStockFood, _townStockWater, _townMaxPopulation] call PC_fnc_TownHome_StatusUpdate; // Einmal vorab initialisieren


		// -----------------------------------
		// Globale Parameter initialisieren
		// -----------------------------------
		[_townName] call PC_fnc_Townparam_InjuredPull;
		[_townName] call PC_fnc_Townparam_WaterPull;
		[_townName] call PC_fnc_Townparam_FoodPull;
		[_townName] call PC_fnc_Townparam_MoodPull;
		[_townName] call PC_fnc_Townparam_BluKillPull;
		[_townName] call PC_fnc_Townparam_SearchBuildingInit;

		// ----------------------------------------------------------------------
		// Runtime Parameter der While-Schleife initialisieren
		// ----------------------------------------------------------------------
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
		private["_townPopulation"];
		_townPopulation = 0;

		private["_townGroupCiv"];
		_townGroupCiv = createGroup pixTown_ConfigSideCiv;
		private["_townGroupRed"];
		_townGroupRed = createGroup pixTown_ConfigSideRed;

		private["_townSimulationCounter"];
		_townSimulationCounter = 0;
		private["_townOnlineOfflineCounter"];
		_townOnlineOfflineCounter = 0;
		private["_townIsVirtual"];
		_townIsVirtual = true;

		// Erst nach dem Briefing beginnen, alle Städte zu einer etwas anderen Zeit
		Sleep (0.1 + (random pixTown_ConfigMainLoopSleep));


		// -----------------------------------
		// Dauerschleife beginnen
		// -----------------------------------
		private["_lastServerTime"];
		_lastServerTime = time;
		while { true } do 
		{
			// Schlafen legen ... 
			Sleep(pixTown_ConfigMainLoopSleep);

			// -----------------------------------------------------------------------------------
			// -----------------------------------------------------------------------------------
			// Simulation: Berechnen der Bevölkerungsparameter (Anzahl, Lager, Stimmung, ...)
			// -----------------------------------------------------------------------------------
			_townSimulationCounter = _townSimulationCounter - 1;
			if (_townSimulationCounter < 0) then
			{
				_townSimulationCounter = 12;
				private["_deltaHours"];
				_deltaHours = (time - _lastServerTime) / 3600.0;      
				_lastServerTime = time;
				if (pixDebug) then { _deltaHours = 0.1; };

				if (call PC_fnc_GetPlayerCount >= pixTown_ConfigMinPlayerCountForSimulation) then
				{
					// ----------------------------------------------------------------------
					// Gesamtbevölkerung berechnen (wird immer wieder mal benötigt)
					// ----------------------------------------------------------------------
					_townPopulation = _townCivCount + _townRedCount;

						
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
					
					// -----------------------------------
					// RED simulieren (_simulatedRedCount)
					// -----------------------------------
					private["_simulatedRedCount"];
					_simulatedRedCount = _townRedCount;
					private["_simulatedCivCount"];
					_simulatedCivCount = _townCivCount;

					// Konvertierung berechnen
					if (_townMood < -0.1) then
					{
						private["_conversion"];
						_conversion = (pixTown_ConfigMaxRed2CivConversionPPH * _simulatedCivCount * _deltaHours) * (_townMood * -1);
						_simulatedRedCount = _simulatedRedCount + _conversion;
						_simulatedCivCount = _simulatedCivCount - _conversion;
						if (_simulatedCivCount < 0) then { _simulatedCivCount = 0; };
					};

					// Blu-Force kills fördern das Wachstum
					_simulatedRedCount = _simulatedRedCount + (pixTown_ConfigRedGrowPerBluKill * ([_townName] call PC_fnc_Townparam_BluKillPull));

					// Wachstum berechnen und hinzufügen (nur wenn die Stimmung schlecht ist, gibt es ein Grundwachstum.)
					if (_townMood < pixTown_ConfigRedGrowRateMoodLimit) then 
					{
						_simulatedRedCount = _simulatedRedCount + (pixTown_ConfigRedGrowRatePPH * _simulatedRedCount * _deltaHours);
					};

					// -----------------------------------
					// CIV simulieren (_simulatedCivCount)
					// -----------------------------------
					// Konvertierung berechnen
					if (_townMood > 0.1) then
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
					_townStockWater = _townStockWater + ([_townName] call PC_fnc_Townparam_WaterPull);

					_townStockFood = _townStockFood - ((pixTown_ConfigFoodConsumptionPPH * _townPopulation) * _deltaHours);
					if (_townStockFood < 0) then { _townStockFood = 0; };
					_townStockFood = _townStockFood + ([_townName] call PC_fnc_Townparam_FoodPull);

					// Berechnen wie sich das Lager auf das Wachstum auswirkt.
					private["_factor"];
					_factor = pixTown_ConfigCivGrowFactorMinimum;
					if (_townStockWater > 0) then { _factor = _factor + pixTown_ConfigCivGrowFactorWater; };
					if (_townStockFood > 0) then { _factor = _factor + pixTown_ConfigCivGrowFactorFood; };

					// Wachstum berechnen und hinzufügen
					_simulatedCivCount = _simulatedCivCount + (pixTown_ConfigCivGrowRatePPH * _simulatedCivCount * _deltaHours * _factor);

					// ----------------------------------------------------------------------
					// Wachstum auf Stadtgrenzen limitieren
					// ----------------------------------------------------------------------
					if (_simulatedCivCount > _townMaxPopulation) then { _simulatedCivCount = _townMaxPopulation; };
					if (_simulatedCivCount + _simulatedRedCount > _townMaxPopulation) then { _simulatedRedCount = _townMaxPopulation - _simulatedCivCount; };

					// ----------------------------------------------------------------------
					// _simulatedRedCount in Homes/_townRedCount übertragen (RED)
					// ----------------------------------------------------------------------
					private["_count"];		
					_count = floor(_simulatedRedCount) - floor(_townRedCount);
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

					// ----------------------------------------------------------------------
					// _simulatedCivCount in Homes/_townCivCount übertragen (CIV)
					// ----------------------------------------------------------------------
					private["_count"];		
					_count = floor(_simulatedCivCount) - floor(_townCivCount);
					private["_result"];
					_result = [_homes, pixTown_ConfigCivClassnames, _count] call PC_fnc_TownHome_SettleRooms;
					if (_count != _result) then
					{
						_townCivCount = floor(_townCivCount) + _result; //TODO: noch prüfen ob die CIV auch korrekt verringert werden!
					}
					else
					{
						_townCivCount = _simulatedCivCount;
					};
					
					// -----------------------------------
					// Injured simulieren
					// -----------------------------------
					_townInjuredCount = _townInjuredCount + (pixTown_ConfigInjuredGrowFactorPPH * (_townRedCount + _townCivCount) * _deltaHours);
					_townInjuredCount = _townInjuredCount + ([_townName] call PC_fnc_TownParam_InjuredPull);		
					if (_townInjuredCount < 0) then { _townInjuredCount = 0; };
					
					// ----------------------------------------------------------------------
					// Die Werte für die Öffentlichkeit zwischenspeichern
					// ----------------------------------------------------------------------
					[_townName, _townCivCount, _townRedCount, _townInjuredCount, _townMood, _townStockFood, _townStockWater, _townMaxPopulation] call PC_fnc_TownHome_StatusUpdate;
				
				
					// ----------------------------------------------------------------------
					// Die Werte in der Datenbank speichern
					// ----------------------------------------------------------------------
					private["_dbResult"];	
					_dbResult = "Arma2NET" callExtension format["PC town|update|%1|%2|%3|%4|%5|%6|%7|%8|%9|%10", _townName, _townStockWater, _townStockFood, _townMood, _townCivCount, _townRedCount, _townWeaponCount, _townObject getVariable["sideMission", 0], _townInjuredCount, _townMaxPopulation];
					if ("Arma2NET" callExtension format["PC isok|%1", _dbResult] != "OK") then
					{
						diag_log format["ERROR: Town.Update failed: %1", _dbResult];
					};
				};
			};
			
			// -----------------------------------------------------------------------------------
			// -----------------------------------------------------------------------------------
			// Online/Offline: Einheiten laufen auf der Karte herum
			// -----------------------------------------------------------------------------------
			_townOnlineOfflineCounter = _townOnlineOfflineCounter - 1;		
			if (_townOnlineOfflineCounter < 0) then
			{
				_townOnlineOfflineCounter = 6;		
				if ([_townCenter, 1000] call PC_fnc_IsAnyPlayerNearTown) then //TODO: Radius abhängig von der Anzahl der Feineinheiten machen
				{
					_townIsVirtual = false;
				
					// _civSOLL und _redSOLL berechnen
					private["_tmpCivCount"];
					_tmpCivCount = _townCivCount; 
					private["_tmpRedCount"];
					_tmpRedCount = _townRedCount; 
					private["_tmpTotalSOLL"];
					_tmpTotalSOLL = (_tmpCivCount + _tmpRedCount) / 20; 
					if (_tmpTotalSOLL > pixTown_ConfigTotalSOLLLimit) then { _tmpTotalSOLL = pixTown_ConfigTotalSOLLLimit; }; // Deckeln
					
					_tmpTotalSOLL = ceil(_tmpTotalSOLL);
					_civSOLL = ceil((_tmpTotalSOLL / (_tmpCivCount + _tmpRedCount)) * _tmpCivCount);
					_redSOLL = _tmpTotalSOLL - _civSOLL;

		//_civSOLL = 2;
		//_redSOLL = 1;
					
					// -----------------------------------
					// "Fertige" CIV/RED Einheiten DEAKTIVIEREN
					// -----------------------------------
					private["_deactivationResult"];
					_deactivationResult = [_redActives, _townName] call PC_fnc_TownHome_Units_DeactivateFinished;
					_townRedCount = _townRedCount - (_deactivationResult select 0);
					_townWeaponCount = _townWeaponCount + (_deactivationResult select 1);
					_redActivesCount = count _redActives; // Wichtig!

					private["_deactivationResult"];
					_deactivationResult = [_civActives, _townName] call PC_fnc_TownHome_Units_DeactivateFinished;
					_townCivCount = _townCivCount - (_deactivationResult select 0);
					_civActivesCount = count _civActives; // Wichtig!

					// -----------------------------------
					// FSM überwachen und evtl. neustarten
					// -----------------------------------
					[_civActives] call PC_fnc_TownHome_Units_ValidateFSM;
					[_redActives] call PC_fnc_TownHome_Units_ValidateFSM;

					// -----------------------------------
					// RED Einheiten AKTIVIEREN / DEAKTIVEREN
					// -----------------------------------
					if (_redSOLL > _redActivesCount) then
					{
						private["_count"];
						_count = _redSOLL - _redActivesCount;
						if (_count > 8) then { _count = 8; };
						
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
								_unitGroup = _townGroupRed;
								
								private["_unit"];
								_unit = _unitGroup createUnit [_classname, _unitPosition, [], 0, "FORM"];
								waitUntil {!isNil "_unit"};
								if (!isNull _unit) then
								{							
									_unit setDir (floor(random 360));
									_unit setpos _unitPosition;
									if (((random _townRedCount) + 1) > _townWeaponCount) then
									{
										_unit setBehaviour "CARELESS";
										_unit setCaptive true;
										removeAllWeapons _unit;	
									}
									else
									{
										_townWeaponCount = _townWeaponCount - 1;
									};
									//_unit setBehaviour "CARELESS";
									if (random 1 < 0.5) then { _unit setSpeedmode "FULL"; } else { _unit setSpeedmode "LIMITED"; };
									_unit setVariable ["townName", _townName];
									_unit setVariable ["townCenter", _townCenter];
									_unit setVariable ["townRadius", _townRadius];
									_unit setVariable ["townHome", _unitPosition];
									_unit setVariable ["TS", 0];
									//removeAllWeapons _unit;								
									_unit doFSM ["town\fsm\red2.fsm", _unitPosition, _unit];							
									_room pushBack _unit;
									_redActives pushBack [_unit, _unitGroup, _room];
								}
								else
								{
									diag_log format["ERROR: Unable to create unit: %1", _classname];
								};
							};
						};	
					
						_redActivesCount = count _redActives;		
					};			

					// -----------------------------------
					// CIV Einheiten AKTIVIEREN / DEAKTIVEREN
					// -----------------------------------
					if (_civSOLL > _civActivesCount) then
					{
						private["_count"];
						_count = _civSOLL - _civActivesCount;
						if (_count > 8) then { _count = 8; };

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
								_unitGroup = _townGroupCiv;
								
								private["_unit"];
								_unit = _unitGroup createUnit [_classname, _unitPosition, [], 0, "FORM"];
								if (!isNull _unit) then
								{
									waitUntil {!isNil "_unit"};
									_unit setDir (floor(random 360));
									_unit setpos _unitPosition;
									_unit setskill 0.01;
									if (_townInjuredCount > 1) then 
									{
										if (random 1 < 0.4) then
										{
											_townInjuredCount = _townInjuredCount - 1;
											_unit setVariable ["TI", 1, true];
										};
									};
									_unit setBehaviour "CARELESS";
									if (random 1 < 0.5) then { _unit setSpeedmode "FULL"; } else { _unit setSpeedmode "LIMITED"; };
									_unit setVariable ["townName", _townName];
									_unit setVariable ["townCenter", _townCenter];
									_unit setVariable ["townRadius", _townRadius];
									_unit setVariable ["townHome", _unitPosition];
									_unit setVariable ["TS", 0];
									_unit doFSM ["town\fsm\civ2.fsm", _unitPosition, _unit];							
									_room pushBack _unit;
									_civActives pushBack [_unit, _unitGroup, _room];	
								}
								else
								{
									diag_log format["ERROR: Unable to create unit: %1", _classname];
								};
							};
						};

						_civActivesCount = count _civActives;		
					};			
				}
				else
				{
					if (!_townIsVirtual) then
					{
						_townIsVirtual = true;
						// Alle Einheiten DEAKTIVIEREN
						if (_redActivesCount > 0) then
						{
							private["_deactivationResult"];
							_deactivationResult = [_redActives, _townObject] call PC_fnc_TownHome_Units_DeactivateAll;
							_redSOLL = 0;
							_redActives = [];
							_redActivesCount = 0;
							_townRedCount = _townRedCount - (_deactivationResult select 0);
							_townWeaponCount = _townWeaponCount + (_deactivationResult select 1);						
						};
						if (_civActivesCount > 0) then
						{
							private["_deactivationResult"];
							_deactivationResult = [_civActives, _townObject] call PC_fnc_TownHome_Units_DeactivateAll;
							_civSOLL = 0;
							_civActives = [];
							_civActivesCount = 0;
							_townCivCount = _townCivCount - (_deactivationResult select 0);
						};					
					};				
				};
			};
			
			// -----------------------------------------------------------------------------------
			// -----------------------------------------------------------------------------------
			// Hausdurchsuchungen
			// -----------------------------------------------------------------------------------
			private["_searchBuildings"];
			_searchBuildings = [_townName] call PC_fnc_TownParam_SearchBuildingPull;
			{
				private["_house"];
				_house = [_homes, _x] call PC_fnc_TownHome_GetHouse;
				if (count _house > 0) then
				{
					//-----------------------------------------------------------------------------------------------------------------------
					//_homes = [  [building-obj, [_room, _room, ...]],     [building-obj, [_room, _room, ...]],    ...   ]
					//_room (frei)       = [[x,y,z]]
					//_room (deaktviert) = [[x,y,z], classname]
					//_room (aktviert)   = [[x,y,z], classname, unit-obj]
					//-----------------------------------------------------------------------------------------------------------------------
					private["_forcedCiv"];
					_forcedCiv = 0;
					private["_forcedRed"];
					_forcedRed = 0;

					// RedForce Kräfte in der Nähe der Durchsuchung alarmieren.
					private["_bluFor"];
					_bluFor = (_house select 0) nearEntities [pixTown_ConfigBaseClassBlu, 50];
					if (count _bluFor > 0) then
					{				
						private["_redFor"];
						_redFor = (_house select 0) nearEntities [pixTown_ConfigBaseClassRed, 20 + (random 130)];
						{ 
							if (random 1 < 0.5) then 
							{ 
								private["_target"];
								_target = _bluFor select (floor (random (count _bluFor)));							
								_x setBehaviour "COMBAT";
								_x setSpeedmode "FULL";
								_x reveal [_target, 1];
								_x doTarget _target;
								_x doMove (getPos _target);
							}; 
						} foreach _redFor;
					};

					private["_rooms"];
					_rooms = _house select 1;
					{
						// Wenn die hier wohnende Einheit inaktiv ist, wird Sie nun erstellt.
						if (count _x == 2) then
						{
							private["_unitPosition"];
							_unitPosition = _x select 0;					
							private["_classname"];
							_classname = _x select 1;
							
							if (_classname in pixTown_ConfigRedClassnames) then
							{
								private ["_unitGroup"];
								_unitGroup = _townGroupRed;
								
								private["_unit"];
								_unit = _unitGroup createUnit [_classname, _unitPosition, [], 0, "FORM"];
								waitUntil {!isNil "_unit"};
								_unit setDir (random 360);
								_unit setpos _unitPosition;
								if ((random 1) < 0.3) then { _unit setUnitPos "DOWN"; } else { _unit setUnitPos "MIDDLE"; };							
								
								private["_random"];
								_random = (random 1);
								if (_random < 0.5) then {
									_unit setBehaviour "AWARE";
								} else { 
									if (_random < 0.90) then {
										_unit setBehaviour "COMBAT";
									} else {
										_unit setBehaviour "CARELESS";
										_unit setCaptive true;
									};
								};
								
								{ _unit reveal [_x, 1.5]; } foreach _bluFor;								 
								
								_x pushBack _unit;
								//removeAllWeapons _unit; 
								_redActives pushBack [_unit, _unitGroup, _x];
								_forcedRed = _forcedRed + 1;
								_redActivesCount = count _redActives;		
							}
							else
							{
								private ["_unitGroup"];
								_unitGroup = _townGroupCiv;
								private["_unit"];
								_unit = _unitGroup createUnit [_classname, _unitPosition, [], 0, "FORM"];
								waitUntil {!isNil "_unit"};
								_unit setDir (random 360);
								_unit setpos _unitPosition;
								_unit setskill 0.01;
								_unit setBehaviour "CARELESS";
								_unit setSpeedmode "FULL";
								_unit setVariable ["townName", _townName];
								_unit setVariable ["townCenter", _townCenter];
								_unit setVariable ["townRadius", _townRadius];
								_unit setVariable ["townHome", _unitPosition];
								_unit setVariable ["TS", 0];
								_unit doFSM ["town\fsm\civSearched.fsm", _unitPosition, _unit];							
								_x pushBack _unit;
								_civActives pushBack [_unit, _unitGroup, _x];	
								_forcedCiv = _forcedCiv + 1;
								_civActivesCount = count _civActives;		
							};
						};
					} foreach _rooms;
					
					// Auswerten wie sich die Stimmung ändert
					if ((_forcedRed == 0) && (_forcedCiv > 0)) then
					{
						[_townName, pixTown_ConfigMoodPerHouseSearchCiv] call PC_fnc_Townparam_MoodAdd;
					}
					else
					{
						if (_forcedRed > 0) then
						{
							[_townName, pixTown_ConfigMoodPerHouseSearchRed] call PC_fnc_Townparam_MoodAdd;
						};
					};			
				};
			
				// -------------------------------
				// Rauch werfen
				// -------------------------------
				private["_smokePositions"];
				_smokePositions = [];
				private["_maxIndex"];
				_maxIndex = 0;
				while { str(_x buildingPos _maxIndex) != "[0,0,0]" } do 
				{
					_smokePositions pushBack (_x buildingPos _maxIndex);
					_maxIndex = _maxIndex + 1;
				};
				private["_tmp"];
				_tmp = [_smokePositions] execVM "town\createRoomSmoke.sqf";
				
			} foreach _searchBuildings;
		};
	};
};