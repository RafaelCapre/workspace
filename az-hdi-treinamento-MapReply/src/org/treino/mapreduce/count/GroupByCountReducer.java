package org.treino.mapreduce.count;

import java.io.IOException;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class GroupByCountReducer extends Reducer<Text, Text, Text, Text> {

	@Override
	protected void reduce(Text key, Iterable<Text> values, Context context)	throws IOException, InterruptedException {
		
		int totalClientes = 0;
		
		for (Text umCliente:values) {
			totalClientes = totalClientes + Integer.parseInt(umCliente.toString());
		}
		
		context.write(key, new Text(String.valueOf(totalClientes)));	
		
	}	
	
}
