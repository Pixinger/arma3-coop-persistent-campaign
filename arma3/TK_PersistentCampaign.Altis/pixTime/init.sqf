if (isServer) then
{
	private["tmp"];
	_tmp = [] execVM "pixTime\run.sqf";
}
else
{
	"pvehPixTimeUpdate" addPublicVariableEventHandler {
		if (pixDebug) then { player globalChat format["pvehPixTimeUpdate: %1", pvehPixTimeUpdate];
		if (count pvehPixTimeUpdate == 5) then
		{
			setDate pvehPixTimeUpdate;
		}
		else
		{
			player globalchat "ERROR: Invalid Time Update (pixTime)";
		};
	};
};