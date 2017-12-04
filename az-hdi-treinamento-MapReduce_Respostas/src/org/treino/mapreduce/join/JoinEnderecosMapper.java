package org.treino.mapreduce.join;

import java.io.IOException;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class JoinEnderecosMapper extends Mapper<LongWritable, Text, Text, Text> {

	private Text outKey = new Text();
	
	@Override
	protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
		
		String line = value.toString();
		String[] colunas = line.split("\t");
		
		outKey.set(colunas[6]); 
		
		context.write(outKey, new Text(colunas[3] +"\t"+ colunas[4] +"\t"+ colunas[5]));
		
	}	
	
}
