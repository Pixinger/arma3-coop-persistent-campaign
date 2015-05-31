private["_units"];
_units = player nearEntities ["SoldierGB", 500];

{
	private["_tmp"];
	_tmp = [_x] spawn
	{
		private["_vehicle"];
		_vehicle = _this select 0;
		private["_previousTexture"];
		_previousTexture = (getObjectTextures _vehicle) select 0;
		player globalchat format["%1", _previousTexture];
  		
		private["_colors"];
		_colors = ["#(argb,8,8,3)color(1,0,0,1,co)",
		"#(argb,8,8,3)color(1,0.5,0,1,co)",
		"#(argb,8,8,3)color(1,1,0,1,co)",
		"#(argb,8,8,3)color(0,1,0,1,co)",
		"#(argb,8,8,3)color(0,0,1,1,co)",
		"#(argb,8,8,3)color(0.2,0,0.5,1,co)",
		"#(argb,8,8,3)color(0.5,0,1,1,co)"];
			
		private["_timeout"];
		_timeout = time + 60;
		private["_index"];
		_index = 0;
		while { time < _timeout } do 
		{
			_vehicle setObjectTexture [0, (_colors select _index)];
			_index = (_index + 1) % 7;
			sleep 0.05;
		};
		
		_vehicle setObjectTexture [0, _previousTexture];		
	};
} foreach _units;


