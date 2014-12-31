private["_button"]; 
_button = ["GPS", false, false,"dialog\scripts\adminGpsAction.sqf"];

if ((getPlayerUID player) in adminPlayerUIDs) then 
{ 
	_button set [1, true];
	_button set [2, true];
};

_button;
