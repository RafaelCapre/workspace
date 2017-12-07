package org.treino.mapreduce.max;

import java.io.IOException;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class MaxMapper extends Mapper<LongWritable, Text, Text, Text> {

	private Text outKey = new Text();
	
	@Override
	protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
		
		String line = value.toString();
		String[] colunas = line.split("\t");
		
		outKey.set(colunas[8]); //coluna cidade
		
		context.write(outKey, new Text(colunas[2]));
		
	}	
	
}
