package org.treino.mapreduce.min;

import java.io.IOException;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class MinReducer extends Reducer<Text, Text, Text, Text> {

	@Override
	protected void reduce(Text key, Iterable<Text> values, Context context)	throws IOException, InterruptedException {
		double menor = Double.MAX_VALUE;
		double vatual = 0;
		for(Text t : values){
			vatual = Double.parseDouble(t.toString());
			if (vatual < menor){
				menor = vatual;
			}
		}
		context.write(key, new Text(String.valueOf(menor)));
	}
}
