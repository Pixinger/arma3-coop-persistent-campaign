if (isServer) then
{
	StaticCuratorModule removeCuratorEditableObjects [(curatorEditableObjects StaticCuratorModule),true];
}
else
{
	remoteExec ["fnc_Admin_ZeusObjectRemove", 2]; // 2= only server
};