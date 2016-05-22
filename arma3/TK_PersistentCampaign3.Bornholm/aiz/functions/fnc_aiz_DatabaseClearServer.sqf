if (isServer) then
{	
	// ------------------------------------------------------------------------------
	// Vorbereiten
	waitUntil { aizZoneInitCompleted };
	waitUntil { !aizZonesSaving };
	aizZonesSaving = true;

	// ------------------------------------------------------------------------------
	// Datenbank speichern
	profileNameSpace setVariable [aizDbPrefix + "_database", nil];
	diag_log "AIZ-Database cleared";	

	// ------------------------------------------------------------------------------
	// Bestätigung ausgeben
	if (isServer && !isDedicated) then
	{
		hint "AIZ-Database cleared";
	}
	else
	{
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
		["AIZ-Database cleared", "hint", false] call BIS_fnc_MP;
		
		//"AIZ-Database cleared" remoteExec ["hint", 0];
	};	

	// ------------------------------------------------------------------------------
	// Nachbereiten
	aizZonesSaving = false;
};
