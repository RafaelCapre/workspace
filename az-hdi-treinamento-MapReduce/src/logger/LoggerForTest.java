package logger;

import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.logging.Handler;
import java.util.logging.LogRecord;
import java.util.logging.SimpleFormatter;


public class LoggerForTest {
	
	
	public static void main(String args[]){
		
		Logger logger = Logger.getLogger(Logger.GLOBAL_LOGGER_NAME);
		logger.log(Level.SEVERE, "Entendimento");
		
	}

}
