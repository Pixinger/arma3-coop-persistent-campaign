private _zoneIndex = _this select 0;
private _checkpoint = _this select 1;

_checkpoint params ["_position", "_direction"];


private "_markerName";
_markerName = createMarkerLocal [format["markercheckpoint%1", random 999999], _position];
_markerName setMarkerShapeLocal "ICON";
_markerName setMarkerTypeLocal "o_inf";
_markerName setMarkerDirLocal _direction;
_markerName setMarkerSizeLocal [0.5, 0.5];
_markerName setMarkerTextLocal "c";
_markerName setMarkerColorLocal "ColorGreen"; 
_markerName setMarkerAlphaLocal 0.8;