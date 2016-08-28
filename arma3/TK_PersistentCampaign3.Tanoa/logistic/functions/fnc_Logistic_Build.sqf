#include "CFG_BUILDABLES_INDICES.hpp"

private _classname = _this select 0;

private _config = [_classname, true] call fnc_logistic_CanBuild;
if (count _config > 0) then
{
	// Lokales-Objekt erstellen
	private _objectLocal = _classname createVehicleLocal ((position player) findEmptyPosition [0, 1000, _classname]);	
	waitUntil {!isNil "_objectLocal"};
	_objectLocal attachTo [player, _config select ATTACHPOINT_INDEX];

	// Verschiedene Ãœberwachungen
	logisticHeightObject = 0;
	logisticDistanceObject = 0;
	logisticRotateObject = 0;
	logisticMoveObject = _objectLocal;
	logisticDecision = 1;

	private _actionMenu = player addAction [format["<t color=""#dddd00"">%1</t>", localize "str_pc3_StartBuilding"], { 
		logisticDecision = 0; 
		logisticMoveObject = objNull; 
	}, nil, 20, true, true];
	private _actionMenu2 = player addAction [(localize "str_pc3_Abort"), { 
		logisticDecision = 1; 
		logisticMoveObject = objNull; 
	}, nil, 19, true, true];
	private _actionMenu3 = player addAction [(localize "str_pc3_RotateBuilding"), { 
		logisticRotateObject = logisticRotateObject + 45; 
		(_this select 3) setDir logisticRotateObject; 
	}, _objectLocal, 18, true, true];
	private _actionMenu4 = player addAction [(localize "str_pc3_DistanceBuildingP"), { 
		logisticDistanceObject = logisticDistanceObject + 1;
		private _position = (_this select 3) select 1;
		((_this select 3) select 0) attachTo [player, [_position select 0, (_position select 1) + logisticDistanceObject, _position select 2]];
	}, [_objectLocal, _config select ATTACHPOINT_INDEX], 17, true, true];
	private _actionMenu5 = player addAction [(localize "str_pc3_DistanceBuildingN"), { 
		logisticDistanceObject = logisticDistanceObject - 1;
		private _position = (_this select 3) select 1;
		((_this select 3) select 0) attachTo [player, [_position select 0, (_position select 1) + logisticDistanceObject, _position select 2]];
	}, [_objectLocal, _config select ATTACHPOINT_INDEX], 16, true, true];
	private _actionMenu6 = player addAction [(localize "str_pc3_HeightBuildingP"), { 
		logisticHeightObject = logisticHeightObject + 0.5;
		private _position = (_this select 3) select 1;
		((_this select 3) select 0) attachTo [player, [_position select 0, _position select 1, (_position select 2) + logisticHeightObject]];
	}, [_objectLocal, _config select ATTACHPOINT_INDEX], 15, true, true];
	private _actionMenu7 = player addAction [(localize "str_pc3_HeightBuildingN"), { 
		logisticHeightObject = logisticHeightObject - 0.5;
		private _position = (_this select 3) select 1;
		((_this select 3) select 0) attachTo [player, [_position select 0, _position select 1, (_position select 2) + logisticHeightObject]];
	}, [_objectLocal, _config select ATTACHPOINT_INDEX], 14, true, true];

	while {!(isNull logisticMoveObject) && (alive player)} do
	{
		if (vehicle player != player) then
		{
			player action ["eject", vehicle player];
			sleep 1;
		};

		sleep 0.25;
	};

	player removeAction _actionMenu7;
	player removeAction _actionMenu6;
	player removeAction _actionMenu5;
	player removeAction _actionMenu4;
	player removeAction _actionMenu3;
	player removeAction _actionMenu2;
	player removeAction _actionMenu;
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
	logisticHeightObject = nil;
	logisticDistanceObject = nil;
	logisticRotateObject = nil;
	logisticMoveObject = nil;
	logisticDecision = nil; 
};