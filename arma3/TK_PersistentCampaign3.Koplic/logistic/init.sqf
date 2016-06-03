call compile preprocessFileLineNumbers ("logistic\db\init.sqf");

if (hasInterface) then
{
	[] spawn {
		waitUntil { !isNull player };
		waituntil {!(IsNull (findDisplay 46))};

		private["_tmp"];
		// 20=T, 22=U, 86=<, 24=O, 21=Z, 220=rwin, 221=rapp, 37=K, 15=TAB, 57=SPACE 
		//_tmp = (findDisplay 46) displayaddEventHandler ["KeyDown", "player globalChat format['key: %1',_this select 1];"];
		_tmp = (findDisplay 46) displayaddEventHandler ["KeyDown", "if (!dialog ) then { if (_this select 1 == 22) then { _tmp = [] spawn fnc_Logistic_OnKey;};};"];

		private["_number"]; 
		_number = player createDiarySubject ["buildables", "Baupläne"];

		{				
				private["_config"];
				_config = logisticBuildableConfigs select _foreachIndex;  // [[0,5,2], 0, -3.5, 3, [["Land_Bricks_V2_F", 1]], [["Land_Bricks_V1_F", 1]] ]
				private["_displayname"];
				_displayname = "";
				if (_x == "CraterLong_small") then {_displayname = "Erdhaufen";} 
				else {_displayname = gettext(configFile >> "CfgVehicles" >> _x >> "displayName");};
				private["_text"];
				_text = format["%1<br/><br/>Benötigte Rohstoffe:<br/>", _displayname];
				{
					private["_subtext"];
					if ((_x select 0) == "CraterLong_small") then {_subtext = "Erdhaufen";} 
					else {_subtext = gettext(configFile >> "CfgVehicles" >> (_x select 0) >> "displayName");};
					_text = _text + format["- (%2%3) %1<br/>", _subtext, (_x select 1), "%"];
				} foreach (_config select 4);

			player createDiaryRecord ["buildables", [_displayname, _text]]; 
		} foreach logisticBuildables;
	};
}; 