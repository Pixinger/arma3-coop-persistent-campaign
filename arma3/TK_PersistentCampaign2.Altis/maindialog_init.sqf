/*// Das Spawn ist nicht zwingend notwendig, aber verhindert dass die Initialisierung bockiert wird.
if (!isServer || !isDedicated) then
{
	[] spawn {
		waitUntil { player == player };
		Sleep 3;
		waituntil {!(IsNull (findDisplay 46))};

		private["_tmp"];
		//_tmp = (findDisplay 46) displayaddEventHandler ["KeyDown", "player globalChat format['key: %1',_this select 1];"];
		// 20=T, 22=U, 86=<, 24=O, 21=Z, 220=rwin, 221=rapp, 37=K, 15=TAB, 57=SPACE 
		_tmp = (findDisplay 46) displayaddEventHandler ["KeyDown", "if (!dialog ) then { if ((_this select 1 == 220) || (_this select 1 == 86)) then { _tmp = [] execVM 'maindialog_onhotkey.sqf';};};"];
		player sidechat "Dialogsystem fertig";
	};
};
*/