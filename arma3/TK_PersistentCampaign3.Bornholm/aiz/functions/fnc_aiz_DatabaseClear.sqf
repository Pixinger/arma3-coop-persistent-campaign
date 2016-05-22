if (isServer) then
{	
	waitUntil { aizZoneInitCompleted };
	waitUntil { !aizZonesSaving };
	aizZonesSaving = true;

	// ------------------------------------------------------------------------------
	// Datenbank speichern
	profileNameSpace setVariable [aizDbPrefix + "_database", []];
	diag_log "AIZ-Database cleared";	

	aizZonesSaving = false;
};
