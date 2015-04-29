if (isServer) then
{
	private["_townCenter"];
	_townCenter = _this select 0;
	private["_townRadius"];
	_townRadius = _this select 1;
	private["_iedCount"];
	_iedCount = round( (pi * (_townRadius*_townRadius)) / 31500); // => 4 pro 200m Radius
	
	// IED erstellen
	for "_i" from 1 to _iedCount do
	{
		// Strassen suchen
		private["_roads"];
		_roads = _townCenter nearRoads _townradius;		
		// Einzelnes Element suchen
		private["_road"];
		_road = _roads select floor(random(count _roads));
		private["_roadX"];
		_roadX = (getPos _road) select 0;
		private["_roadY"];
		_roadY = (getPos _road) select 1;

		private["_limit"];
		_limit = 100;
		private["_directions"];
		_directions = [[0, 2], [2, 2], [2, 0], [2, -2], [0, -2], [-2, -2], [-2, 0], [-2, 2]]; // Uhrzeigersinn
		while { (_limit > 0) } do
		{
			private["_offset"];
			_offset = (_directions select (floor(random(count _directions))));
			_roadX = _roadX + (_offset select 0);
			_roadY = _roadY + (_offset select 1);
			if (!isOnRoad [_roadX,_roadY]) then
			{
				_limit = 0;
			};			
		};
		
		private["_iedClassnames"];
		_iedClassnames = ["ModuleExplosive_IEDUrbanSmall_F", "ModuleExplosive_IEDLandSmall_F", "ModuleExplosive_IEDUrbanBig_F", "ModuleExplosive_IEDLandBig_F"];
		private["_ied"];
		_ied = _iedClassnames select floor(random(count _iedClassnames)) createVehicle [_roadX, _roadY, 0]; 		
		//_ied = "ModuleExplosive_IEDUrbanSmall_F" createVehicle getpos player; 		
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
	};		
};