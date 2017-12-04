package org.treino.mapreduce.join;

import java.io.IOException;
import java.util.ArrayList;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class JoinReducer extends Reducer<Text, Text, Text, Text> {

	@Override
	protected void reduce(Text key, Iterable<Text> values, Context context)	throws IOException, InterruptedException {
		String cliente = "";
		ArrayList<String> enderecos = new ArrayList<String>();
		for(Text t : values){
			if(t.toString().charAt(0) == 'C'){
				cliente = t.toString();
			}
			else{
				enderecos.add(t.toString());
			}
		}
		
		for (String e : enderecos){
			context.write(key, new Text(cliente + "|" + e));
		}
	}	
}
