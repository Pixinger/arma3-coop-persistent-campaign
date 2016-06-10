#include "CFG_BUILDABLES_INDICES.hpp"

private["_classname"];
_classname = _this select 0;

private["_deleteResources"];
if (count _this >= 2) then {_deleteResources=_this select 1;} else {_deleteResources=false;};

private["_result"];
_result = [];

private["_configIndex"];
_configIndex = logisticBuildables find _classname;
if (_configIndex != -1) then
{
	private["_config"];
	_config = logisticBuildableConfigs select _configIndex;
	
	// Erstmal gehen wir davon aus, das wir genug Resourcen finden werden.
	// Erst wenn eine Schleife wegen Resourcenmangel abbrechen muss, setzen wir _result=[];
	_result = _config;

	private["_requiredResources"];
	_requiredResources = _config select REQUIREDRESOURCES_INDEX;
	
	// (SCHRITT 1)
	// Im ersten Schritt prüfen wir, ob genug Resourcen vorhanden sind.
	// Erst im zweiten Schritt löschen wir die Resourcen. Dabei ist der Code zwar ein wenigwerden
	// redundant, aber man muss halt erst sehen, ob wirklich alle Resourcen da sind, bevor wir sie wegnehmen.
	{
		private["_requiredClassname"];
		_requiredClassname = _x select 0;
		private["_requiredQuantity"];
		_requiredQuantity = _x select 1;
		private["_objects"];
		_objects = (position player) nearObjects [_requiredClassname, 5];			
		{
			private["_availabvelQuantity"];
			_availabvelQuantity = _x getVariable ["quantity", 100];
			_requiredQuantity = _requiredQuantity - _availabvelQuantity;
			if (_requiredQuantity <= 0) exitWith { };
		} foreach _objects;		
		
		// Prüfen ob genug Objekte von der aktuell iterierten Ressource vorhanden sind
		if (_requiredQuantity > 0) exitWith 
		{
			_result = [];
		};			
	} foreach _requiredResources;		

	// (SCHRITT 2)
	// Dieses ist der zweite Schritt.
	// Hier belegen/löschen wir die benötigten Resourcen (wenn das im _this Parameter so angegeben wurde).
	// Wichtig ist, dass wir hier "dankbar" vorgehen. Durch multi-threading könnte es sein, dass inzwischen einige
	// Resourcen verschwunden sind. Das muss dann hier zum wohle des Nutzers verabreitet werden.
	if ((_deleteResources) && (count _result > 0)) then
	{
		{
			private["_requiredClassname"];
			_requiredClassname = _x select 0;
			private["_requiredQuantity"];
			_requiredQuantity = _x select 1;
			private["_objects"];
			_objects = (position player) nearObjects [_requiredClassname, 5];			
			{
				private["_availabvelQuantity"];
				_availabvelQuantity = _x getVariable ["quantity", 100];

				if (_requiredQuantity >= _availabvelQuantity) then
				{
					// Das Objekt wurde vollständig aufgebraucht. Deshalb löschen wir es jetzt und übernehmen zumindest den Restinhalt.
					_requiredQuantity = _requiredQuantity - _availabvelQuantity;
					deleteVehicle _x;
				}
				else
				{
					// Das Objekt wurde nich vollständig aufgebraucht. Deshalb ziehen wir unseren Bedarf ab und veröffentlichen dies.
					_availabvelQuantity = _availabvelQuantity - _requiredQuantity;
					_x setVariable["quantity", _availabvelQuantity, true];
					_requiredQuantity = 0;
				};
				
				if (_requiredQuantity <= 0) exitWith { };
			} foreach _objects;						
		} foreach _requiredResources;		
	};
};

_result; // Nein=[], sonst den "logisticBuildables" Eintrag mit der Konfiguration (Attachpoint usw.).
