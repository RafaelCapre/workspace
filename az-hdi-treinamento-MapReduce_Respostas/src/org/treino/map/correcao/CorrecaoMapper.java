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

	private String order_number;
	private String gift_card;
	private String receipt_itens;
	private Text outKey = new Text();
	
	@Override
	protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
		
		String line = value.toString();
		String[] colunas = line.split("\\|");

		if (line.contains("CUSTOMER ID|ORDER NUMBER|GIFTCARD|RECEIPT ITEMS(...)")) {
			return;
		}
		
		outKey.set(colunas[0]); //coluna CUSTOMER ID
		order_number = colunas[1];
		gift_card = colunas[2];
		
		gift_card = gift_card.replace("n/a", "0");
		gift_card = gift_card.replace("$", "");
		
		for (int i=3; i<colunas.length; i++) {
			receipt_itens = colunas[i];
			context.write(outKey, new Text(order_number + "\t" + gift_card + "\t" + receipt_itens));
		}
		
	}	
	
}
