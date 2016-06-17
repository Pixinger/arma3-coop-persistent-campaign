#define DEBUG_LOG_ENABLED

#ifdef DEBUG_LOG_ENABLED
	#define DEBUG_LOG_FILE					diag_log 'DEBUG: __FILE__';
	#define DEBUG_LOG_THIS					diag_log format['DEBUG: _this = %1', _this];
	#define DEBUG_LOG_VAR(__yy)				diag_log format['DEBUG: __yy = %1', __yy];
	#define DEBUG_LOG_VAREX(__yy,__zz)		diag_log format['DEBUG: __yy = %1', __zz];
	#define DEBUG_LOG(__yy)					diag_log format['DEBUG: %1', __yy];
#else
	#define DEBUG_LOG_FILE	
	#define DEBUG_LOG_THIS	
	#define DEBUG_LOG_VAR(__yy)			
	#define DEBUG_LOG_VAREX(__yy,__zz)	
	#define DEBUG_LOG(__yy)	
#endif

#define DEBUG_LOG_INFO(__yy)				diag_log format['INFO: %1', __yy];
#define DEBUG_LOG_VAR_INFO(__yy)			diag_log format['INFO: __yy = %1', __yy];
#define DEBUG_LOG_VAREX_INFO(__yy,__zz)		diag_log format['INFO: __yy = %1', __zz];
#define DEBUG_LOG_WARN(__yy)				diag_log format['WARN: %1', __yy];
#define DEBUG_LOG_VAR_WARN(__yy)			diag_log format['WARN: __yy = %1', __yy];
#define DEBUG_LOG_VAREX_WARN(__yy,__zz)		diag_log format['WARN: __yy = %1', __zz];
#define DEBUG_LOG_ERROR(__yy)				diag_log format['ERROR: %1', __yy];
#define DEBUG_LOG_VAR_ERROR(__yy)			diag_log format['ERROR: __yy = %1', __yy];
#define DEBUG_LOG_VAREX_ERROR(__yy,__zz)	diag_log format['ERROR: __yy = %1', __zz];
