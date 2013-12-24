if (isServer) then
{
	private["_tmp"];
	_tmp = [] execVM "pixTime\run.sqf";
}
else
{
	"pvehPixTimeUpdate" addPublicVariableEventHandler {
		setDate pvehPixTimeUpdate;
	};
};