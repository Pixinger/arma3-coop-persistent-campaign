private["_button"]; 
_button = ["Fahrzeug hinzufügen", false, false,"dialog\scripts\adminVehiclesAddAction.sqf"];

if ((getPlayerUID player) in adminPlayerUIDs) then 
{ 
	_button set [1, true];
	_button set [1, true];
};

_button;
