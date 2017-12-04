


import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;
import org.treino.mapreduce.min.MinMapper;
import org.treino.mapreduce.min.MinReducer;

/**
 * A classe Min
 * 	recebe como entrada os dados da tabela de cadastros e
 *  tem como saida a UF e seu faturamento mais baixo.
 */
public class Min extends Configured implements Tool {

	@Override
	public int run(String[] args) throws Exception {
		if (args.length < 2) {
            System.err.printf("Usage: %s [generic options] <inout> <output>\n", getClass().getName());
            ToolRunner.printGenericCommandUsage(System.err);
            return -1;
        }
        Job job = Job.getInstance(getConf());
        job.setJobName("Min");
        job.setJarByClass(getClass());
        
        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));
        
        job.setMapperClass(MinMapper.class);
        job.setReducerClass(MinReducer.class);
        
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
		int res = ToolRunner.run(new Min(), args);
    	System.exit(res);
	}

}
