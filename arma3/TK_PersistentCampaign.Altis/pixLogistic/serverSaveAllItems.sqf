if (isServer) then
{
	waitUntil { !pixlogisticDbMutex };
	pixlogisticDbMutex = true;

	/*-------------------------------*/
	/* Funktionen compilieren (DATA) */
	/*-------------------------------*/
	private["_fn_pixLogistic_DataBeginSave"];
	_fn_pixLogistic_DataBeginSave = compile preprocessFileLineNumbers "pixLogistic\fn_pixLogistic_DataBeginSave.sqf";
	private["_fn_pixLogistic_DataEndSave"];
	_fn_pixLogistic_DataEndSave = compile preprocessFileLineNumbers "pixLogistic\fn_pixLogistic_DataEndSave.sqf";
	private["_fn_pixLogistic_DataWriteNext"];
	_fn_pixLogistic_DataWriteNext = compile preprocessFileLineNumbers "pixLogistic\fn_pixLogistic_DataWriteNext.sqf";
	private["_fn_pixLogistic_DataIsThreadFinished"];
	_fn_pixLogistic_DataIsThreadFinished = compile preprocessFileLineNumbers "pixLogistic\fn_pixLogistic_DataIsThreadFinished.sqf";
	
	/*-----------------------*/
	/* Die Datei vorbereiten */
	/*-----------------------*/
	private["_result"];
	_result = [] call _fn_pixLogistic_DataBeginSave;
	if (_result == "OK") then
	{
		_result = [format["pvPixLogisticMoney = %1;", pvPixLogisticMoney]] call _fn_pixLogistic_DataWriteNext;
		if (_result != "OK") then
		{
			diag_log format["ERROR: _fn_pixLogistic_DataWriteNext=>pvPixLogisticMoney failed: %1", _result];
			player globalChat format["ERROR: _fn_pixLogistic_DataWriteNext=>pvPixLogisticMoney failed: %1", _result];
		};		
		_result = [format["pvPixLogisticTeamLeaderUIDs = %1;", pvPixLogisticTeamLeaderUIDs]] call _fn_pixLogistic_DataWriteNext;
		if (_result != "OK") then
		{
			diag_log format["ERROR: _fn_pixLogistic_DataWriteNext=>pvPixLogisticTeamLeaderUIDs failed: %1", _result];
			player globalChat format["ERROR: _fn_pixLogistic_DataWriteNext=>pvPixLogisticTeamLeaderUIDs failed: %1", _result];
		};		
		_result = [format["pvPixLogisticAdminUIDs = %1;", pvPixLogisticAdminUIDs]] call _fn_pixLogistic_DataWriteNext;
		if (_result != "OK") then
		{
			diag_log format["ERROR: _fn_pixLogistic_DataWriteNext=>pvPixLogisticAdminUIDs failed: %1", _result];
			player globalChat format["ERROR: _fn_pixLogistic_DataWriteNext=>pvPixLogisticAdminUIDs failed: %1", _result];
		};		
		_result = [format["pixlogisticRewardForZone = %1;", pixlogisticRewardForZone]] call _fn_pixLogistic_DataWriteNext;
		if (_result != "OK") then
		{
			diag_log format["ERROR: _fn_pixLogistic_DataWriteNext=>pixlogisticRewardForZone failed: %1", _result];
			player globalChat format["ERROR: _fn_pixLogistic_DataWriteNext=>pixlogisticRewardForZone failed: %1", _result];
		};		
		_result = [format["pixlogisticRewardForExistingZone = %1;", pixlogisticRewardForExistingZone]] call _fn_pixLogistic_DataWriteNext;
		if (_result != "OK") then
		{
			diag_log format["ERROR: _fn_pixLogistic_DataWriteNext=>pixlogisticRewardForExistingZone failed: %1", _result];
			player globalChat format["ERROR: _fn_pixLogistic_DataWriteNext=>pixlogisticRewardForExistingZone failed: %1", _result];
		};		
		_result = [format["pixLogisticRespawnPos = %1;", getMarkerPos "respawn_west"]] call _fn_pixLogistic_DataWriteNext;
		if (_result != "OK") then
		{
			diag_log format["ERROR: _fn_pixLogistic_DataWriteNext=>pixLogisticRespawnPos failed: %1", _result];
			player globalChat format["ERROR: _fn_pixLogistic_DataWriteNext=>pixLogisticRespawnPos failed: %1", _result];
		};		
		

		/*----------------------------------------------------*/
		/* Die Datei letzendlich auf die Festplatte schreiben */
		/*----------------------------------------------------*/
		_result = [] call _fn_pixLogistic_DataEndSave;
		if (_result == "OK") then
		{
			_result = call _fn_pixLogistic_DataIsThreadFinished;
			while { _result == "INPROGRESS" } do {	Sleep 0.5; _result = call _fn_pixLogistic_DataIsThreadFinished; };
			if (_result == "OK") then
			{	
				if (isServer && !isDedicated) then { player globalChat "INFO: pixLogisticData saved";}; /* ersatzmechanismus "publicVariable" */
			}
			else
			{
				diag_log format["ERROR: _fn_pixLogistic_DataEndSave=>_fn_pixLogistic_DataIsThreadFinished failed: %1", _result];
				player globalChat format["ERROR: _fn_pixLogistic_DataEndSave=>_fn_pixLogistic_DataIsThreadFinished failed: %1", _result];
			};
		}
		else
		{
			diag_log format["ERROR: _fn_pixLogistic_DataEndSave failed: %1", _result];
			player globalChat format["ERROR: _fn_pixLogistic_DataEndSave failed: %1", _result];
		};
	}
	else
	{
		diag_log format["ERROR: _fn_pixLogistic_DataBeginSave failed: %1", _result];
		player globalChat format["ERROR: _fn_pixLogistic_DataBeginSave failed: %1", _result];
	};

	
	
	
	
	
	
	/*-------------------------------*/
	/* Funktionen compilieren (ITEM) */
	/*-------------------------------*/
	private["_fn_pixLogistic_ItemBeginSave"];
	_fn_pixLogistic_ItemBeginSave = compile preprocessFileLineNumbers "pixLogistic\fn_pixLogistic_ItemBeginSave.sqf";
	private["_fn_pixLogistic_ItemEndSave"];
	_fn_pixLogistic_ItemEndSave = compile preprocessFileLineNumbers "pixLogistic\fn_pixLogistic_ItemEndSave.sqf";
	private["_fn_pixLogistic_ItemWriteNext"];
	_fn_pixLogistic_ItemWriteNext = compile preprocessFileLineNumbers "pixLogistic\fn_pixLogistic_ItemWriteNext.sqf";
	private["_fn_pixLogistic_ItemIsThreadFinished"];
	_fn_pixLogistic_ItemIsThreadFinished = compile preprocessFileLineNumbers "pixLogistic\fn_pixLogistic_ItemIsThreadFinished.sqf";
	
	/*-----------------------*/
	/* Die Datei vorbereiten */
	/*-----------------------*/
	private["_result"];
	_result = [] call _fn_pixLogistic_ItemBeginSave;
	if (_result == "OK") then
	{
		/*---------------------------------------------*/
		/* Die gesamte Überwachungsliste durcharbeiten */
		/*---------------------------------------------*/
		{
			/*-----------------------------*/
			/* Item-Details herausarbeiten */
			/*-----------------------------*/
			private["_classname"];
			_classname = typeof _x;
			private["_content"];
			_content = _x getVariable "pixLogisticContent";
			if (isNil "_content") then { _content = []; };
			if (str(_content) == "") then { _content = []; };
			private["_pos"];
			_pos = getPos _x;
			private["_dir"];
			_dir = getDir _x;
			private["_damage"];
			_damage = damage _x;

			/*--------------------------------*/
			/* Zu einem Array zusammenstellen */
			/*--------------------------------*/
			private["_array"];
			_array = [_classname, _content, _pos, _dir, _damage];
			
			/*----------------------*/
			/* An die Datei anfügen */
			/*----------------------*/
			_result = [format["%1", _array]] call _fn_pixLogistic_ItemWriteNext;
			if (_result != "OK") then
			{
				diag_log format["ERROR: _fn_pixLogistic_ItemWriteNext failed: %1", _result];
				player globalChat format["ERROR: _fn_pixLogistic_ItemWriteNext failed: %1", _result];
			};		
			
		} foreach pixlogisticDbItems;

		/*----------------------------------------------------*/
		/* Die Datei letzendlich auf die Festplatte schreiben */
		/*----------------------------------------------------*/
		_result = [] call _fn_pixLogistic_ItemEndSave;
		if (_result == "OK") then
		{
			_result = call _fn_pixLogistic_ItemIsThreadFinished;
			while { _result == "INPROGRESS" } do {	Sleep 0.5; _result = call _fn_pixLogistic_ItemIsThreadFinished; };
			if (_result == "OK") then
			{	
				pvehPixlogisticSaved = pvehPixlogisticSaved + 1;
				publicVariable "pvehPixlogisticSaved";			
				if (isServer && !isDedicated) then { player globalChat "INFO: pixLogisticItem saved";}; /* ersatzmechanismus "publicVariable" */
			}
			else
			{
				diag_log format["ERROR: _fn_pixLogistic_ItemEndSave=>_fn_pixLogistic_ItemIsThreadFinished failed: %1", _result];
				player globalChat format["ERROR: _fn_pixLogistic_ItemEndSave=>_fn_pixLogistic_ItemIsThreadFinished failed: %1", _result];
			};
		}
		else
		{
			diag_log format["ERROR: _fn_pixLogistic_ItemEndSave failed: %1", _result];
			player globalChat format["ERROR: _fn_pixLogistic_ItemEndSave failed: %1", _result];
		};
	}
	else
	{
		diag_log format["ERROR: _fn_pixLogistic_ItemBeginSave failed: %1", _result];
		player globalChat format["ERROR: _fn_pixLogistic_ItemBeginSave failed: %1", _result];
	};

	pixlogisticDbMutex = false;
};