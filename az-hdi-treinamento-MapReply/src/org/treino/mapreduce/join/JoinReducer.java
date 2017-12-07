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
		int nColunas;
		
		for (Text value:values) {			
			nColunas = value.toString().split("\t").length;
			
			if (nColunas==2) { //Se o numero de colunas for igual a 3, e um cliente
				cliente = value.toString();
			} else 
			if (nColunas==3) { //Se o numero de colunas for igual a 6, e um endereco
				enderecos.add(value.toString());
			}			
		}
		
		// Concatenar cada endereco ao cliente a ele relacionado
		for (String endereco:enderecos) {
			context.write(key, new Text(cliente + "\t" + endereco));
		}	
		
	}	
	
}
