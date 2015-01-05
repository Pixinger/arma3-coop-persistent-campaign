private["_button"]; 
_button = ["Fzg.speichern", false, false,"mainmenu\scripts\adminVehiclesSaveAction.sqf"];

if ((getPlayerUID player) in adminPlayerUIDs) then 
{ 
	_button set [1, true];
	_button set [2, true];
};

_button;
