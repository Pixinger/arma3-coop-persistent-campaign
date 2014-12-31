call compile preprocessFileLineNumbers "dialog\config.sqf";

// Das Spawn ist nicht zwingend notwendig, aber verhindert dass die Initialisierung bockiert wird.
[] spawn {
	if (!isServer || !isDedicated) then
	{
		Sleep 2;
		// 20=T, 22=U, 86=<, 24=O, 21=Z, 220=rwin, 221=rapp, 37=K, 15=TAB, 57=SPACE 
		waituntil {!(IsNull (findDisplay 46))};
		private["_tmp"];
		//_tmp = (findDisplay 46) displayaddEventHandler ["KeyDown", "player globalChat format['key: %1',_this select 1];"];
		pixDialogActionKeyPressed = false;
		//_tmp = (findDisplay 46) displayaddEventHandler ["KeyDown", "if ((!pixDialogActionKeyPressed ) && (_this select 1 == 15)) then { pixDialogActionKeyPressed  = true; _tmp = [] execVM 'dialog\show.sqf';}"];
		_tmp = (findDisplay 46) displayaddEventHandler ["KeyDown", "if (!dialog ) then { if ((_this select 1 == 220) || (_this select 1 == 86)) then { _tmp = [] execVM 'dialog\show.sqf';};};"];
	};
};