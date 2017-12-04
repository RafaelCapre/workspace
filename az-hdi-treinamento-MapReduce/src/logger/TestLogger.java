package logger;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.LogManager;
import java.util.logging.Logger;



public class TestLogger {
  // use the classname for the logger, this way you can refactor
  private final static Logger LOGGER = Logger.getLogger(TestLogger.class.getName());

  public void doSomeThingAndLog() {
    // ... more code

    // now we demo the logging

    // set the LogLevel to Severe, only severe Messages will be written
    LOGGER.setLevel(Level.SEVERE);
    LOGGER.severe("Info Log");
    LOGGER.warning("Info Log");
    LOGGER.info("Info Log");
    LOGGER.finest("Really not important");

    // set the LogLevel to Info, severe, warning and info will be written
    // finest is still not written
    LOGGER.setLevel(Level.INFO);
    LOGGER.severe("Info Log");
    LOGGER.warning("Info Log");
    LOGGER.info("Info Log");
    LOGGER.finest("Really not important");
  }

  public static void main(String[] args) {
    TestLogger tester = new TestLogger();
    tester.doSomeThingAndLog();
    try {
      MyLogger.setup();
    } catch (IOException e) {
      e.printStackTrace();
      throw new RuntimeException("Problems with creating the log files");
    }
    LogManager.getLogManager().getLogger(Logger.GLOBAL_LOGGER_NAME).setLevel(Level.FINE); 
    tester.doSomeThingAndLog();
  }
}
 