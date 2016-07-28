#include "..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

INFO_LOG_VAREX("Track fleeing unit: ", _this);

Sleep 10;

while { [getPos _this, 500] call fnc_aiz_IsBlueNear } do
{
	Sleep 10;
};

INFO_LOG_VAREX("Delete fleeing unit: ", _this);
deleteVehicle _this;