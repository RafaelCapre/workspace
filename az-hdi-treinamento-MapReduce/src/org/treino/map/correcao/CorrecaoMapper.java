package org.treino.map.correcao;

import java.io.IOException;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

/**
 * In:
 * CUSTOMER ID|ORDER NUMBER|GIFTCARD|RECEIPT ITEMS(...)
 * 113698|10000004|n/a|24982;74.51;2|8437;25.7;3
 * 
 * Out:
 * 113698|10000004|n/a|24982;74.51;2
 * 113698|10000004|n/a|8437;25.7;3
 * 
 */

public class CorrecaoMapper extends Mapper<LongWritable, Text, Text, Text> {

	
	@Override
	protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
		
		
	}	
	
}
