package org.treino.mapreduce.net;


import java.io.IOException;
import java.util.TreeMap;

import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class NetLeaseAggrReducer extends Reducer<Text, Text, NullWritable, Text> {
  @Override
  protected void reduce(Text key, Iterable<Text> values, Context context)
                 throws IOException, InterruptedException {
    Text temp = new Text();
    TreeMap<Text, Text> recordRepo = new TreeMap<Text, Text>();
    

    for (Text val : values) {
      String[] rawTokens = val.toString().split(",");
      recordRepo.put(new Text(rawTokens[0]), new Text(rawTokens[1]));
    }
    

    //key has mac address, ip address, action
    //firstkey is starting time, lastEntry.getValue has last end time
    temp.set(recordRepo.firstKey() + "\t" + recordRepo.lastEntry().getValue() + "\t" +  key.toString());
    
    context.write(NullWritable.get(), temp);
  }
}
