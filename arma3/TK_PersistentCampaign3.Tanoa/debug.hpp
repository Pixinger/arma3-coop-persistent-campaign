//#define DEBUG_LOG_ENABLED
//#define MARKER_ENABLED

#ifdef DEBUG_LOG_ENABLED
	#define DEBUG_LOG_FILE						diag_log 'DEBUG: __FILE__';
	#define DEBUG_LOG_THIS						diag_log format['DEBUG: _this = %1', _this];
	#define DEBUG_LOG_VAR(__yy)					diag_log format['DEBUG: __yy = %1', __yy];
	#define DEBUG_LOG_VAREX(__yy,__zz)			diag_log format['DEBUG: __yy = %1', __zz];
	#define DEBUG_LOG_VAREX2(__yy,__zz,__xx)	diag_log format['DEBUG: __yy = %1 / %2', __zz, __xx];
	#define DEBUG_LOG(__yy)						diag_log format['DEBUG: %1', __yy];
#else
	#define DEBUG_LOG_FILE	
	#define DEBUG_LOG_THIS	
	#define DEBUG_LOG_VAR(__yy)			
	#define DEBUG_LOG_VAREX(__yy,__zz)	
	#define DEBUG_LOG_VAREX2(__yy,__zz,__xx)	
	#define DEBUG_LOG(__yy)	
#endif

#define INFO_LOG(__yy)						diag_log format['INFO: %1', __yy];
#define INFO_LOG_VAR(__yy)					diag_log format['INFO: __yy = %1', __yy];
#define INFO_LOG_VAREX(__yy,__zz)			diag_log format['INFO: __yy = %1', __zz];
#define INFO_LOG_VAREX2(__yy,__zz,__xx)		diag_log format['INFO: __yy = %1 / %2', __zz, __xx];
#define WARN_LOG(__yy)						diag_log format['WARN: %1', __yy];
#define WARN_LOG_VAR(__yy)					diag_log format['WARN: __yy = %1', __yy];
#define WARN_LOG_VAREX(__yy,__zz)			diag_log format['WARN: __yy = %1', __zz];
#define WARN_LOG_VAREX2(__yy,__zz,__xx)		diag_log format['WARN: __yy = %1 / %2', __zz, __xx];
#define ERROR_LOG(__yy)						diag_log format['ERROR: %1', __yy];
#define ERROR_LOG_VAR(__yy)					diag_log format['ERROR: __yy = %1', __yy];
#define ERROR_LOG_VAREX(__yy,__zz)			diag_log format['ERROR: __yy = %1', __zz];
#define ERROR_LOG_VAREX2(__yy,__zz,__xx)	diag_log format['ERROR: __yy = %1 / %2', __zz, __xx];
