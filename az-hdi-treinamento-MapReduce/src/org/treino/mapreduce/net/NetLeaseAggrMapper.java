package org.treino.mapreduce.net;

import java.io.IOException;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;


import java.text.*;
import java.util.Locale;

public class NetLeaseAggrMapper extends Mapper<LongWritable, Text, Text, Text> {
  Text key = new Text();
  Text val = new Text();

  @Override
  protected void map(LongWritable k, Text text, Context context)
                 throws IOException, InterruptedException {
    String[] tokens = text.toString().split(",");

    //#Sun Feb 16 04:06:00 2014
    SimpleDateFormat sdf1 = new SimpleDateFormat("EEE MMM dd HH:mm:ss yyyy", Locale.ENGLISH);

    try {
      long st_time = sdf1.parse(tokens[0].replaceAll("[\"]", "")).getTime();
      long en_time = sdf1.parse(tokens[1].replaceAll("[\"]", "")).getTime();

      String start_time = Long.toString(st_time);
      String end_time = Long.toString(en_time);
      
      String ip_address 	= tokens[2];
      String mac_address 	= tokens[4];
      String protocol   	= tokens[10];
      String remoteId		= tokens[12];

      key.set(mac_address + "," + ip_address + "," + protocol + "," + remoteId);
      val.set(start_time + "," + end_time);
      context.write(key, val);
    } catch (ParseException e) {
      e.printStackTrace();
    }
  }
}
