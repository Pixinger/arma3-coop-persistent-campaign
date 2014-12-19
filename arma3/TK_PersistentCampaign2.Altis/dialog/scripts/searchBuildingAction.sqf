_building = nearestBuilding player; 
if ((_building distance player) < 10) then 
{
	player sidechat "Achtung! Wir durchsuchen jetzt das Gebäude!";
	
	// Param
	// Code/Function
	// Target
	//    Object - function will be executed only where unit is local [default: everyone] 
	//    Array - array of objects 
	//    Boolean - true to execute on each machine (including the one where the function was called from), false to execute it on server only 
	//    Number - function will be executed only on client with the given owner ID 
	//    Side - function will be executed only on clients where the player is on the specified side 
	//    Group - function will be executed only on clients where the player is in the specified group 
	// IsPersistent
	// IsCall 
	[_building, "PC_fnc_TownHome_SearchBuilding", false] call BIS_fnc_MP;
};