package org.treino.mapreduce.media;

import java.io.IOException;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class MediaReducer extends Reducer<Text, Text, Text, Text> {

	@Override
	protected void reduce(Text key, Iterable<Text> values, Context context)	throws IOException, InterruptedException {
		
		double faturamentoTotal = 0;
		double faturamento = 0;
		double media;
		int nUF = 0;
		
		for (Text value:values) {
			faturamento = Double.parseDouble(value.toString());
			faturamentoTotal += faturamento;
			nUF++;
		}
		
		media = faturamentoTotal / nUF;
		
		context.write(key, new Text(String.valueOf(media)));	
		
	}	
	
}
