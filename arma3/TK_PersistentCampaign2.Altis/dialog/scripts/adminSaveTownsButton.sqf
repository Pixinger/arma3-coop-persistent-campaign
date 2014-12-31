private["_button"]; 
_button = ["Städte speichern", false, false,"dialog\scripts\adminSaveTownsAction.sqf"];

if ((getPlayerUID player) in adminPlayerUIDs) then 
{ 
	_button set [1, true];
	_button set [2, true];
};

_button;
