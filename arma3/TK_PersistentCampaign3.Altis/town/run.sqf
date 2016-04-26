if (ExecuteHeadlessCode) then
{
	// -----------------------------------
	// "_this" auslesen
	// -----------------------------------
	private["_townObject"];
	_townObject = _this select 0;

	// -----------------------------------
	// "_townObject" auslesen
	// -----------------------------------
	_townObject enableSimulationGlobal false;
	hideObjectGlobal _townObject;

	private["_townCenter"];
	_townCenter = getPos _townObject;
	private["_townRadius"];
	_townRadius = _townObject getVariable "townRadius";
	private["_townName"];
	_townName = _townObject getVariable "townName";

	// -----------------------------------
	// Marker erstellen
	// -----------------------------------
	private["_townMarker"];
	_townMarker = createMarker[format["markerTown%1", _townName], _townCenter];
	_townMarker setMarkerShape "ELLIPSE";
	_townMarker setMarkerSize [_townRadius, _townRadius];
	_townMarker setMarkerAlpha 0.7;

	// ----------------------------------------------------------------------
	// Stadtparameter auslesen (aus der Datenbank)
	// ----------------------------------------------------------------------
	private["_townStockWater"];
	private["_townStockFood"];     
	private["_townMood"];
	private["_townCivCount"];
	private["_townRedCount"];
	private["_townWeaponCount"];
	_townStockWater = 0;
	_townStockFood = 0;
	_townMood = 0;
	_townCivCount = 100;
	_townRedCount = 100;
	_townWeaponCount = 0;

	// -----------------------------------
	// Townmarker erstellen
	// -----------------------------------
	if (_townRedCount / 10 > _townCivCount) then 
	{
		_townMarker setMarkerColor "ColorRed";
	}
	else
	{
		if (_townCivCount / 10 > _townRedCount) then 
		{
			_townMarker setMarkerColor "ColorGreen";
		}
		else
		{
			_townMarker setMarkerColor "ColorBlack";
		};
	};

	// -----------------------------------
	// IEDs erstellen
	// -----------------------------------
	//private["_result"];
	//_result = [_townCenter, _townRadius] execVM "ied\createTownIEDs.sqf";


	// Erst nach dem Briefing beginnen, alle Städte zu einer etwas anderen Zeit
	Sleep (0.1 + (random 5));


	// -----------------------------------
	// Dauerschleife beginnen
	// -----------------------------------
	private["_lastServerTime"];
	_lastServerTime = time;
	while { true } do 
	{
		// Schlafen legen ... 
		Sleep(10);
		
		// Prüfen ...
		while { ([_townCenter, 1000] call fnc_town_IsAnyPlayerNear) } do 
		{
			// schlafen legen
			Sleep(10);
		};
	};			
};