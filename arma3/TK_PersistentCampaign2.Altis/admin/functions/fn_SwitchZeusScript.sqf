if (isNil "adminPreviousZeusUnit") then
{
	adminPreviousZeusUnit = player;
	adminPreviousZeusUnit allowDamage false;
	
	addSwitchableUnit EastZeusUnit;
	selectPlayer EastZeusUnit;
}
else
{	
	addSwitchableUnit adminPreviousZeusUnit;
	selectPlayer adminPreviousZeusUnit;
	adminPreviousZeusUnit allowDamage true;	
	adminPreviousZeusUnit = nil;	
};