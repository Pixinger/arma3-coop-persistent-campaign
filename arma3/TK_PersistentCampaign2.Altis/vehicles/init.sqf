call compile preprocessFileLineNumbers "vehicles\config.sqf";
call compile preprocessFileLineNumbers "vehicles\functions\_compile.sqf";

// if (isServer) then
//if ((!hasInterface) || ((!HeadlessClientAvailable) && (isServer))) then 
if (ExecuteHeadlessCode) then
{
	vehiclesInitialized = false;
	publicVariable "vehiclesInitialized";
	
	vehiclesDbItems = []; /* Überwachte Items */

	private["_index"];
	_index = 0;
	
	private["_dbResult"];	
	_dbResult = "Arma2NET" callExtension format["PC vehicle|read|%1", _index];
	while { ("Arma2NET" callExtension format["PC isok|%1", _dbResult] == "OK") } do
	{	
		// String in Array umwandeln 
		_dbResult = call compile _dbResult;

		// Aufdröseln 
		private["_classname"];
		_classname = _dbResult select 0;
		private["_pos"];
		_pos = _dbResult select 1;
		private["_dir"];
		_dir = _dbResult select 2;
		private["_damage"];
		_damage = _dbResult select 3;
		private["_content"];
		_content = _dbResult select 4;
		
		// Ignorieren?
		private["_ignore"];
		_ignore = false;
		if (_damage > 0.9) then
		{
			if (_classname in vehiclesDeleteDamagedItems) then
			{
				_ignore = true;
			};
		};		
		
		if (!_ignore) then
		{
			// Vehicle erzeugen
			private["_item"];
			_item = [_classname, _pos] call fnc_Vehicle_CreateCorrected; // Kapselt z.B. Änderungen an der Ladung
			
			// Details setzen
			_item setDir _dir;
			_item setPosATL [_pos select 0, _pos select 1, 0];
			//_item setVariable ["content", _content, true]; 
			if (_damage >= 0.9) then
			{
				_item enableSimulationGlobal false;
				_item setdamage 1; 
				_item setdamage 0.9;
				_item allowDamage false;
			}
			else
			{
				_item setDamage _damage;
			};
			
			/*------------------------------------*/
			/* In die Üerwachungsliste aufnehmen */
			/*------------------------------------*/
			vehiclesDbItems pushBack _item;	
			diag_log format["Vehicle loaded from DB: %1", _classname];
		};
			
		// Nächstes Datenset laden 
		_index = _index + 1;
		_dbResult = "Arma2NET" callExtension format["PC vehicle|read|%1", _index];
	};	
	
	vehiclesInitialized = true;
	publicVariable "vehiclesInitialized";
};

// if (!isServer || !isDedicated) then
if (hasInterface) then
{
	player sidechat "Warte auf Fahrzeuge";
	waitUntil { !(isNil "vehiclesInitialized") };
	waitUntil { vehiclesInitialized };
};