/* Dieses Skript arbeitet eigentlich genau wie createVehicle, nur werden noch alle Laderäume gelöscht */
private["_classname"];
_classname = _this select 0;
private["_position"];
_position = _this select 1;

/* Fahrzeug erstellen */
private["_object"];
_object = _classname createVehicle _position;
waitUntil {!isNil "_object"};

_object;