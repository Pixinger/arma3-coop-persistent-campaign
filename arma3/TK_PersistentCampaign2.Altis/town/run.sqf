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

	// ----------------------------------------------------------------------
	// Stadtparameter auslesen (aus der Datenbank)
	// ----------------------------------------------------------------------
	private["_townStockWater"];	// Der Lagerbestand an Wasser
	_townStockWater = 0;//DB
	private["_townStockFood"];     // Der Lagerbestand an Nahrungsmitteln
	_townStockFood = 0;//DB
	private["_townMood"];
	_townMood = 0;//DB			// Die Stimmung in der Stadt: -1 Red < 0 < Blu +1.
	private["_townCivCount"];
	_townCivCount = 100;//DB		// Die Anzahl der Zivilisten in der Stadt (virtuell).
	private["_townRedCount"];
	_townRedCount = 100;//DB		// Die Anzahl der Feinde in der Stadt (virtuell).
	private["_townWeaponCount"];
	_townWeaponCount = 0;//DB		// Die Anzahl der Waffen in der Stadt (virtuell).
	private["_townWarlordCount"];
	_townWarlordCount = 0;//DB		// Die Anzahl der Warlords in der Stadt (virtuell).
	private["_townInjuredCount"];
	_townInjuredCount = 10;//DB		// Die Anzahl der verletzten in der Stadt (virtuell). Das können CIV und RED sein!

	
	// -----------------------------------
	// Marker erstellen
	// -----------------------------------
	private["_townMarker"];
	_townMarker = createMarker[format["markerTown%1", _townName], _townCenter];
	_townMarker setMarkerShape "ELLIPSE";
	_townMarker setMarkerSize [_townRadius, _townRadius];
	_townMarker setMarkerAlpha 0.7;
	if (_townCivCount / _townRedCount < 0.1) then 
	{
		_townMarker setMarkerColor "ColorRed";
	}
	else
	{
		if (_townCivCount / _townRedCount > 10) then 
		{
			_townMarker setMarkerColor "ColorGreen";
		}
		else
		{
			_townMarker setMarkerColor "ColorBlack";
		};
	};

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
	private["_townAttacked"];
	_townAttacked = false;
	private["_townPopulation"];
	_townPopulation = 0;
	
	private["_townSimulationCounter"];
	_townSimulationCounter = 0;
	private["_townOnlineOfflineCounter"];
	_townOnlineOfflineCounter = 0;
	
	// Erst nach dem Briefing beginnen
	Sleep (0.1); 
	
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
		// Simulation: Berechnen der Bevölkrungsparameter (Anzahl, Lager, Stimmung, ...)
		// -----------------------------------------------------------------------------------
		_townSimulationCounter = _townSimulationCounter - 1;
		if (_townSimulationCounter < 0) then
		{
			_townSimulationCounter = 6;
			private["_deltaHours"];
			_deltaHours = (time - _lastServerTime) / 3600.0;      
			_lastServerTime = time;
			if (pixDebug) then { _deltaHours = 0.1; };
			
diag_log "-------------------------------------------------------------------------------";
diag_log format["_townName=%4 _deltaHours=%1 time=%2 serverTime=%3 _townMaxPopulation=%5", _deltaHours, time, serverTime, _townName, _townMaxPopulation];

			// ----------------------------------------------------------------------
			// Gesamtbevölkerung berechnen (wird immer wieder mal benötigt)
			// ----------------------------------------------------------------------
			_townPopulation = _townCivCount + _townRedCount + _townWarlordCount;

				
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
			// RED simulieren (_simulatedRedCount)
			// -----------------------------------
diag_log format["_townCivCount=%1  _townRedCount=%2 (Vorgabe)", _townCivCount, _townRedCount];
			private["_simulatedRedCount"];
			_simulatedRedCount = _townRedCount;
			private["_simulatedCivCount"];
			_simulatedCivCount = _townCivCount;

			// Konvertierung berechnen
			if (_townMood < -0.1) then
			{
				private["_conversion"];
				_conversion = (pixTown_ConfigMaxRed2CivConversionPPH * _simulatedCivCount * _deltaHours) * (_townMood * -1);
diag_log format["RED _conversion=%1", _conversion];
				_simulatedRedCount = _simulatedRedCount + _conversion;
				_simulatedCivCount = _simulatedCivCount - _conversion;
				if (_simulatedCivCount < 0) then { _simulatedCivCount = 0; };
			};

			// Blu-Force kills fördern das Wachstum
			_simulatedRedCount = _simulatedRedCount + (pixTown_ConfigRedGrowPerBluKill * ([_townName] call PC_fnc_Townparam_BluKillPull));

			// Ein Warlord fördert das Wachstum
			private["_factor"];
			_factor = 1;
			if (_townWarlordCount > 0) then { _factor = _factor + (pixTown_ConfigRedGrowFactorPerWarlord * _townWarlordCount); };

			// Wachstum berechnen und hinzufügen (nur wenn die Stimmung schlecht ist, gibt es ein Grundwachstum.)
			if (_townMood < pixTown_ConfigRedGrowRateMoodLimit) then 
			{
				_simulatedRedCount = _simulatedRedCount + ((pixTown_ConfigRedGrowRatePPH * _simulatedRedCount * _deltaHours) * _factor);
			};

			// -----------------------------------
			// CIV simulieren (_simulatedCivCount)
			// -----------------------------------
			// Konvertierung berechnen
			if (_townMood > 0.1) then
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

			// Wachstum berechnen und hinzufügen
			_simulatedCivCount = _simulatedCivCount + (pixTown_ConfigCivGrowRatePPH * _simulatedCivCount * _deltaHours * _factor);
diag_log format["_simulatedCivCount=%1  _simulatedRedCount=%2 (reine Kalkulation)+", _simulatedCivCount, _simulatedRedCount];

			// ----------------------------------------------------------------------
			// Wachstum auf Stadtgrenzen limitieren
			// ----------------------------------------------------------------------
			if (_simulatedCivCount > _townMaxPopulation) then { _simulatedCivCount = _townMaxPopulation; };
			if (_simulatedCivCount + _simulatedRedCount > _townMaxPopulation) then { _simulatedRedCount = _townMaxPopulation - _simulatedCivCount; };
			if (_simulatedCivCount + _simulatedRedCount + _townWarlordCount > _townMaxPopulation) then { _townWarlordCount = _townMaxPopulation - (_simulatedCivCount + _simulatedRedCount); };
diag_log format["_simulatedCivCount=%1  _simulatedRedCount=%2 _townWarlordCount=%3 (MaxPopLimited)", _simulatedCivCount, _simulatedRedCount, _townWarlordCount];

			// ----------------------------------------------------------------------
			// _simulatedRedCount in Homes/_townRedCount übertragen (RED)
			// ----------------------------------------------------------------------
			private["_count"];		
			_count = floor(_simulatedRedCount) - floor(_townRedCount);
diag_log format["_simulatedRedCount=%1 => neue Bewohner: %2", _simulatedRedCount, _count];
			private["_result"];
			_result = [_homes, pixTown_ConfigRedClassnames, _count] call PC_fnc_TownHome_SettleRooms;
			if (_count != _result) then
			{
				_townRedCount = floor(_townRedCount) + _result; //TODO: noch prüfen ob die RED auch korrekt verringert werden!
diag_log format["WARN: Es konnten nur %1 von %2 RED-Wohneinheiten geändert werden.", _result, _count];
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
diag_log format["_simulatedCivCount=%1 => neue Bewohner: %2", _simulatedCivCount, _count];
			private["_result"];
			_result = [_homes, pixTown_ConfigCivClassnames, _count] call PC_fnc_TownHome_SettleRooms;
			if (_count != _result) then
			{
				_townCivCount = floor(_townCivCount) + _result; //TODO: noch prüfen ob die CIV auch korrekt verringert werden!
diag_log format["WARN: Es konnten nur %1 von %2 CIV-Wohneinheiten geändert werden.", _result, _count];
			}
			else
			{
				_townCivCount = _simulatedCivCount;
			};
diag_log format["_townCivCount=%1 _townRedCount=%2 (Endergebnis)", _townCivCount, _townRedCount];
			
			// -----------------------------------
			// Injured simulieren
			// -----------------------------------
			_townInjuredCount = _townInjuredCount + (pixTown_ConfigInjuredGrowFactorPPH * (_townRedCount + _townCivCount) * _deltaHours);
			_townInjuredCount = _townInjuredCount + ([_townName] call PC_fnc_TownParam_InjuredPull);		
			if (_townInjuredCount < 0) then { _townInjuredCount = 0; };
diag_log format["_townInjuredCount=%1", _townInjuredCount];	
			
			// ----------------------------------------------------------------------
			// Die Werte für die öffentlichkeit zwischenspeichern
			// ----------------------------------------------------------------------
			[_townName, _townCivCount, _townRedCount, _townInjuredCount, _townMood, _townStockFood, _townStockWater] call PC_fnc_TownHome_StatusUpdate;
		
			
		};
		
		// -----------------------------------------------------------------------------------
		// -----------------------------------------------------------------------------------
		// Online/Offline: Einheiten laufen auf der Karte herum
		// -----------------------------------------------------------------------------------
		_townOnlineOfflineCounter = _townOnlineOfflineCounter - 1;
		if (_townOnlineOfflineCounter < 0) then
		{
			_townOnlineOfflineCounter = 6;		//TODO: Radiuus abhängig von der Anzahl der Feineinheiten machen
			if ([_townCenter, 1000 + _townRedCount] call PC_fnc_IsAnyPlayerNear) then
			{
			
				// _civSOLL und _redSOLL berechnen
				private["_tmpCivCount"];
				_tmpCivCount = _townCivCount; 
				private["_tmpRedCount"];
				_tmpRedCount = _townRedCount; 
				if (_townAttacked) then // Angriff verschiebt die Aktivitäten in Richtung RED
				{
					_tmpCivCount = _tmpCivCount * 0.3;
					_tmpRedCount = _tmpRedCount + (_townCivCount - _tmpCivCount);
				};
				private["_tmpTotalSOLL"];
				_tmpTotalSOLL = (_tmpCivCount + _tmpRedCount) / 10; 
				if (_tmpTotalSOLL > 40) then { _tmpTotalSOLL = 40; }; // Deckeln
				if (!_townAttacked) then { if ((daytime > 22) || (daytime < 7)) then { _tmpTotalSOLL = _tmpTotalSOLL * 0.5 }; }; // Wenn kein Angriff, dann in der Nacht generell weniger Einheiten
				
				_tmpTotalSOLL = ceil(_tmpTotalSOLL);
				_civSOLL = ceil((_tmpTotalSOLL / (_tmpCivCount + _tmpRedCount)) * _tmpCivCount);
				_redSOLL = _tmpTotalSOLL - _civSOLL;
diag_log format["%1 online: tC=%2,tR=%3,max=%4,sollC=%5,sollR=%6", _townName, _townCivCount, _townRedCount, _townMaxPopulation,_civSOLL, _redSOLL];
player sidechat format["%1 online: tC=%2,tR=%3,max=%4,sollC=%5,sollR=%6", _townName, _townCivCount, _townRedCount, _townMaxPopulation,_civSOLL, _redSOLL];

	//_civSOLL = 2;
	//_redSOLL = 2;
				
				// -----------------------------------
				// "Fertige" CIV/RED Einheiten DEAKTIVIEREN
				// -----------------------------------
				[_redActives, _townName] call PC_fnc_TownHome_Units_DeactivateFinished;
				_redActivesCount = count _redActives; // Zähler aktualisieren
diag_log format["%2: _redActivesCount=%1 (PC_fnc_TownHome_Units_DeactivateFinished)", _redActivesCount, _townName];
				[_civActives, _townName] call PC_fnc_TownHome_Units_DeactivateFinished;
				_civActivesCount = count _civActives;		
diag_log format["%2: _civActivesCount=%1 (PC_fnc_TownHome_Units_DeactivateFinished)", _civActivesCount, _townName];

				// -----------------------------------
				// FSM überwachen und evtl. neustarten
				// -----------------------------------
				[_civActives] call PC_fnc_TownHome_Units_ValidateFSM;

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
							_unitGroup = createGroup east;//independent;
							
							private["_unit"];
							_unit = _unitGroup createUnit [_classname, _unitPosition, [], 0, "FORM"];
							waitUntil {!isNil "_unit"};
							if (!isNull _unit) then
							{							
								_unit setDir (floor(random 360));
								_unit setpos _unitPosition;
								//if (_townInjuredCount > 1) then 
								if (false) then 
								{
									if (random 1 < 0.2) then
									{
	diag_log "injured red";
										_townInjuredCount = _townInjuredCount - 1;
										_unit setVariable ["injured", 1];
							
										//TODO: noch prüfen
										removeAllWeapons _unit;								
									};
								};
								_unit setBehaviour "CARELESS";
								//_unit setSpeedmode "FULL";
								_unit setVariable ["townName", _townName];
								_unit setVariable ["townCenter", _townCenter];
								_unit setVariable ["townRadius", _townRadius];
								_unit setVariable ["townHome", _unitPosition];
								_unit setVariable ["AA", 0];
								_unit doFSM ["town\fsm\red2.fsm", _unitPosition, _unit];							
								_room pushBack _unit;
								_redActives pushBack [_unit, _unitGroup, _room];
	diag_log format["%2: created red: %1", _unit, _townName];
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
							_unitGroup = createGroup civilian;
							
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
									//if (true) then
									if (random 1 < 0.5) then
									{
	diag_log "injured civ";
										_townInjuredCount = _townInjuredCount - 1;
										_unit setVariable ["injured", 1, true];
									};
								};
								_unit setBehaviour "CARELESS";
								_unit setSpeedmode "FULL";
								_unit setVariable ["townName", _townName];
								_unit setVariable ["townCenter", _townCenter];
								_unit setVariable ["townRadius", _townRadius];
								_unit setVariable ["townHome", _unitPosition];
								_unit setVariable ["fsmtick", (time + 60)];
								_unit setVariable ["AA", 0];
								_unit doFSM ["town\fsm\civ2.fsm", _unitPosition, _unit];							
								_room pushBack _unit;
								_civActives pushBack [_unit, _unitGroup, _room];	
diag_log format["%2: created civ: %1", _unit, _townName];
							}
							else
							{
								diag_log format["ERROR: Unable to create unit: %1", _classname];
							};
						};
					};

					_civActivesCount = count _civActives;		
				};			
				
