//[5] call fnc_aiz_ZoneInit;

if (isServer) then
{
	// ------------------------------------------------------------------------------
	// Datenbank laden
	private _database = [] call fnc_aiz_DatabaseLoad;
	
	// ------------------------------------------------------------------------------
	// Zonen initialisieren
	for "_i" from 0 to aizZoneCount-1 do 
	{
		aizZoneActive pushBack 0;
		if (_i != 12) then 
		{
			private _dataSet = if (count _database > _i) then { _database select _i } else { [] };
			[_i, _dataSet] call fnc_aiz_ZoneInit;
		};
	};

	// ------------------------------------------------------------------------------
	// Beendigung signalisieren
	aizZoneInitCompleted = true;
};
