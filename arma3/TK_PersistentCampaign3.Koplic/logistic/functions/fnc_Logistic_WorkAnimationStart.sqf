[] spawn 
{
	if (!logisticWorkAnimExit) exitWith { 0 };
	logisticWorkAnimExit = false;	
	while { !logisticWorkAnimExit } do
	{
		player playActionNow "medic";
		private _animationState = animationState player;
		waitUntil {_animationState != animationState player};
		player globalChat (animationState player);
	};
	player globalChat "anim done";
};
