package org.treino.mapreduce.wordcount;

import java.io.IOException;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class WordCountMapper extends Mapper<LongWritable, Text, Text, Text> {
	
	@Override
	protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
		String linha = value.toString();
		String[] palavras = linha.split(" ");
		
		//tenho por que tenho que fazer meu mapreduce.
		/*
		 0 tenho
		 1 por
		 2 que
		 3 tenho 
		 4 que 
		 5 fazer 
		 6 meu 
		 7 mapreduce.
		 */
		for(int i=0 ; i < palavras.length ; i++){
			context.write( new Text(palavras[i]) , new Text("1"));
		}
		/*
		 * 
		 * Saída
		 * 
		 tenho 1
		 tenho 1 
		 por 1
		 que 1
		 que 1
		 fazer 1 
		 meu 1
		 mapreduce. 1
		 */
	}	
}
