//
// Farooq's Revive 1.4d
//

//------------------------------------------//
// Parameters - Feel free to edit these
//------------------------------------------//

// Seconds until unconscious unit bleeds out and dies. Set to 0 to disable.
FAR_BleedOut = 300;	

// Enable teamkill notifications
FAR_EnableDeathMessages = true;

/*
	0 = Only medics can revive
	1 = All units can revive
	2 = Same as 1 but a medikit is required to revive
*/
FAR_ReviveMode = 0;

//------------------------------------------//

call compile preprocessFile "FAR_revive\FAR_revive_funcs.sqf";

#define SCRIPT_VERSION "1.4d"

FAR_isDragging = false;
FAR_isDragging_EH = [];
FAR_deathMessage = [];
FAR_Debugging = true;

if (isDedicated) exitWith {};

////////////////////////////////////////////////
// Player Initialization
////////////////////////////////////////////////
[] spawn
{
    waitUntil { !isNull player };

	// Public event handlers
	"FAR_isDragging_EH" addPublicVariableEventHandler FAR_public_EH;
	"FAR_deathMessage" addPublicVariableEventHandler FAR_public_EH;
	
	[] spawn FAR_Player_Init;
	
	hintSilent format["Farooq's Revive %1 is initialized.", SCRIPT_VERSION];

	// Event Handlers
	player addEventHandler 
	[
		"Respawn", 
		{ 
			[] spawn FAR_Player_Init;
		}
	];
};

// Drag & Carry animation fix
[] spawn
{
	while {true} do
	{
		if (animationState player == "acinpknlmstpsraswrfldnon_acinpercmrunsraswrfldnon" || animationState player == "helper_switchtocarryrfl" || animationState player == "AcinPknlMstpSrasWrflDnon") then
		{
			if (FAR_isDragging) then
			{
				player switchMove "AcinPknlMstpSrasWrflDnon";
			}
			else
			{
				player switchMove "amovpknlmstpsraswrfldnon";
			};
		};
			
		sleep 3;
	}
};

FAR_Player_Init =
{
	// Cache player's side
	FAR_PlayerSide = side player;

	// Clear event handler before adding it
	player removeAllEventHandlers "HandleDamage";

	player addEventHandler ["HandleDamage", FAR_HandleDamage_EH];
	player addEventHandler 
	[
		"Killed",
		{
			// Remove dead body of player (for missions with respawn enabled)
			_body = _this select 0;
			
			[_body] spawn 
			{
			
				waitUntil { alive player };
				_body = _this select 0;
				deleteVehicle _body;
			}
		}
	];
	
	player setVariable ["FAR_isUnconscious", 0, true];
	player setVariable ["FAR_isDragged", 0, true];
	FAR_isDragging = false;
	
	[] spawn FAR_Player_Actions;
};

////////////////////////////////////////////////
// [Debugging] Add revive to playable AI units
////////////////////////////////////////////////
if (!FAR_Debugging || isMultiplayer) exitWith {};

{
	if (!isPlayer _x) then 
	{
		_x addEventHandler ["HandleDamage", FAR_HandleDamage_EH];
		_x setVariable ["FAR_isUnconscious", 0, true];
		_x setVariable ["FAR_isDragged", 0, true];
	};
} forEach switchableUnits;