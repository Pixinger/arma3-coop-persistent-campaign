call compile preprocessFileLineNumbers "player\admin\init.sqf";

if (hasInterface) then
{
	cutText ["Initialization... 1", "BLACK FADED",1];

	[] spawn {
		cutText ["Initialization... 2", "BLACK FADED",1];
		waitUntil { !isNull player };
		waituntil {!(IsNull (findDisplay 46))};
		waitUntil { logisticInitialized }; // Warten bis die Logistic auch auf dem Server fertig ist.		
		cutText ["Initialization...3", "BLACK FADED",1];

		if (pixDebug) then
		{
			player allowDamage false;
			//player setCaptive true;
		};
		
		player setVariable ["isPioneer", true];

		private["_tmp"];
		// 20=T, 22=U, P=25, 86=<, 24=O, 21=Z, 220=rwin, 221=rapp, 37=K, 15=TAB, 57=SPACE 
		//_tmp = (findDisplay 46) displayaddEventHandler ["KeyDown", "player globalChat format['key: %1',_this select 1];"];
		//_tmp = (findDisplay 46) displayaddEventHandler ["KeyDown", "if (!dialog ) then { if ((_this select 1 == 86) || {(_this select 1 == 220)}) then { _tmp = [] spawn fnc_Player_OnKey;};};"];
		_tmp = (findDisplay 46) displayaddEventHandler ["KeyDown", "if (!dialog ) then { if (_this select 1 == 22) then { _tmp = [] spawn fnc_Player_OnKey;};};"];
		cutText ["Initialization...4", "BLACK FADED",1];
		
		if (call fnc_admin_IsPlayerAdmin) then
		{
			onMapSingleClick "player setPos _pos; true;";
		};

		cutText ["Initialization...\nsearching HQ", "BLACK FADED",1];
		private _hqs = call fnc_Logistic_HQFind;
		if (count _hqs > 0) then
		{
			private _position = (getPos (_hqs select 0)) findEmptyPosition [3,10, "SoldierWB"];		
			player setPos _position;
			hint "HQ gefunden.";
		}
		else
		{
			hint "Kein HQ gefunden.";
		};
		cutText ["", "BLACK IN",1];
	};
}; 