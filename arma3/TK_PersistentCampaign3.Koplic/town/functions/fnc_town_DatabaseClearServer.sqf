if (isServer) then
{	
	// ------------------------------------------------------------------------------
	// Vorbereiten
	waitUntil { townInitCompleted };
	waitUntil { !townDatabaseSaving };
	townDatabaseSaving = true;

	// ------------------------------------------------------------------------------
	// Datenbank speichern
	profileNameSpace setVariable [townDbPrefix + "_database", nil];
	diag_log "TOWN-Database cleared";	

	// ------------------------------------------------------------------------------
	// Bestätigung ausgeben
	"TOWN-Database cleared" remoteExec ["hint"];

	// ------------------------------------------------------------------------------
	// Nachbereiten
	townDatabaseSaving = false;
};
