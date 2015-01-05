private["_button"]; 
_button = ["Fzg.entfernen", false, false,"mainmenu\scripts\adminVehiclesRemoveAction.sqf"];

if ((getPlayerUID player) in adminPlayerUIDs) then 
{ 
	_button set [1, true];
	_button set [2, true];
};

_button;
