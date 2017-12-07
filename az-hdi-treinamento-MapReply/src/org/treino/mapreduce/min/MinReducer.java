package org.treino.mapreduce.min;

import java.io.IOException;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class MinReducer extends Reducer<Text, Text, Text, Text> {

	@Override
	protected void reduce(Text key, Iterable<Text> values, Context context)	throws IOException, InterruptedException {
		
		double faturamentoMin = 0;
		double faturamento = 0;
		
		for (Text value:values) {
			faturamento = Double.parseDouble(value.toString());
			
			if ((faturamento<faturamentoMin) || (faturamentoMin==0)) {
				faturamentoMin = faturamento;
			}
		}
		
		context.write(key, new Text(String.valueOf(faturamentoMin)));	
		
	}	
	
}
