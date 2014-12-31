private["_button"]; 
_button = ["Fahrzeuge speichern", false, false,"dialog\scripts\adminVehiclesSaveAction.sqf"];

if ((getPlayerUID player) in adminPlayerUIDs) then 
{ 
	_button set [1, true];
	_button set [1, true];
};

_button;
