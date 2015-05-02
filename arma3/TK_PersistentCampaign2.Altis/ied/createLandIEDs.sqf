#define MIN_X 1914
#define MIN_Y 4694
#define MAX_X 28493
#define MAX_Y 25824

if (isServer) then
{
	private["_limit"];
	_limit = 100;
	private["_xPos"];
	_xPos = MIN_X + (random (MAX_X - MIN_X));
	private["_yPos"];
	_yPos = MIN_Y + (random (MAX_Y - MIN_Y));
	
	private["_road"];	
	while { _limit > 0 } do
	{
		_limit = _limit - 1;
		
		while { surfaceIsWater [_xPos, _yPos] } do
		{
			_xPos = MIN_X + (random (MAX_X - MIN_X));
			_yPos = MIN_Y + (random (MAX_Y - MIN_Y));
		};

		// Strassen suchen
		private["_roads"];
		_roads = [_xPos, _yPos] nearRoads 1000;		
		if (count _roads > 0) then 
		{
			_road = _roads select floor(random(count _roads));
			player setpos (getpos _road);
			_limit = -10; 
		};
	};

	if (_limit == -10) then // Es wurde eine Stelle gefunden
	{
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

		[_roadX, _roadY] spawn compile preprocessFileLineNumbers "ied\createIED.sqf";
	} 
	else
	{
		diag_log "WARN: Es konnte keine Position für eine Land IED gefunden werden.";
	};
};