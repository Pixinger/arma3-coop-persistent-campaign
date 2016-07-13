if (isServer) then
{
	// ------------------------------------------------------------------------------
	// Datenbank laden
	private _database = [] call fnc_town_DatabaseLoad;
	
	// ------------------------------------------------------------------------------
	// Towns initialisieren
	for "_i" from 0 to townTownCount-1 do 
	{
		townActive pushBack 0; // 0 entspricht inaktiv, alle anderen zahlen entsprechen aktiv!
		townInfos pushBack []; // Wird von "fnc_town_TownInit" gefüllt.
		private _dataSet = if (count _database > _i) then { _database select _i } else { [] };
		[_i, _dataSet] call fnc_town_TownInit;
	};
	
	// ------------------------------------------------------------------------------
	// Perma-Loop starten (überwacht alle Städte zusammen).
	[] call fnc_town_TownLoop;

	// ------------------------------------------------------------------------------
	// Beendigung signalisieren
	townInitCompleted = true;
};

if (hasInterface) then
{
	//waitUntil { !(isNil "townInitCompleted") };
};