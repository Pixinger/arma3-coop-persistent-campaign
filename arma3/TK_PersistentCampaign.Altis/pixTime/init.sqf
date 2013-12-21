if (isServer) then
{
	private["tmp"];
	_tmp = [] execVM "pixTime\run.sqf";
}
else
{
	"pvehPixTimeUpdate" addPublicVariableEventHandler {
		if (pixDebug) then { player globalChat format["pvehPixTimeUpdate: %1", pvehPixTimeUpdate];
		setDate pvehPixTimeUpdate;
	};
};