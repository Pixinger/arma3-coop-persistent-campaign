if (local group player) then
{
	player sidechat "New leader selected";
	group player selectLeader _this;
}
else
{
	player sidechat "New leader requested";
};

