if (isServer) then
{	
	diag_log "LOGISTIC-Database clearing";

	// ------------------------------------------------------------------------------
	// Vorbereiten
	waitUntil { logisticDbInitCompleted };
	waitUntil { !logisticDbSaving };
	logisticDbSaving = true;
	
	// ------------------------------------------------------------------------------
	// Datenbank speichern
	profileNameSpace setVariable [logisticDbPrefix + "_database", nil];
	diag_log "LOGISTIC-Database cleared";	

	// ------------------------------------------------------------------------------
	// Bestätigung ausgeben
	"LOGISTIC-Database cleared" remoteExec ["hint"];

	// ------------------------------------------------------------------------------
	// Nachbereiten
	logisticDbSaving = false;
};
