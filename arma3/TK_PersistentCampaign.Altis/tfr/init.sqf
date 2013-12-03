tf_no_auto_long_range_radio = true;
[] spawn {
	waituntil {sleep 0.5; player call haveSwRadio};
	[call activeSwRadio, "101.1" ] call setSwFrequency;
};
