if (local group player) then
{
	player sidechat "New leader selected";
	group player selectLeader (_this select 0);
}
else
{
	player sidechat "New leader requested";
};

