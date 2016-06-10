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
		private _directionLocal = getDir _objectLocal; 
		private _positionLocal = getPos _objectLocal;
		private _detachOffset = (_config select DETACHOFFSET_INDEX); 
		private _heightATL = (getPosATL player) select 2;
		if ((_heightATL < 1) && (_heightATL > -1)) then { _heightATL = 0; }; 		
				
		private _positionGlobal = _objectLocal modelToWorld _detachOffset;
		_positionGlobal set [2, (_heightATL + (_detachOffset select 2))];
		deleteVehicle _objectLocal;
		
		//---------------------------------
		// Globales-Objekt erstellen
		//---------------------------------
		private["_objectGlobal"];
		_objectGlobal = createVehicle [_classname, [0,0,0], [], 0, "CAN_COLLIDE"]; //_objectGlobal = _classname createVehicle _positionGlobal;
		waitUntil {!isNil "_objectGlobal"};
		_objectGlobal setPosATL _positionGlobal;
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