package com.treinamento.storm;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.storm.Config;
import org.apache.storm.LocalCluster;
import org.apache.storm.StormSubmitter;
import org.apache.storm.hdfs.bolt.HdfsBolt;
import org.apache.storm.hdfs.bolt.format.DefaultFileNameFormat;
import org.apache.storm.hdfs.bolt.format.DelimitedRecordFormat;
import org.apache.storm.hdfs.bolt.format.FileNameFormat;
import org.apache.storm.hdfs.bolt.format.RecordFormat;
import org.apache.storm.hdfs.bolt.rotation.FileRotationPolicy;
import org.apache.storm.hdfs.bolt.rotation.TimedRotationPolicy;
import org.apache.storm.hdfs.bolt.sync.CountSyncPolicy;
import org.apache.storm.hdfs.bolt.sync.SyncPolicy;
import org.apache.storm.hdfs.common.rotation.MoveFileAction;
import org.apache.storm.spout.SpoutOutputCollector;
import org.apache.storm.task.OutputCollector;
import org.apache.storm.task.TopologyContext;
import org.apache.storm.topology.OutputFieldsDeclarer;
import org.apache.storm.topology.TopologyBuilder;
import org.apache.storm.topology.base.BaseRichBolt;
import org.apache.storm.topology.base.BaseRichSpout;
import org.apache.storm.tuple.Fields;
import org.apache.storm.tuple.Tuple;
import org.apache.storm.tuple.Values;

public class HdfsFileTopology {
    static final String SENTENCE_SPOUT_ID = "sentence-spout";
    static final String BOLT_ID = "remay-bolt";
    static final String TOPOLOGY_NAME = "test-topology";

	public static void main(String[] args) throws Exception 
	{
        /* args[0] = "hdfs://remayhdp06.localdomain:8020" */
		/* args[1] = "/user/root/treinamento_storm/" */

		String hdfsNameNode = args[0];
		String hdfsPath = args[1];
        		
		Config config = new Config();
        config.setNumWorkers(1);

        SentenceSpout spout = new SentenceSpout();
        SyncPolicy syncPolicy = new CountSyncPolicy(1000);

        FileRotationPolicy rotationPolicy = new TimedRotationPolicy(1.0f, TimedRotationPolicy.TimeUnit.MINUTES);

        FileNameFormat fileNameFormat = new DefaultFileNameFormat()
        		.withPath(hdfsPath) /* /user/root/treinamento_storm/ */                
                .withExtension(".txt");
     
        RecordFormat format = new DelimitedRecordFormat().withFieldDelimiter("|");


        HdfsBolt bolt = new HdfsBolt()
        		.withFsUrl(hdfsNameNode)
                .withFileNameFormat(fileNameFormat)
                .withRecordFormat(format)
                .withRotationPolicy(rotationPolicy)
                .withSyncPolicy(syncPolicy)
                .addRotationAction(new MoveFileAction().toDestination(hdfsPath));

        TopologyBuilder builder = new TopologyBuilder();

        builder.setSpout(SENTENCE_SPOUT_ID, spout, 1);
        // SentenceSpout --> MyBolt
        builder.setBolt(BOLT_ID, bolt, 4).shuffleGrouping(SENTENCE_SPOUT_ID);

        final LocalCluster cluster = new LocalCluster();
        
        System.out.println("argumentos: " + args.length);
        
        if (args.length == 2) 
        {
        	cluster.submitTopology(TOPOLOGY_NAME, config, builder.createTopology());
        	waitForSeconds(120);
        
            System.exit(0);
        } else if (args[1].equals("servidor") && args.length == 3) 
        {
            StormSubmitter.submitTopology(args[2], config, builder.createTopology());
        } else
        {
            System.out.println("Usage: HdfsFileTopology [hdfs url] [submit-topology-localorservidor] <topology name> <hdfsNameNode> <hdfsPath>");
        }
    }

    public static void waitForSeconds(int seconds) {
        try {
            Thread.sleep(seconds * 1000);
        } catch (InterruptedException e) {
        }
    }

    /***
     * 
     * @author Remay
     * Classe responsavel pela criacao do Spout e suas configuracoes
     *
     */
    @SuppressWarnings("serial")
	public static class SentenceSpout extends BaseRichSpout {
        private ConcurrentHashMap<UUID, Values> pending;
        private SpoutOutputCollector collector;
        private String[] sentences = {
                "processamento em streaming com storm",
        		"remay, bi e big data",
                "apache storm para processamento em tempo real",
                "teste realizado em apache storm",
                "qualidade da informacao e o caminho",
                "veracidade e velocidade na informacao"
        };
        private int index = 0;
        private int count = 0;
        private long total = 0L;

        public void declareOutputFields(OutputFieldsDeclarer declarer) {
            declarer.declare(new Fields("sentence", "timestamp"));
        }

        @SuppressWarnings("rawtypes")
		public void open(Map config, TopologyContext context,
                         SpoutOutputCollector collector) {
            this.collector = collector;
            this.pending = new ConcurrentHashMap<UUID, Values>();
        }

        public void nextTuple() 
        {
            Values values = new Values(sentences[index], System.currentTimeMillis());
            UUID msgId = UUID.randomUUID();
            this.pending.put(msgId, values);
            this.collector.emit(values, msgId);
            index++;
            if (index >= sentences.length) {
                index = 0;
            }
            count++;
            total++;
            if(count > 20000){
                count = 0;
                System.out.println("Pending count: " + this.pending.size() + ", total: " + this.total);
            }
            Thread.yield();
        }

        public void ack(Object msgId) {
            this.pending.remove(msgId);
        }

        public void fail(Object msgId) {
            System.out.println("**** RESENDING FAILED TUPLE");
            this.collector.emit(this.pending.get(msgId), msgId);
        }
    }

    /***
     * 
     * @author Remay
     * Classe responsavel pela criacao do Bolt e suas configuracoes
     *
     */
    @SuppressWarnings("serial")
	public static class MyBolt extends BaseRichBolt {

        @SuppressWarnings("unused")
		private HashMap<String, Long> counts = null;
        private OutputCollector collector;

        @SuppressWarnings("rawtypes")
		public void prepare(Map config, TopologyContext context, OutputCollector collector) {
            this.counts = new HashMap<String, Long>();
            this.collector = collector;
        }

        public void execute(Tuple tuple) {
            collector.ack(tuple);
        }

        public void declareOutputFields(OutputFieldsDeclarer declarer) {
            // this bolt does not emit anything
        }

        @Override
        public void cleanup() {
        }
    }
}
