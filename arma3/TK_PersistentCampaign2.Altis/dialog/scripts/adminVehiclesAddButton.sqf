private["_button"]; 
_button = ["Fzg.hinzufügen", false, false,"dialog\scripts\adminVehiclesAddAction.sqf"];

if ((getPlayerUID player) in adminPlayerUIDs) then 
{ 
	_button set [1, true];
	_button set [2, true];
};

_button;
