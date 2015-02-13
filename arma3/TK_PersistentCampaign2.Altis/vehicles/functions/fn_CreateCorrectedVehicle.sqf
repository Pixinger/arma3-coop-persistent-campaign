/* Dieses Skript arbeitet eigentlich genau wie createVehicle, nur werden noch alle Laderäume gelöscht */
private["_classname"];
_classname = _this select 0;
private["_position"];
_position = _this select 1;
private["_direction"];
_direction = _this select 2;

/* Fahrzeug erstellen */
private["_object"];
_object = _classname createVehicle (getPos SpawnDbVehicle);
waitUntil {!isNil "_object"};
_object allowDamage false;
_object setDir _direction;
Sleep 0.2;
_object setPosATL [_position select 0, _position select 1, 0];

_object;