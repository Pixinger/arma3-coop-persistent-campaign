if (isNil "TownSM_GetUniqueMarkerName_Mutex") then {TownSM_GetUniqueMarkerName_Mutex = false};
waitUntil { !TownSM_GetUniqueMarkerName_Mutex };
TownSM_GetUniqueMarkerName_Mutex = true;

/*-----------------------------------*/
/* Eindeutigen Markernamen erstellen */
/*-----------------------------------*/
private["_i"];
_i = 0;
private["_i1"];
_i1 = floor random 10000;
private["_result"];
_result = format["mu%1_%2", _i1, _i];
while { str(getMarkerPos _result) != "[0,0,0]" } do 
{
	_i = _i + 1;
	_result = format["mu%1_%2", _i1, _i];
};

TownSM_GetUniqueMarkerName_Mutex = false;
_result;