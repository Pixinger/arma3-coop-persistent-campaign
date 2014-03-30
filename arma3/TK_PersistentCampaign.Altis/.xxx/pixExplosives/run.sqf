[] spawn
{			
	pixExplosives_Visible = false;
	
	waitUntil {!isNull player};
	
	private["_playerObject"];
	_playerObject = player;
	
	private["_menuId1"];
	_menuId1 = _playerObject addAction ["Sprengladung anbringen","pixExplosives\actionPlaceCharge.sqf", [], 101, true, true, "", "pixExplosives_Visible"];

	/* Infinite Loop */
	while { _playerObject == player } do
	{
		Sleep 5;
		private["_cursorTarget"];
		_cursorTarget = cursorTarget;
		if (typeof _cursorTarget == "Land_TTowerBig_2_F") then
		{
			if (player distance _cursorTarget < 24) then
			{
				pixExplosives_Visible = true;
			}
			else
			{
				pixExplosives_Visible = false;
			};
		}
		else
		{
			pixExplosives_Visible = false;
		};
	};
};