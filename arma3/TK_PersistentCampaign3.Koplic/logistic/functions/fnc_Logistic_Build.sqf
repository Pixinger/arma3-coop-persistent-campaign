#include "CFG_BUILDABLES_INDICES.hpp"

private _classname = _this select 0;

private _config = [_classname, true] call fnc_logistic_CanBuild;
if (count _config > 0) then
{
	// Lokales-Objekt erstellen
	private _objectLocal = _classname createVehicleLocal ((position player) findEmptyPosition [0, 1000, _classname]);	
	waitUntil {!isNil "_objectLocal"};
	_objectLocal attachTo [player, _config select ATTACHPOINT_INDEX];

	private _actionMenu = player addAction [("<t color=""#dddd00"">Bauen starten</t>"), { logisticDecision = 0; logisticMoveObject = objNull; }, nil, 5, true, true];
	private _actionMenu2 = player addAction [("<t color=""#dddd00"">Bauen abbrechen</t>"), { logisticDecision = 1; logisticMoveObject = objNull; }, nil, 5, true, true];

	// Verschiedene Überwachungen
	logisticMoveObject = _objectLocal;
	logisticDecision = 1;
	while {!(isNull logisticMoveObject) && (alive player)} do
	{
		if (vehicle player != player) then
		{
			player action ["eject", vehicle player];
			sleep 1;
		};

		sleep 0.25;
	};

	player removeAction _actionMenu;
	player removeAction _actionMenu2;
	if (logisticDecision == 0) then
	{
		//---------------------------------
		// Das Object soll gebaut werden		
		//---------------------------------
		// Klar, das ist die Richtung.
		private _directionLocal = getDir _objectLocal; 
		// Genau, das ist die Position des Lokalen Objektes. Diese wird aber noch korrigiert, bevor wir das Globale-Objekt erstellen.
		private _positionLocal = getPos _objectLocal;
		// Da wir das Objekt etwas höher ATTACHEN, müssen wir es beim Absetzen auch wieder um diesen Faktor absenken.
		// DAS HEBT SICH AUF!! Kann gelöscht werden wenn es GEHT: private _heightAttach = (_config select ATTACHPOINT_INDEX) select 2;
		// Da die Objekte manchmal Unterschiede zwischen ATTACH-Punkt und Pivot-Punkt haben, gleichen wir das hiermit bei Bedarf aus. Der Z-Parameter gibt ausserdem an wie weit im Boden das Objekt verschwinden soll.
		private _detachOffset = (_config select DETACHOFFSET_INDEX); 
		// Wenn man in der Nähe des Bodens ist, dann "snappen" wird genau auf 0. Dazu bestimmen wir einen "Height" Parameter.
		private _heightATL = (getPosATL player) select 2;
		if ((_heightATL < 1) && (_heightATL > -1)) then { _heightATL = 0; }; 
		
		private _positionGlobal = [(_positionLocal select 0) + (_detachOffset + select 0), (_positionLocal select 1) + (_detachOffset + select 1), _heightATL + (_detachOffset + select 2) -];
		// DAS HEBT SICH AUF!! Kann gelöscht werden wenn es GEHT: private _positionGlobal = [(_positionLocal select 0) + (_detachOffset + select 0), (_positionLocal select 1) + (_detachOffset + select 1), _heightATL - _heightAttach + (_positionLocal select 2) + (_detachOffset + select 2) -];
		deleteVehicle _objectLocal;
		
		//---------------------------------
		// Globales-Objekt erstellen
		//---------------------------------
		private["_objectGlobal"];
		_objectGlobal = createVehicle [_classname, _positionGlobal, [], 0, "CAN_COLLIDE"]; //_objectGlobal = _classname createVehicle _positionGlobal;
		waitUntil {!isNil "_objectGlobal"};
		//_objectGlobal setPosATL _positionGlobal;
		_objectGlobal setDir _directionLocal;
	
		//---------------------------------
		// Mit dem Bauen beginnen (übergeben an Up-Down-Skript)
		//---------------------------------
		[_objectGlobal, 1, false] spawn fnc_logistic_BuildUpDown;
	}
	else
	{
		// Das Object soll nicht gebaut werden		
		deleteVehicle _objectLocal;		
	};
	logisticMoveObject = nil;
	logisticDecision = nil; 
};