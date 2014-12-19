private["_button"];
_button = ["Gebäude durchsuchen", false, true,"dialog\scripts\searchBuildingAction.sqf"];

private["_building"]; 
_building = nearestBuilding player;
if ((_building distance player) < 10) then 
{
	_button set [1, true];
};


_button;

