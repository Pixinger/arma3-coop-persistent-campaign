private["_roadX"];
_roadX = _this select 0;
private["_roadY"];
_roadY = _this select 1;
private["_iedClassnames"];
_iedClassnames = _this select 2; //["ModuleExplosive_IEDUrbanSmall_F", "ModuleExplosive_IEDLandSmall_F", "ModuleExplosive_IEDUrbanBig_F", "ModuleExplosive_IEDLandBig_F"];
private["_ied"];
_ied = _iedClassnames select floor(random(count _iedClassnames)) createVehicle [_roadX, _roadY, 0]; 		

Sleep 0.5;
_ied setDir (random 360);
	
if (pixDebug) then
{
	_markername = [] call fnc_TownSM_GetUniqueMarkerName;
	createMarkerLocal [_markerName,  getPos _ied];
	_markerName setMarkerDirLocal (getDir _ied);
	_markerName setMarkerShapeLocal "ICON";
	_markerName setMarkerTypeLocal "mil_dot";
	_markerName setMarkerSizeLocal [.5, .5];
	_markerName setMarkerAlphaLocal 1;
	_markerName setMarkerColorLocal "ColorRed";
	_markerName setMarkerTextLocal "";
};		
