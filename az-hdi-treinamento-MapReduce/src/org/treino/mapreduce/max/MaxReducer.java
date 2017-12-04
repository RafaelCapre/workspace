package org.treino.mapreduce.max;

import java.io.IOException;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class MaxReducer extends Reducer<Text, Text, Text, Text> {

	@Override
	protected void reduce(Text key, Iterable<Text> values, Context context)	throws IOException, InterruptedException {
		double maior = 0;
		double vatual = 0;
		for(Text t : values){
			vatual = Double.parseDouble(t.toString());
			if (maior < vatual){
				maior = vatual;
			}
		}
		context.write(key, new Text(String.valueOf(maior)));
	}	
	
}
