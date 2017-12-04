package org.treino.mapreduce.count;

import java.io.IOException;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class GroupByCountMapper extends Mapper<LongWritable, Text, Text, Text> {

	
	@Override
	protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
		String linha = value.toString();
		String[] campos = linha.split("\t");
		context.write(new Text(campos[0]), new Text("1"));
		
		System.out.println("mapreduce count done! Congrats Móz");
	}	
	
}
