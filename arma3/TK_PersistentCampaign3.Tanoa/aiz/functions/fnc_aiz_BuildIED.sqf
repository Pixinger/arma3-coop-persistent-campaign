#include "..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

/*
params ["_zoneIndex", "_iedSite"];
_iedSite params ["_iedPosition"];

#ifdef MARKER_ENABLED
private _markerName = createMarkerLocal [format["markerIEDSite%1", floor(random 999999)], _iedPosition];
_markerName setMarkerShape "ICON";
_markerName setMarkerType "hd_ambush";
_markerName setMarkerDir _direction;
_markerName setMarkerSize [0.4, 0.4];
_markerName setMarkerText "IED";
_markerName setMarkerColor "ColorOrange"; 
_markerName setMarkerAlpha 0.8;
#endif

private _iedClassname = cfgAizIEDClassnames call PIX_fnc_RandomElement;

// IED erstellen
private _IED = createVehicle [_iedClassname, _iedPosition, [], 0, "CAN_COLLIDE"];
_IED setDir (random 360);
*/