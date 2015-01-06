private["_result"];
_result = false;

//private["_building"]; 
//_building = nearestBuilding player;
//if ((_building distance player) < 10) then

private["_buildings"];
_buildings = nearestObjects[player, pixTown_ConfigHomeClassnames, 10];
if (count _buildings > 0) then
{
	_result = true;
};

_result;