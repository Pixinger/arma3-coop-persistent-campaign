if (isServer) then
{
	waitUntil { !pixlogisticDbMutex };
	pixlogisticDbMutex = true;

	/*-------------------------------*/
	/* Funktionen compilieren (DATA) */
	/*-------------------------------*/
	private["_fn_pixLogistic_DataBeginLoad"];
	_fn_pixLogistic_DataBeginLoad = compile preprocessFileLineNumbers "pixLogistic\fn_pixLogistic_DataBeginLoad.sqf";
	private["_fn_pixLogistic_DataReadNext"];
	_fn_pixLogistic_DataReadNext = compile preprocessFileLineNumbers "pixLogistic\fn_pixLogistic_DataReadNext.sqf";
	private["_fn_pixLogistic_DataIsThreadFinished"];
	_fn_pixLogistic_DataIsThreadFinished = compile preprocessFileLineNumbers "pixLogistic\fn_pixLogistic_DataIsThreadFinished.sqf";

	private["_result"];
	_result = [] call _fn_pixLogistic_DataBeginLoad;
	if (_result == "OK") then
	{
		_result = call _fn_pixLogistic_DataIsThreadFinished;
		while { _result == "INPROGRESS" } do {	Sleep 0.5; _result = call _fn_pixLogistic_DataIsThreadFinished; };
		if (_result == "OK") then
		{	
			_result = [] call _fn_pixLogistic_DataReadNext;
			while { (_result != "EOF" ) } do 
			{
				call compile _result;
				_result = [] call _fn_pixLogistic_DataReadNext;
			};

			publicVariable "pvPixLogisticMoney";
			publicVariable "pvPixLogisticTeamLeaderUIDs";
			publicVariable "pvPixLogisticAdminUIDs";
			publicVariable "pixlogisticRewardForZone";
			publicVariable "pixlogisticRewardForExistingZone";			
			if (!isNil "pixLogisticRespawnPos") then
			{
				"respawn_west" setMarkerPos pixLogisticRespawnPos;
				pixLogisticRespawnPos = nil;
			};			
		}
		else
		{
			diag_log format["ERROR: fn_pixLogistic_DataBeginLoad=>fn_pixLogistic_DataIsThreadFinished failed: %1", _result];
			player globalChat format["ERROR: fn_pixLogistic_DataBeginLoad=>fn_pixLogistic_DataIsThreadFinished failed: %1", _result];
		};
	}
	else
	{
		diag_log format["ERROR: fn_pixLogistic_DataBeginLoad failed: %1", _result];
		player globalChat format["ERROR: fn_pixLogistic_DataBeginLoad failed: %1", _result];
	};
	 


	/*-------------------------------*/
	/* Funktionen compilieren (ITEM) */
	/*-------------------------------*/
	private["_fn_pixLogistic_ItemIsThreadFinished"];
	_fn_pixLogistic_ItemIsThreadFinished = compile preprocessFileLineNumbers "pixLogistic\fn_pixLogistic_ItemIsThreadFinished.sqf";
	private["_fn_pixLogistic_ItemBeginLoad"];
	_fn_pixLogistic_ItemBeginLoad = compile preprocessFileLineNumbers "pixLogistic\fn_pixLogistic_ItemBeginLoad.sqf";
	private["_fn_pixLogistic_ItemReadNext"];
	_fn_pixLogistic_ItemReadNext = compile preprocessFileLineNumbers "pixLogistic\fn_pixLogistic_ItemReadNext.sqf";
	
	_result = [] call _fn_pixLogistic_ItemBeginLoad;
	if (_result == "OK") then
	{
		_result = call _fn_pixLogistic_ItemIsThreadFinished;
		while { _result == "INPROGRESS" } do {	Sleep 0.5; _result = call _fn_pixLogistic_ItemIsThreadFinished; };
		if (_result == "OK") then
		{	
			_result = [] call _fn_pixLogistic_ItemReadNext;
			while  { _result != "EOF" } do
			{
				/*---------------------------*/
				/* String in Array umwandeln */
				/*---------------------------*/
				_result = call compile _result;

				/*------------*/
				/* Aufdröseln */
				/*------------*/
				private["_classname"];
				_classname = _result select 0;
				private["_content"];
				_content = _result select 1;
				private["_pos"];
				_pos = _result select 2;
				private["_dir"];
				_dir = _result select 3;
				private["_damage"];
				_damage = _result select 4;
				
				private["_ignore"];
				_ignore = false;
				if (_damage > 0.9) then
				{
					if (_classname in pixLogisticDeleteDamagedItems) then
					{
						_ignore = true;
					};
				};
				
				
				if (!_ignore) then
				{
					/*------------------*/
					/* Vehicle erzeugen */
					/*------------------*/
					private["_item"];
					_item = [_classname, _pos] call fn_pixLogistic_CreateCorrectedVehicle; /* Kapselt z.B. Änderungen an der Ladung */
					
					/*----------------*/
					/* Details setzen */
					/*----------------*/
					_item setDir _dir;
					_item setPosATL [_pos select 0, _pos select 1, 0];
					_item setVariable ["pixLogisticContent", _content, true]; 
					if (_damage >= 0.9) then
					{
						_item enableSimulation false;
						_item setdamage 1; 
						_item setdamage 1; 
						_item setdamage 0.9;
						_item setdamage 0.9;
						_item setdamage 0.9;
						_item setdamage 0.9;
						_item allowDamage false;
					}
					else
					{
						_item setDamage _damage;
					};
					
					/*if ((_classname in pixlogisticBuildings) || (_classname in pixlogisticBuildingsService) || (_classname in pixlogisticBuildingsBarracks) || (_classname in pixlogisticHQs)) then
					{
						_item setVariable ["pixLogisticControlled", true, true];
					};*/
						
					/*------------------------------------*/
					/* In die Überwachungsliste aufnehmen */
					/*------------------------------------*/
					pixlogisticDbItems = pixlogisticDbItems + [_item];	
				};
			
				/*-------------------------*/
				/* Nächstes Datenset laden */
				/*-------------------------*/
				_result = [] call _fn_pixLogistic_ItemReadNext;
			}
		}
		else
		{
			diag_log format["ERROR: _fn_pixLogistic_ItemBeginLoad=>_fn_pixLogistic_ItemIsThreadFinished failed: %1", _result];
			player globalChat format["ERROR: _fn_pixLogistic_ItemBeginLoad=>_fn_pixLogistic_ItemIsThreadFinished failed: %1", _result];
		};
	}
	else
	{
		diag_log format["ERROR: _fn_pixLogistic_ItemBeginLoad failed: %1", _result];
		player globalChat format["ERROR: _fn_pixLogistic_ItemBeginLoad failed: %1", _result];
	};
	 
	pixlogisticDbMutex = false;
};