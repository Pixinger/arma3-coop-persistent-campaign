#include "..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

params ["_zoneIndex", "_mineField"];
_mineField params ["_position", "_radiusX", "_radiusY", "_direction"];

#ifdef MARKER_ENABLED
private _markerName = createMarkerLocal [format["markerMineField%1", floor(random 999999)], _position];
_markerName setMarkerShape "RECTANGLE";
_markerName setMarkerType "hd_ambush";
_markerName setMarkerDir _direction;
_markerName setMarkerSize [_radiusX, _radiusY];
_markerName setMarkerText "MineField";
_markerName setMarkerColor "ColorOrange"; 
_markerName setMarkerAlpha 0.5;
#endif

private _iedClassname = cfgAizIEDClassnames call PIX_fnc_RandomElement;

// IED erstellen
private _IED = createVehicle [_iedClassname, _iedPosition, [], 0, "CAN_COLLIDE"];
_IED setDir (random 360);