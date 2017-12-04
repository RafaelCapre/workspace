/*

Transformar o arquivo de entrada

 "Start Time","End Time","IP Address","Gateway","HW Address","Client ID","Action","Host Sent","Host Received","A DNS Update","Protocol","Circuit ID","Remote ID","Vendor Class ID","DOCSIS DeviceClass","Vendor-Specific Data","Interface ID"
"Thu Jul 24 01:06:32 2014","Thu Jul 24 04:06:32 2014","189.4.80.10","187.65.240.1","20:cf:30:ee:d8:cc","01:20:cf:30:ee:d8:cc","Active","","","Successful","DHCPV4","00:0e:80:00:62:06","00:25:f1:f5:91:47","udhcp 0.9.8","0","",""
"Thu Jul 24 01:06:57 2014","Thu Jul 24 04:06:57 2014","189.4.80.10","187.65.240.1","20:cf:30:ee:d8:cc","01:20:cf:30:ee:d8:cc","Renewal","","","Successful","DHCPV4","00:0e:80:00:62:06","00:25:f1:f5:91:47","udhcp 0.9.8","0","",""
"Thu Jul 24 01:07:17 2014","Thu Jul 31 01:07:17 2014","10.15.0.4","10.15.0.1","fc:94:e3:67:e8:88","01:fc:94:e3:67:e8:88","Active","","","Successful","DHCPV4","01:04:80:00:00:05","fc:94:e3:67:e8:88","docsis2.0:054b01010102010203010104010105010106010107010f0801100901030a01010b01180c01010d0201000e0201000f0101100400000006110100130100200110210101220101260200ff270101","0","02:03:45:43:4d:03:10:45:43:4d:3a:45:4d:54:41:3a:45:52:4f:55:54:45:52:04:0e:30:30:39:38:34:32:32:30:32:30:39:32:39:35:05:03:32:2e:30:06:0a:53:54:43:37:2e:30:35:2e:32:31:07:05:32:2e:33:2e:31:08:06:32:38:42:45:39:42:09:08:54:43:37:31:31:30:2e:42:0a:0b:54:65:63:68:6e:69:63:6f:6c:6f:72",""
"Thu Jul 24 01:07:31 2014","Thu Jul 24 04:07:31 2014","189.4.80.10","187.65.240.1","20:cf:30:ee:d8:cc","01:20:cf:30:ee:d8:cc","Renewal","","","Successful","DHCPV4","00:0e:80:00:62:06","00:25:f1:f5:91:47","udhcp 0.9.8","0","",""
"Thu Jul 24 01:07:56 2014","Thu Jul 24 04:07:56 2014","189.4.80.21","187.65.240.1","00:23:cd:d9:f9:e7","01:00:23:cd:d9:f9:e7","Active","","TL-WR541G/542G","Successful","DHCPV4","00:03:80:00:00:03","00:11:e6:1f:97:33","4d:53:46:54:20:39:38:00:73","0","",""
"Thu Jul 24 01:08:05 2014","Thu Jul 24 04:08:05 2014","189.4.80.10","187.65.240.1","20:cf:30:ee:d8:cc","01:20:cf:30:ee:d8:cc","Renewal","","","Successful","DHCPV4","00:0e:80:00:62:06","00:25:f1:f5:91:47","udhcp 0.9.8","0","",""

 
 No arquivo de saída
 
1406177935000	1408769935000	"","2804:14D:BA82:0:0:0:0:0/64","DHCPV6","14:ab:f0:fd:72:02"
1406177947000	1408771041000	"","2804:14D:BA82:1000:0:5962:11B2:A651","DHCPV6","e8:89:2c:b8:e1:12"
1406177991000	1408770939000	"","2804:14D:BA82:1000:1041:2EEF:518B:99FF","DHCPV6","90:0d:cb:e2:95:72"
1406179073000	1408771458000	"","2804:14D:BA82:1000:1062:E3E5:26D1:2CEA","DHCPV6","e8:6d:52:b3:08:bc"
1406177980000	1408791252000	"","2804:14D:BA82:1000:1063:BB0B:F353:5172","DHCPV6","00:1d:d4:45:08:02"
1406177939000	1408769942000	"","2804:14D:BA82:1000:10AC:FF8D:3ABA:6952","DHCPV6","e8:6d:52:b3:30:64"
1406242404000	1408834404000	"","2804:14D:BA82:1000:10BD:65AB:272F:9DBE","DHCPV6","00:23:ed:ad:9e:f8"
1406289876000	1408881879000	"","2804:14D:BA82:1000:10F9:74CD:6451:4C0A","DHCPV6","00:15:9a:df:dc:5e"
1406178047000	1408770986000	"","2804:14D:BA82:1000:10FB:F541:E6B3:19","DHCPV6","5c:57:1a:dd:79:a2"
1406179010000	1408771467000	"","2804:14D:BA82:1000:1103:50F6:40F1:D399","DHCPV6","7c:bf:b1:df:5e:9e"
1406178238000	1408771206000	"","2804:14D:BA82:1000:1105:CEA7:3214:8B0","DHCPV6","38:6b:bb:4b:f9:ec"

 
 */



import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;
import org.treino.mapreduce.net.*;

public class NetLeaseAggrDriver extends Configured implements Tool {

	public int run(String[] args) throws Exception {

		Job job = new Job(getConf());
		job.setJarByClass(NetLeaseAggrDriver.class);

		FileInputFormat.setInputPaths(job, new Path(args[0]));
		Path outputPath = new Path(args[1]);
		outputPath.getFileSystem(job.getConfiguration()).delete(outputPath, true);

		job.setMapperClass(NetLeaseAggrMapper.class);
		job.setReducerClass(NetLeaseAggrReducer.class);

		FileOutputFormat.setOutputPath(job, new Path(args[1]));

		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(Text.class);

		job.setOutputKeyClass(NullWritable.class);
		job.setOutputValueClass(Text.class);
		job.setNumReduceTasks(1);
		job.waitForCompletion(true);
		return 0;

	}

	public static void main(String[] args) throws Exception {
		if (args.length < 2) {
			System.err.println("Usage: " + "NetLeaseAggrDriver <in> <out>");
			System.exit(2);
		}
		int exitCode = ToolRunner.run(new NetLeaseAggrDriver(), args);
		System.exit(exitCode);

	}
}

