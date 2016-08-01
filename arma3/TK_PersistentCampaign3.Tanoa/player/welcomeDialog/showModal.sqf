#include "defines.hpp"

[] spawn 
{
	// show the dialog
	disableSerialization;
	createDialog "WelcomdeDialog";
	waitUntil {dialog};

	private _control = (findDisplay WELCOME_IDD_DIALOG) displayCtrl WELCOME_IDC_DIALOG_HTML;
	_control ctrlCommit 0;
	_control htmlLoad (localize "str_pc3_WelcomeDialogFilename");
	//_control htmlLoad "http://teamkommando.net/arma_dialogs/welcome_to_tk.htm";
};