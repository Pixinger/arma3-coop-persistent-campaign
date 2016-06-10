#include "CFG_BUILDABLES_INDICES.hpp"
diag_log format["BUILD_DPWONDKLSAND=%1", _this];

if (!isNil "logisticBuild") exitWith { hint "Du schlimmer Schelm. Du denkst wohl so geht es schneller? hä?!"; logisticBuild = false;};
// -------------------------------------------------------
private _objectGlobal = _this select 0;
private _directionUpDown = _this select 1;
private _moveGlobalObjectDown = if (count _this > 2) then { _this select 2; } else { true; };

// -------------------------------------------------------
// _config übernehmen / laden
private _config = [];
if (count _this >  3) then { _config = _this select 3; }
else 
{
	private _configIndex = logisticBuildables find (typeof(_objectGlobal));
	if (_configIndex != -1) exitWith {_config = logisticBuildableConfigs select _configIndex;};
};
if (count _config == 0) exitWith 
{ 
	hint "Dieses Objekt kann nicht verändert werden.";
};
// -------------------------------------------------------

private _positionGlobal = getPosATL _objectGlobal;
private _buildSpeed = _config select BUILDSPEED_INDEX;
private _classname = typeof _objectGlobal;

private _actionMenu = player addAction [("<t color=""#dddd00"">Bauen abschliessen</t>"), { logisticBuild = false; }, nil, 5, true, true];
		
private _autoStop = false;
if (_directionUpDown > 0) then
{
	if (_positionGlobal select 2 < -0.5) then {_autoStop = true;};	
}
else
{
	if (_positionGlobal select 2 > 0.5) then {_autoStop = true;};	
};

// Globales Objekt nach unten setzen, damit es nicht mehr im Weg ist.
if (_moveGlobalObjectDown) then
{
	private _detachOffset = (_config select DETACHOFFSET_INDEX); 
	private _heightATL = (getPosATL player) select 2;
	if ((_heightATL < 1) && (_heightATL > -1)) then { _heightATL = 0; }; 

	private _positionGlobalLowered = _objectGlobal modelToWorld _detachOffset;
	_positionGlobalLowered set [2, (_heightATL + (_detachOffset select 2))];
	
	_objectGlobal setPosATL _positionGlobalLowered;
};

// Lokales Objekt erzeugen
private _objectLocal = _classname createVehicleLocal _positionGlobal;
waitUntil {!isNil "_objectLocal"};
_objectLocal setPosATL _positionGlobal;
_objectLocal setDir (getDir _objectGlobal);

// Animation starten
call fnc_Logistic_WorkAnimationStart;

// Lokales Objekt verändern (hoch oder runter)
#define SLEEP_TIME 2
logisticBuild = true;
private _positionLocal = getPosATL _objectLocal;
while {(logisticBuild) && (alive player) } do
{
	_positionLocal = getPosATL _objectLocal;
	_positionLocal = [_positionLocal select 0, _positionLocal select 1, (_positionLocal select 2) + ((_buildSpeed / (60/SLEEP_TIME)) * _directionUpDown)];
	if (_autoStop) then
	{
		if (_directionUpDown > 0) then
		{
			if (_positionLocal select 2 > 0) then
			{
				logisticBuild = false;
				_positionLocal set [2, 0];
			};	
		}
		else
		{
			if (_positionLocal select 2 < 0) then
			{
				logisticBuild = false;
				_positionLocal set [2, 0];
			};	
		};
	};
	player sidechat format["height: %1", _positionLocal select 2];
	_objectLocal setPosATL _positionLocal;

	// Erst am Ende Warten, sonst wird bei Abbruch noch einmal zuviel ausgebaut.
	if (pixDebug) then { Sleep 0.5; } else { Sleep SLEEP_TIME; };
};
call fnc_Logistic_WorkAnimationEnd;

// Lokales Objekt löschen
deleteVehicle _objectLocal;

// Globales Objekt auf richtige Position schieben
_objectGlobal setPosATL _positionLocal;

player removeAction _actionMenu;
logisticBuild = nil;