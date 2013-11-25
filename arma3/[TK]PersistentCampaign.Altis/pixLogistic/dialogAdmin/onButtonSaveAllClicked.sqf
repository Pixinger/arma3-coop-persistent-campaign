closeDialog 0;

if (isServer && !isDedicated) then
{
	player sidechat "simulate server";
	_tmp = [] execVM "pixLogistic\serverSaveAllItems.sqf";
}
else
{
	pvehPixlogisticSaveAllItems = true;
	publicVariable "pvehPixlogisticSaveAllItems";
};
