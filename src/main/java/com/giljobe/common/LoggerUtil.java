package com.giljobe.common;

public class LoggerUtil {

    public static void start(String message) {
        System.out.println(LogMessage.START + message);
    }
    public static void end(String message) {
        System.out.println(LogMessage.END + message);
    }
    public static void status(String message) {
        System.out.println(LogMessage.STATUS + message);
    }

    public static void debug(String message) {
        System.out.println(LogMessage.DEBUG + message);
    }

    public static void warn(String message) {
        System.out.println(LogMessage.WARN + message);
    }

    public static void error(String message) {
        System.out.println(LogMessage.ERROR + message);
    }

    public static void error(String message, Exception e) {
        System.out.println(LogMessage.ERROR + message);
        e.printStackTrace();
    }

    public static void step(String message) {
        System.out.println(LogMessage.STEP + message);
    }

    public static void divider() {
        System.out.println(LogMessage.DIVIDER);
    }

    public static void time(String label, long startMillis) {
        long now = System.currentTimeMillis();
        System.out.println(LogMessage.TIMER + label + " - " + (now - startMillis) + "ms");
    }
}
