package com.giljobe.common;

public class LogMessage {

    // ✅ Info
    public static final String START = "✅ [INFO] 시작: ";
    public static final String END = "✅ [INFO] 종료: ";
    public static final String STATUS = "ℹ️ [INFO] 상태: ";

    // ✅ Debug
    public static final String DEBUG = "🐛 [DEBUG] ";
    public static final String LOOP = "🔄 [LOOP] ";

    // ✅ Warning
    public static final String WARN = "⚠️ [WARN] ";
    public static final String WARN_NULL = "⚠️ [WARN] NULL 발생: ";
    public static final String WARN_INVALID = "⚠️ [WARN] 유효하지 않은 값: ";

    // ✅ Error
    public static final String ERROR = "❌ [ERROR] ";
    public static final String ERROR_DB = "❌ [ERROR] DB 오류: ";

    // ✅ Timer
    public static final String TIMER = "⏱️ [TIME] ";

    // ✅ Divider
    public static final String DIVIDER = "--------------------------------------------------";
    public static final String STEP = "🔷 [STEP] ";
}
