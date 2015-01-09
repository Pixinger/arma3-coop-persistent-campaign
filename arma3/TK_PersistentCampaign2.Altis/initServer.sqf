// Executed only on server when mission is started. See initialization order for details about when the script is exactly executed.  
addMissionEventHandler ["Ended",{ _this execVM "onMissionEventHandler_MissionEnded.sqf" }];
addMissionEventHandler ["HandleDisconnect",{ _this execVM "onMissionEventHandler_HandleDisconnect.sqf" }];