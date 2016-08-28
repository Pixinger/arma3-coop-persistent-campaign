#include "..\..\debugOn.hpp" 
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

waitUntil { aizZoneInitCompleted };

Sleep (random 3);
//================================================================================
// _THIS
//================================================================================
params ["_zoneIndex", "_aizZoneActiveIndex", "_iedSite"];
_iedSite params ["_idePosition"];

//================================================================================
// State Machine starten
//================================================================================
#define STATE_EXIT				1
#define STATE_THINKING			2

private _state = STATE_THINKING;
while { _state != STATE_EXIT } do 
{
	Sleep 2;
	
	if ((aizZoneActive select _zoneIndex) != _aizZoneActiveIndex) exitWith { _state = STATE_EXIT; };
	
	switch (_state) do 
	{
		//###############################################################################################################
		case STATE_THINKING:
		{
			//DEBUG_LOG("STATE_THINKING");			
			_state = STATE_EXIT;
		};
	};
};


//================================================================================
// So gut aufräumen wie es geht
//================================================================================
