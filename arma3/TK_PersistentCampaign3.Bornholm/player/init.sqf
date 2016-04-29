call compile preprocessFileLineNumbers "player\admin\init.sqf";
call compile preprocessFileLineNumbers "player\barracks\init.sqf";

if (hasInterface) then
{
	[] spawn {
		waitUntil { !isNull player };
		waituntil {!(IsNull (findDisplay 46))};

		private["_tmp"];
		// 20=T, 22=U, 86=<, 24=O, 21=Z, 220=rwin, 221=rapp, 37=K, 15=TAB, 57=SPACE 
		//_tmp = (findDisplay 46) displayaddEventHandler ["KeyDown", "player globalChat format['key: %1',_this select 1];"];
		_tmp = (findDisplay 46) displayaddEventHandler ["KeyDown", "if (!dialog ) then { if ((_this select 1 == 86) || {(_this select 1 == 220)}) then { _tmp = [] spawn fnc_Player_OnKey;};};"];
		
		onMapSingleClick "player setPos _pos; true;";
	};
}; 