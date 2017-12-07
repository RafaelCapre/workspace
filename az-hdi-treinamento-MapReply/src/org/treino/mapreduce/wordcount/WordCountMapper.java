package org.treino.mapreduce.wordcount;

import java.io.IOException;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class WordCountMapper extends Mapper<LongWritable, Text, Text, Text> {
	
	@Override
	protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
		
		String line = value.toString();
		String[] palavras = line.split(" ");
		
		for (String palavra:palavras) {
			context.write(new Text(palavra), new Text("1"));
		}
		
	}	
	
}
