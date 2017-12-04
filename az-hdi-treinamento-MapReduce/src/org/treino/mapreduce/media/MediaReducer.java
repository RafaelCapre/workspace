package org.treino.mapreduce.media;

import java.io.IOException;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class MediaReducer extends Reducer<Text, Text, Text, Text> {

	@Override
	protected void reduce(Text key, Iterable<Text> values, Context context)	throws IOException, InterruptedException {
		double soma = 0;
		double media = 0;
		int cont = 0;
		for (Text t : values){
			soma += Double.parseDouble(t.toString());
			cont++;
		}
		media = soma / cont;
		context.write(key, new Text(String.valueOf(media)));		
	}	
}
