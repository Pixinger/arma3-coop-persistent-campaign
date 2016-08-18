#include "..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

params ["_zoneIndex", "_mortarSite"];
_mortarSite params ["_position", "_direction"];

#ifdef MARKER_ENABLED
private _markerName = createMarkerLocal [format["markerMortarSite%1", floor(random 999999)], _position];
_markerName setMarkerShape "ICON";
_markerName setMarkerType "hd_ambush";
_markerName setMarkerDir _direction;
_markerName setMarkerSize [0.5, 0.5];
_markerName setMarkerText "c";
_markerName setMarkerColor "ColorOrange"; 
_markerName setMarkerAlpha 0.8;
#endif

// Mortar erstellen
private _mortar = createVehicle ["I_Mortar_01_F", _position, [], 0, "CAN_COLLIDE"];
_mortar setDir _direction;

// Sackwall
private _tmpPos = _mortar modelToWorld [2.5,0,0];
_tmpPos set [2, 0];
private _barrier1 = createVehicle ["Land_BagFence_01_round_green_F", _tmpPos, [], 0, "CAN_COLLIDE"];
_barrier1 setDir (_direction - 90);	 
_barrier1 setPos _tmpPos;

_tmpPos = _mortar modelToWorld [-2.5,0,0];
_tmpPos set [2, 0];
private _barrier2 = createVehicle ["Land_BagFence_01_round_green_F", _tmpPos, [], 0, "CAN_COLLIDE"];
_barrier2 setDir (_direction + 90);
_barrier2 setPos _tmpPos;

private _tmpPos = _mortar modelToWorld [0,2.5,0];
_tmpPos set [2, 0];
private _barrier3 = createVehicle ["Land_BagFence_01_round_green_F", _tmpPos, [], 0, "CAN_COLLIDE"];
_barrier3 setDir (_direction + 180);	 
_barrier3 setPos _tmpPos;

_tmpPos = _mortar modelToWorld [0,-2.5,0];
_tmpPos set [2, 0];
private _barrier4 = createVehicle ["Land_BagFence_01_round_green_F", _tmpPos, [], 0, "CAN_COLLIDE"];
_barrier4 setDir (_direction);
_barrier4 setPos _tmpPos;

// AA erstellen
private _aaPosition = _position findEmptyPosition [5, 60, "I_static_AA_F"];
if (count _aaPosition != 0) then
{
	private _aa = createVehicle ["I_static_AA_F", _aaPosition, [], 0, "CAN_COLLIDE"];
	_aa setDir (random 360);
};

