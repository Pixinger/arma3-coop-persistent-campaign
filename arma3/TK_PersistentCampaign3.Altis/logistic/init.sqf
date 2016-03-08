if (hasInterface) then
{
	[] spawn {
		waitUntil { !isNull player };
		waituntil {!(IsNull (findDisplay 46))};

		private["_tmp"];
		// 20=T, 22=U, 86=<, 24=O, 21=Z, 220=rwin, 221=rapp, 37=K, 15=TAB, 57=SPACE 
		//_tmp = (findDisplay 46) displayaddEventHandler ["KeyDown", "player globalChat format['key: %1',_this select 1];"];
		_tmp = (findDisplay 46) displayaddEventHandler ["KeyDown", "if (!dialog ) then { if (_this select 1 == 22) then { _tmp = [] spawn fnc_Logistic_OnKey;};};"];

		// Marker für die Stores zeichnen
		{
			private["_markerName"];
			_markerName = createMarkerLocal [format["MarkerLogisticStore%1", _forEachIndex], _x select 0];
			_markerName setMarkerShapeLocal "ICON";
			_markerName setMarkerTypeLocal "o_inf";
			_markerName setMarkerSizeLocal [0.2, 0.2];
			_markerName setMarkerTextLocal (_x select 1);
		} foreach logisticStores;
	};
}; 