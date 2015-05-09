if (isServer) then
{
	private["_townCenter"];
	_townCenter = _this select 0;
	private["_townRadius"];
	_townRadius = _this select 1;
	
#define RADIUS_BASIS	200
#define COUNT_PER_RADIUS_BASIS	1.5
	private["_iedCount"];
	_iedCount = round( (pi * (_townRadius*_townRadius)) / ((pi * (RADIUS_BASIS*RADIUS_BASIS))*COUNT_PER_RADIUS_BASIS)); 
	
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
		
		[_roadX, _roadY, ["ModuleExplosive_IEDUrbanSmall_F", "ModuleExplosive_IEDUrbanBig_F"]] spawn compile preprocessFileLineNumbers "ied\createIED.sqf";
	};		
};