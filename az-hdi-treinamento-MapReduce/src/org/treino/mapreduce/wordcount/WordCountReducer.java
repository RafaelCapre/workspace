package org.treino.mapreduce.wordcount;

import java.io.IOException;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class WordCountReducer extends Reducer<Text, Text, Text, Text> {

	@Override
	protected void reduce(Text key, Iterable<Text> values, Context context)	throws IOException, InterruptedException {
		int cont = 0;
		for(Text t : values){
			cont++;
		}
		context.write(key, new Text(String.valueOf(cont)));
	}	
	
}
