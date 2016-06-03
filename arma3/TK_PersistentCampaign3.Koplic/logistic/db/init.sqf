if (isServer) then  
{
	// ------------------------------------------------------------------------------
	// Datenbank laden
	call fnc_logisticDb_LoadServer;

	// ------------------------------------------------------------------------------
	// Beendigung signalisieren
	logisticDbInitCompleted = true;
	publicVariable "logisticDbInitCompleted";
};
