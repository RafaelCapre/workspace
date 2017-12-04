package org.treino.mapreduce.sum;

import java.io.IOException;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class GroupBySumReducer extends Reducer<Text, Text, Text, Text> {

	@Override
	protected void reduce(Text key, Iterable<Text> values, Context context)	throws IOException, InterruptedException {
		
		int totalPorCidade = 0;
		
		for (Text faturamento:values) {
			totalPorCidade = totalPorCidade + Integer.parseInt(faturamento.toString());
		}
		
		context.write(key, new Text(String.valueOf(totalPorCidade)));
		
	}	
	
}
