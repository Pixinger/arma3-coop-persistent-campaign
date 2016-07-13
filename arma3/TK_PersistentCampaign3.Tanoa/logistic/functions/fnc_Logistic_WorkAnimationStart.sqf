if (!logisticWorkAnimExit) exitWith { 0 };
logisticWorkAnimExit = false;	

[] spawn 
{
	while { !logisticWorkAnimExit } do
	{
		player playActionNow "medic";
		private _animationState = animationState player;
		waitUntil {_animationState != animationState player};
	};
};
