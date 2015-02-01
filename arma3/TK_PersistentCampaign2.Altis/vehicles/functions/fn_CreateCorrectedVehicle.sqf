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

//AGM_IR_Strobe_Item
//AGM_CableTie

// added in 0.93
//AGM_Clacker
//AGM_DefusalKit

// added in 0.94
//AGM_M26_Clacker
//AGM_DeadManSwitch
// added in 0.93
//AGM_HandFlare_Green
//AGM_HandFlare_Red
//AGM_HandFlare_White
//AGM_HandFlare_Yellow

// added in 0.94
//AGM_M84

//AGM_UAVBattery

// added in 0.93
//AGM_JerryCan
//AGM_SpareTrack
//AGM_SpareWheel

// added in 0.94
//AGM_SandbagBarrier_Crate
//AGM_RazorWire_Crate