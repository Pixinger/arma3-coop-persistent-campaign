if (isServer) then
{	
	// ------------------------------------------------------------------------------
	// Vorbereiten
	waitUntil { aizZoneInitCompleted };
	waitUntil { !aizZonesSaving };
	aizZonesSaving = true;

	// ------------------------------------------------------------------------------
	// Datenbank speichern
	profileNameSpace setVariable [cfgAizDbPrefix + "_database", nil];
	diag_log "AIZ-Database cleared";	

	// ------------------------------------------------------------------------------
	// Bestätigung ausgeben
	"AIZ-Database cleared" remoteExec ["hint"];

	// ------------------------------------------------------------------------------
	// Nachbereiten
	aizZonesSaving = false;
};
