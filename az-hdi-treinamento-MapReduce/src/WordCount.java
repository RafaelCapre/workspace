


import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;
import org.treino.mapreduce.wordcount.WordCountMapper;
import org.treino.mapreduce.wordcount.WordCountReducer;

/**
 * A classe WordCount
 * 	recebe como entrada um arquivo de texto e
 *  tem como saida a o numero de vezes que cada palavra foi encontrada.
 */
public class WordCount extends Configured implements Tool {

	@Override
	public int run(String[] args) throws Exception {
		if (args.length < 2) {
            System.err.printf("Usage: %s [generic options] <inout> <output>\n", getClass().getName());
            ToolRunner.printGenericCommandUsage(System.err);
            return -1;
        }
        Job job = Job.getInstance(getConf());
        job.setJobName("WordCount");
        job.setJarByClass(getClass());
        
        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));
        
        job.setMapperClass(WordCountMapper.class);
        job.setReducerClass(WordCountReducer.class);
        
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);
        
		job.setNumReduceTasks(1);
        
		job.waitForCompletion(true);
		
		return 0;
	}

	/**
	 * @param args
	 * @throws Exception 
	 */
	public static void main(String[] args) throws Exception {
		int res = ToolRunner.run(new WordCount(), args);
    	System.exit(res);
	}

}
