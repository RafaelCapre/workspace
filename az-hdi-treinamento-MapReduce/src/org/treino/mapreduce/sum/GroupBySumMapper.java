package org.treino.mapreduce.sum;

import java.io.IOException;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class GroupBySumMapper extends Mapper<LongWritable, Text, Text, Text> {

	private Text outKey = new Text();
	
	@Override
	protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
		String[] campos = value.toString().split("\t");
		context.write(new Text(campos[8] + "\t" + campos[9]), new Text(campos[2]));
	}	
	
}
