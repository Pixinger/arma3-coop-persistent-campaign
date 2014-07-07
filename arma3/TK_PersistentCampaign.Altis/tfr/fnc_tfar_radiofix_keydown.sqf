
if (!pixTfarZeusfix_SwPressed) then
{
	if (_this select 1 == TF_tangent_sw_scancode) then
	{
		if (str(_this select 2) == str(TF_tangent_sw_modifiers select 0)) then
		{
			if (str(_this select 3) == str(TF_tangent_sw_modifiers select 1)) then
			{
				if (str(_this select 4) == str(TF_tangent_sw_modifiers select 2)) then 
				{
					pixTfarZeusfix_SwPressed = true;
					_tmp = [] call TFAR_fnc_onSwTangentPressed;
				};
			};
		};
	};
};

if (!pixTfarZeusfix_LrPressed) then
{
	if (_this select 1 == TF_tangent_lr_scancode) then
	{
		if (str(_this select 2) == str(TF_tangent_lr_modifiers select 0)) then
		{
			if (str(_this select 3) == str(TF_tangent_lr_modifiers select 1)) then
			{
				if (str(_this select 4) == str(TF_tangent_lr_modifiers select 2)) then 
				{
					pixTfarZeusfix_LrPressed = true;
					_tmp = [] call TFAR_fnc_onLrTangentPressed;
				};
			};
		};
	};
};