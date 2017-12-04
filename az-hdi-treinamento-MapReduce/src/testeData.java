import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.sql.Timestamp;

public class testeData {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
	    //#Sun Feb 16 04:06:00 2014
		SimpleDateFormat sdf1 = new SimpleDateFormat("EEE MMM dd HH:mm:ss yyyy", Locale.ENGLISH);
	    String t = "Mon sep 29 01:01:01 2014";
	    try {
	      long st_time = sdf1.parse(t).getTime();
	      String start_time = Long.toString(st_time);
	      System.out.println("conversão para timestamp long");
	      System.out.println("start_time: " + start_time);
	      
	      System.out.println("conversão de long para timestamp");
	      //1406178047000
	      
	      Timestamp data = new Timestamp(Long.valueOf("1406178047000"));
	      
	      System.out.println("dateAsText: " + data);
	      
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
	}
}
