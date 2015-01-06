private["_result"];
_result = false;

private["_building"]; 
_building = nearestBuilding player;
if ((_building distance player) < 10) && {((typeof _building) in pixTown_ConfigHomeClassnames)}) then 
{
	_result = true;
};

_result;