



import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.MultipleInputs;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;
import org.treino.mapreduce.join.JoinClientesMapper;
import org.treino.mapreduce.join.JoinEnderecosMapper;
import org.treino.mapreduce.join.JoinReducer;

/**
 * A classe Join
 * 	recebe como entrada os dados da tabela de clientes e da tabela enderecos e
 *  tem como saida a o join deles.
 */
public class Join extends Configured implements Tool {

	@Override
	public int run(String[] args) throws Exception {
		if (args.length < 3) {
            System.err.printf("Usage: %s [generic options] <inout> <inout> <output>\n", getClass().getName());
            ToolRunner.printGenericCommandUsage(System.err);
            return -1;
        }
        Job job = Job.getInstance(getConf());
        job.setJobName("Join");
        job.setJarByClass(getClass());
        
        MultipleInputs.addInputPath(job, new Path(args[0]), TextInputFormat.class, JoinClientesMapper.class);
        MultipleInputs.addInputPath(job, new Path(args[1]), TextInputFormat.class, JoinEnderecosMapper.class);
        FileOutputFormat.setOutputPath(job, new Path(args[2]));
        
        job.setReducerClass(JoinReducer.class);
        
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
		int res = ToolRunner.run(new Join(), args);
    	System.exit(res);
	}

}
