package com.treinamento.kafka;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.clients.producer.ProducerRecord;

import java.util.Properties;
import java.util.Scanner;


public class Producer {
    private static Scanner in;
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public static void main(String[] argv)throws Exception {
        if (argv.length != 2) {
            System.err.println("Usage: %s <topicName> <kafkaBrokerIP:Port>");
            System.exit(-1);
        }
        String topicName = argv[0];
        String kafkaBrokerIP = argv[1];
        in = new Scanner(System.in);
        System.out.println("Informe Uma Mensagem (escreva exit para sair):");

        //Configure the Producer
        Properties configProperties = new Properties();
        configProperties.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG,kafkaBrokerIP);
        configProperties.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG,"org.apache.kafka.common.serialization.ByteArraySerializer");
        configProperties.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG,"org.apache.kafka.common.serialization.StringSerializer");

        KafkaProducer producer = new KafkaProducer(configProperties);
        String line = in.nextLine();
        while(!line.equals("exit")) {
            //TODO: Make sure to use the ProducerRecord constructor that does not take parition Id
            ProducerRecord<String, String> rec = new ProducerRecord<String, String>(topicName,line);
            producer.send(rec);
            line = in.nextLine();
        }
        in.close();
        producer.close();
    }
}