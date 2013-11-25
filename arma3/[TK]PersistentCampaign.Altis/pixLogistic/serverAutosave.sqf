if (isServer) then
{
	/* -------------------------------------*/
	/* Schleife zum automatischen speichern */
	/* -------------------------------------*/
	player sidechat "pixLogistic: Autosave enabled";
	while { true } do
	{
		Sleep 580; /* knapp 10 Minuten um eine gewisse asynchronität zu erhalten. */
		_script = [] execVM "pixLogistic\serverSaveAllItems.sqf";
		waitUntil {scriptDone _script};
	};
};