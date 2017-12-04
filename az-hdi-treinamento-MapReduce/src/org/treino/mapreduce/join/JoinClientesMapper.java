package org.treino.mapreduce.join;

import java.io.IOException;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class JoinClientesMapper extends Mapper<LongWritable, Text, Text, Text> {

	
	@Override
	protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
		String[] campos = value.toString().split("\t");
		context.write(new Text(campos[0]), new Text("C|"+campos[1]+"|"+campos[2]+"|"+campos[3]));		
	}	
	
}
