private["_cursorTarget"];
_cursorTarget = cursorTarget;
private["_cursorTargetType"];
_cursorTargetType = typeof _cursorTarget;

private _sellableIndex = logisticSellables find _cursorTargetType;
if (_sellableIndex >= 0) then 
{
	// Sellable Config lesen
	private _sellableConfig = (logisticSellablesConfigs select _sellableIndex);
	_sellableConfig params ["_storeClassnames", "_paymentClassnames"];
	
	private _stores = nearestObjects [_cursorTarget, _storeClassnames, 20];
	if (count _stores > 0) then 
	{
		private _store = _stores select 0;
		
		// Fahrzeug löschen
		deleteVehicle _cursorTarget;
		
		{
			// Freien Platz suchen
			private _position = [(getPos player), _x] call PIX_fnc_FindEmptyPositionClosest;
			
			// Bezahlung erstellen
			[_x, _position, random 360] call fnc_logisticDb_CreateVehicleCorrected;		
		} foreach _paymentClassnames;	
	}
	else
	{
		hint "Kein Abnehmer in der Nähe!";
	};
};
	

	