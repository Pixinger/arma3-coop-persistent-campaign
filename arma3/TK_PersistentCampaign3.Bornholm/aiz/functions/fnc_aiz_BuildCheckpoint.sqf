private _zoneIndex = _this select 0;
private _checkpoint = _this select 1;

_checkpoint params ["_position", "_direction"];


private _markerName = createMarkerLocal [format["markercheckpoint%1", floor(random 999999)], _position];
_markerName setMarkerShape "ICON";
_markerName setMarkerType "hd_ambush";
_markerName setMarkerDir _direction;
_markerName setMarkerSize [0.5, 0.5];
_markerName setMarkerText "c";
_markerName setMarkerColor "ColorGreen"; 
_markerName setMarkerAlpha 0.8;


// Als erstes die Schranke erstellen, da sich alles um diese Schranke dreht. 
private _bargate1 = createVehicle ["Land_CncBarrier_F", _position, [], 0, "NONE"];
Sleep .2;
_bargate1 setDir _direction;	 
_bargate1 setPos _position;

private _tmpPos = _bargate1 modelToWorld [3,0,0];
_tmpPos set [2, 0];
private _bargate2 = createVehicle ["Land_CncBarrier_F", _tmpPos, [], 0, "NONE"];
Sleep .2;
_bargate2 setDir _direction;	 
_bargate2 setPos _tmpPos;

_tmpPos = _bargate1 modelToWorld [-3,0,0];
_tmpPos set [2, 0];
private _bargate3 = createVehicle ["Land_CncBarrier_F", _tmpPos, [], 0, "NONE"];
Sleep .2;
_bargate3 setDir _direction;	 
_bargate3 setPos _tmpPos;

// MG1 erstellen
_tmpPos = _bargate1 modelToWorld [0,6,0];
_tmpPos set [2, 0];
private _mg1 = createVehicle ["I_HMG_01_high_F", _tmpPos, [], 0, "CAN_COLLIDE"];
Sleep .2;
_mg1 setDir (_direction-180);

// MG2 erstellen
_tmpPos = _bargate1 modelToWorld [0,-6,0],;
_tmpPos set [2, 0];
private _mg2 = createVehicle ["I_HMG_01_high_F", _tmpPos, [], 0, "CAN_COLLIDE"];
Sleep .2;
_mg2 setDir (_direction-180);

Sleep 2;