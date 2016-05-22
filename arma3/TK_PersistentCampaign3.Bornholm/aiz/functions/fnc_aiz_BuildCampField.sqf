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
_markerName setMarkerTypeLocal "o_support";
_markerName setMarkerSizeLocal [0.5, 0.5];
_markerName setMarkerTextLocal format["f %1", _respawns];
_markerName setMarkerColorLocal "ColorBlue"; 
_markerName setMarkerAlphaLocal 0.8;

private _fireClassnames = ["Land_Campfire_F","Campfire_burning_F"];
private _staticClassnames = ["I_HMG_01_high_F","I_GMG_01_high_F"];
private _tentClassnames = ["Land_TentDome_F", "Land_TentA_F"];

private _className = (_fireClassnames call fnc_aiz_RandomElement);	
private _firePosition = _position findEmptyPosition [0, aizCampFieldRadius, _className];
if (count _firePosition > 0) then
{
	// Feuerstelle erstellen
	private _fire = createVehicle [_className, _firePosition, [], 0, "NONE"];
	Sleep .2;
	_fire setPos _firePosition;
	Sleep .2;
	
	// Zelte erstellen
	private _tents = [];
	for "_i" from 1 to _respawns do
	{
		_className = (_tentClassnames call fnc_aiz_RandomElement);	
		private _tentPosition = _firePosition findEmptyPosition [3, aizCampFieldRadius, _className];		
		if (count _tentPosition > 0) then
		{
			private _tent = createVehicle [_className, _tentPosition, [], 0, "NONE"];
			Sleep .2;
			_tent setPos _tentPosition;
			_tent setDir (random 360);
			_tents pushBack _tent;
			Sleep .2;
		};
	};
	
	// Statische Waffen erstellen
	private _statics = [];
	for "_i" from 1 to (floor (_respawns / 4)) do
	{
		_className = (_staticClassnames call fnc_aiz_RandomElement);	
		private _staticPosition = _firePosition findEmptyPosition [25, aizCampFieldRadius, _className];		
		if (count _staticPosition > 0) then
		{
			private _static = createVehicle [_className, _staticPosition, [], 0, "CAN_COLLIDE"];
			Sleep .2;
			_static setPos _staticPosition;
			_static setDir (random 360);
			_statics pushBack _static;
			Sleep .2;
		};
	};
};