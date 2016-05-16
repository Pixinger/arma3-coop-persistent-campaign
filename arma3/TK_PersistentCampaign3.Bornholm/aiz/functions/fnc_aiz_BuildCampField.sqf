private["_zoneIndex"];
_zoneIndex = _this select 0;
private["_camp"];
_camp = _this select 1;

private["_position"];
_position = _camp select 0;
private["_respawns"];
_respawns = _camp select 1;


private["_markerName"];
_markerName = createMarkerLocal [format["markerCamp%1", random 999999], _position];
_markerName setMarkerShapeLocal "ICON";
_markerName setMarkerTypeLocal "o_inf";
_markerName setMarkerSizeLocal [0.5, 0.5];
_markerName setMarkerTextLocal format["f %1", _respawns];
_markerName setMarkerColorLocal "ColorBlue"; 
_markerName setMarkerAlphaLocal 0.8;