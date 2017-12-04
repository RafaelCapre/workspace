package org.treino.mapreduce.sum;

import java.io.IOException;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class GroupBySumMapper extends Mapper<LongWritable, Text, Text, Text> {

	private Text outKey = new Text();
	
	@Override
	protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
		
		String line = value.toString();
		String[] colunas = line.split("\t");
		
		String cidade = colunas[8];
		String uf = colunas[9];
		String faturamento = colunas[2];
		
		outKey.set(uf+"\t"+cidade);
		
		context.write(outKey, new Text(faturamento));
		
	}	
	
}
