/*if (isServer && !isDedicated) then
{
	call fnc_aiz_DatabaseClear;
}
else
{
	remoteExec ["fnc_aiz_DatabaseClear", 2];
};*/



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
[[], "fnc_aiz_DatabaseClear", false] call BIS_fnc_MP;