//diag_log format["_civActives loop: %1", _civActives];
			}
			else
			{
diag_log "town virtual. no player close engough.";
				// Alle Einheiten DEAKTIVIEREN
				if (_redActivesCount > 0) then
				{
diag_log "deactivate RED";
					_redSOLL = 0;
					[_redActives, _townObject] call PC_fnc_TownHome_Units_DeactivateAll;
					_redActivesCount = 0;
				};
				if (_civActivesCount > 0) then
				{
diag_log "deactivate CIV";
					_civSOLL = 0;
					[_civActives, _townObject] call PC_fnc_TownHome_Units_DeactivateAll;
					_civActivesCount = 0;
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
diag_log format["Durchsuchen von Gebäude %1 wurde angefragt. %2", _x, getPos _x];
				
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

				private["_rooms"];
				_rooms = _house select 1;
				{
					// Wenn die hier Wohnende Einheit inaktiv ist, wird Sie nun erstellt.
					if (count _x == 2) then
					{
						private["_unitPosition"];
						_unitPosition = _x select 0;					
						private["_classname"];
						_classname = _x select 1;
						
						if ((_classname in pixTown_ConfigRedClassnames) || (_classname in pixTown_ConfigWarlordClassnames)) then
						{
							private ["_unitGroup"];
							_unitGroup = createGroup east;//independent;
							
							private["_unit"];
							_unit = _unitGroup createUnit [_classname, _unitPosition, [], 0, "FORM"];
							waitUntil {!isNil "_unit"};
							_unit setDir (random 360);
							_unit setpos _unitPosition;
							if ((random 1) < 0.66) then 
							{ 
								removeAllWeapons _unit; 
								_unit setBehaviour "CARELESS";
							}
							else
							{
								private["_hostiles"];
								_hostiles = _unitPosition nearEntities ["SoldierWB", 100];
								{
									_unit reveal [_x, 1.5];
								} foreach _hostiles;								 
								_unit setBehaviour "AWARE";								
							};
							//_unit setVariable ["townName", _townName];
							//_unit setVariable ["townCenter", _townCenter];
							//_unit setVariable ["townRadius", _townRadius];
							//_unit setVariable ["townHome", _unitPosition];
							//_unit doFSM ["town\fsm\red2.fsm", _unitPosition, _unit];							
							_x pushBack _unit;
							_redActives pushBack [_unit, _unitGroup, _x];
							_forcedRed = _forcedRed + 1;
							_redActivesCount = count _redActives;		
diag_log format["%2: created searched red: %1", _unit, _townName];						
						}
						else
						{
							private ["_unitGroup"];
							_unitGroup = createGroup civilian;							
							private["_unit"];
							_unit = _unitGroup createUnit [_classname, _unitPosition, [], 0, "FORM"];
							waitUntil {!isNil "_unit"};
							_unit setDir (random 360);
							_unit setpos _unitPosition;
							_unit setBehaviour "CARELESS";
							_unit setSpeedmode "FULL";
							_unit setVariable ["townName", _townName];
							_unit setVariable ["townCenter", _townCenter];
							_unit setVariable ["townRadius", _townRadius];
							_unit setVariable ["townHome", _unitPosition];
							_unit setVariable ["fsmtick", (time + 60)];
							_unit doFSM ["town\fsm\civSearched.fsm", _unitPosition, _unit];							
							_x pushBack _unit;
							_civActives pushBack [_unit, _unitGroup, _x];	
							_forcedCiv = _forcedCiv + 1;
							_civActivesCount = count _civActives;		
diag_log format["_civActives search: %1", _civActives];
diag_log format["%2: created searched civ: %1", _unit, _townName];	
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
				_maxIndex = _maxIndex + 2;
			};
			private["_tmp"];
			_tmp = [_smokePositions] execVM "town\createRoomSmoke.sqf";
			
		} foreach _searchBuildings;
	};	
};