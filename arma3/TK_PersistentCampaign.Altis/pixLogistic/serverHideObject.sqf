if (!isDedicated) then	
{
	(_this select 0) hideObject (_this select 1);
}
else
{
	(_this select 0) hideObjectGlobal (_this select 1);
};
pixLogisticAdminHide = (_this select 1);