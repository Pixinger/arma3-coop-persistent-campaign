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
if (!HeadlessClientAvailable) then {
	[[cursorTarget], "fnc_Vehicle_DbAdd", false] call BIS_fnc_MP;
} else {
	[[cursorTarget], "fnc_Vehicle_DbAdd", HeadlessUnit] call BIS_fnc_MP;
};
