#include "..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

call compile preprocessFileLineNumbers "logistic\db\init.sqf";
call compile preprocessFileLineNumbers "logistic\gear\init.sqf";

if (isServer) then
{
	logisticInitialized = true;
	publicVariable "logisticInitialized";
	INFO_LOG("LOGISTIC init is now completed");
};

if (hasInterface) then
{	
	
	[] spawn {
		{
			private _objectLocal = _x createVehicleLocal [0,0,-100];
		} foreach logisticBuildables;	
	
		waitUntil { !isNull player };
		waituntil {!(IsNull (findDisplay 46))};
		waitUntil { logisticInitialized }; // Warten bis die Logistic auch auf dem Server fertig ist.		

		[player] call fnc_logisticGear_ApplyDefaultLoadOut;
			
		// 20=T, 22=U, P=25, 86=<, 24=O, 21=Z, 220=rwin, 221=rapp, 37=K, 15=TAB, 57=SPACE 
		//_tmp = (findDisplay 46) displayaddEventHandler ["KeyDown", "player globalChat format['key: %1',_this select 1];"];
		//_tmp = (findDisplay 46) displayaddEventHandler ["KeyDown", "if (!dialog ) then { if (_this select 1 == 22) then { _tmp = [] spawn fnc_Logistic_OnKey;};};"];
		private _tmp = (findDisplay 46) displayaddEventHandler ["KeyDown", "if (!dialog ) then { if ((_this select 1 == 86) || {(_this select 1 == 220)}) then { _tmp = [] spawn fnc_Logistic_OnKey;};};"];

		private _number = player createDiarySubject ["buildables", "Baupläne"];

		{				
				private _config = logisticBuildableConfigs select _foreachIndex;  // [[0,5,2], 0, -3.5, 3, [["Land_Bricks_V2_F", 1]], [["Land_Bricks_V1_F", 1]] ]
				private _displayname = if (_x == "CraterLong_small") then {"Erdhaufen";} else {gettext(configFile >> "CfgVehicles" >> _x >> "displayName");};
				private _text = format["%1<br/><br/>Benötigte Rohstoffe:<br/>", _displayname];
				{
					private _subtext = if ((_x select 0) == "CraterLong_small") then {"Erdhaufen";} else {gettext(configFile >> "CfgVehicles" >> (_x select 0) >> "displayName");};
					_text = _text + format["- (%2%3) %1<br/>", _subtext, (_x select 1), "%"];
				} foreach (_config select 4);

			player createDiaryRecord ["buildables", [_displayname, _text]]; 
		} foreach logisticBuildables;
	};
}; 