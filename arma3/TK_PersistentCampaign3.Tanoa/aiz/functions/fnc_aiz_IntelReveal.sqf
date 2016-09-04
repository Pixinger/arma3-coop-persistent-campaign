#include "..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS
if (isServer) then
{		
	_this spawn {

		waitUntil {aizZoneInitCompleted};

		//-----------------------------------------------------------------	
		// Intel aktualisieren
		private _chance = if (_classname isKindOf cfgLogisticTakePrisonOfficerClassname) then { 2 } else { 5 };		
		if ([1, _chance] call BIS_fnc_randomInt <= 1) then
		{	
			private _loop = 100;
			private _isOffline = true;			
			while { _isOffline && _loop > 0 } do
			{
				_loop = _loop - 1;
				private _zoneIndex = [1, cfgAizZoneCount] call BIS_fnc_randomInt;
				call compile format["_isOffline = aizZoneOffline%1;", _zoneIndex];
				if (!_isOffline) exitWith 
				{ 
					// -------------------------------------------------------------------------
					// Auf jeden Fall verzögern wir diese Informationen
					if (pixDebug) then { Sleep 1; } else { Sleep 10 + (random 20); };

					// -------------------------------------------------------------------------
					// Die Chancen dafür, dass es die Wahrheit ist (X zu 1):
					#define CHANCE_TO_REVEAL_TRUTH	2

					// -------------------------------------------------------------------------
					// aizZoneData%1 auslesen
					if (isNil format["aizZoneData%1", _zoneIndex]) exitWith	{ ERROR_LOG_VAREX("fnc_aiz_IntelReveal: Unable to read aizZoneData", _zoneIndex); false; };

					private "_zoneData";
					call compile format["_zoneData = aizZoneData%1;", _zoneIndex];

					private _campsTown = _zoneData select 0;		// [house, housePosIndex]
					private _campsField = _zoneData select 1;		// [position, initialRespawns]
					private _checkpoints = _zoneData select 2;		// [position, direction]

					// -------------------------------------------------------------------------
					// 
					private _geoInfo = [format["markerAiz%1", _zoneIndex], 0];
					private _position = [0,0,0];
					private _radius = 100;
					private _markerText = "INTEL";
					private _truth = if ([1, CHANCE_TO_REVEAL_TRUTH] call BIS_fnc_randomInt > 1) then { false; } else { true; };
					if (_truth) then
					{
						private _positions = [];
						{ _positions pushBack (getPos (_x select 0));} foreach _campsTown;
						{ _positions pushBack (_x select 0);} foreach _campsField;
						{ _positions pushBack (_x select 0);} foreach _checkpoints;
					
						_position = _positions call PIX_fnc_RandomElement;
					}
					else
					{
						// Town-Camp
						private _type = [1, 3] call BIS_fnc_randomInt;
						if (_type == 1) then 
						{
							private _randomPosition = [_geoInfo, [true, [10, 100]]] call fnc_aiz_GetRandomPositionHouse; // [house, buildingPosIndex]
							if (count _randomPosition > 0) then	{ _position = getPos (_randomPosition select 0);};
						};
						// Field-Camp
						if (_type == 2) then 
						{
							private _randomPosition = [_geoInfo, [5]] call fnc_aiz_GetRandomPositionField; // [position]
							if (count _randomPosition > 0) then	{ _position = _randomPosition;};
						};
						// Checkpoint
						if (_type == 3) then 
						{
							_randomPosition = [_geoInfo] call fnc_aiz_GetRandomPositionRoad; // [position, direction]
							if (count _randomPosition > 0) then	{ _position = (_randomPosition select 0);};
						};
					};
					
					if ((_position select 0) != 0) then
					{
						// -------------------------------------------------------------------------
						// Obfuscate Position
						_position set [0, (_position select 0) + (-_radius + (random (2*_radius)))];
						_position set [1, (_position select 1) + (-_radius + (random (2*_radius)))];

						// -------------------------------------------------------------------------
						// Reveal Informationen darstellen
						private _markerName = createMarker [format["markerIntel%1_%2_1", _zoneIndex, floor(random 999999)], _position];
						_markerName setMarkerShape "ELLIPSE";
						_markerName setMarkerSize [_radius, _radius];
						_markerName setMarkerColor "ColorOrange";
						if (pixDebug) then { if (_truth) then {_markerName setMarkerColor "ColorOrange";} else { _markerName setMarkerColor "ColorBlack"; }; };
						_markerName setMarkerAlpha 0.5;

						private _markerName2 = createMarker [format["markerIntel%1_%2_2", _zoneIndex, floor(random 999999)], _position];
						_markerName2 setMarkerShape "icon";
						_markerName2 setMarkerType "mil_dot";
						_markerName2 setMarkerText _markerText;	
						_markerName setMarkerAlpha 0.5;
						
						
						[
							west,		//0: BOOL or OBJECT or GROUP or SIDE or ARRAY - Task owner(s)
							[format["%1_task",_markerName]],	//1: STRING or ARRAY - Task name or array in the format [task name, parent task name]
							[
								"Das Verhören eines Gefangenen enthüllte ein verdächtiges Gebiet.",
								"POW Info",
								format["%1_sub",_markerName]
							], //2: ARRAY or STRING - Task texts in the format ["description", "title", "marker"] or CfgTaskDescriptions class
							_position,	//3: OBJECT or ARRAY or STRING - Task destination (use [object,true] to always show marker on the object, even if player doesn't 'knowsAbout' it)
							"CREATED",	//4: BOOL or NUMBER or STRING - Task state (or true to set as current) "CREATED","ASSIGNED","AUTOASSIGNED",SUCCEEDED","FAILED","CANCELED"
							2, 			//5: NUMBER - Task priority (when automatically selecting a new current task, higher priority is selected first)
							true		//6: BOOL - Show notification (default: true)
						] call BIS_fnc_taskCreate
					};				
				};
			};			
		};
	};
}
else
{
	[] remoteExec ["fnc_aiz_IntelReveal", 2]; // 2= only server
};	