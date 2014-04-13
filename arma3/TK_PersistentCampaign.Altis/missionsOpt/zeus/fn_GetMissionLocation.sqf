/* Achtung Spezielle Zone, die indiziert, dass diese Zone mit ZEUS gespielt werden soll */
private["_zoneIndex"];
_zoneIndex = _this select 0;

private["_zoneCoordinates"];
_zoneCoordinates = pixZones_ZoneCoordinates select _zoneIndex; 

private["_posX1","_posY1"];
_posX1 = _zoneCoordinates select 0;
_posY1 = _zoneCoordinates select 1;
private["_posX2","_posY2"];
_posX2 = _zoneCoordinates select 2;
_posY2 = _zoneCoordinates select 3;

private["_posX","_posY"];
_posX = _posX1 + ((_posX2 - _posX1) / 2);
_posY = _posY1 + ((_posY2 - _posY1) / 2);

private["_result"];
_result = [[_posX,_posY,0],0,[_posX,_posY,0],0]; /* [position, direction(fahrzeugtyp), obfuscatedPosition, obfuscatedRadius] */
	
_result