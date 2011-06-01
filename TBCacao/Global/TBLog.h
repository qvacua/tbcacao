#ifdef DEBUG
    #ifndef TBLOG_FOR_DEBUG
        #define TBLOG_FOR_DEBUG
        #define log4Debug(format, ...) NSLog((@"[DEBUG] %s - %d: " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
    #endif
#else
    #define log4Debug(...)
#endif

#ifndef TBLOG_FOR_INFO
    #define TBLOG_FOR_INFO
    #define log4Info(format, ...) NSLog((@"[INFO] %s - %d: " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

#ifndef TBLOG_FOR_WARN
    #define TBLOG_FOR_WARN
    #define log4Warn(format, ...) NSLog((@"[WARN] %s - %d: " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

#ifndef TBLOG_FOR_ERROR
    #define TBLOG_FOR_ERROR
    #define log4Error(format, ...) NSLog((@"[ERROR] %s - %d: " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

#ifndef TBLOG_FOR_FATAL
    #define TBLOG_FOR_FATAL
    #define log4Fatal(format, ...) NSLog((@"[FATAL] %s - %d: " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif
