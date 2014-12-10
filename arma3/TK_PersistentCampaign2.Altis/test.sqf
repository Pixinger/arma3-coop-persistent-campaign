[civ1, civ2] doFSM ["civilian.fsm", getPos player, getPos player]



/*
//NameVillage NameTown NameCity
_array = "getText ( _x >> 'type') == 'NameVillage' " configClasses (configFile >> "CfgWorlds" >> "Altis" >> "Names");

for "_i" from 0 to ((count _array)-1) do 
{
	_myposition = getArray ((_array select _i) >> "Position");
	_myname = getText ((_array select _i) >> "Name");
	_myradiusa = getNumber ((_array select _i) >> "radiusA");
	_myradiusb = getNumber ((_array select _i) >> "radiusB");
	
	
	_markername = format["Marker_%1", _myname];
	_marker = createMarker [_markername, _myposition];
	_marker setMarkerSize [_myradiusb, _myradiusb];
	_marker setMarkerShape "ELLIPSE";
	_marker setMarkerColor "ColorBlue";
};
*/