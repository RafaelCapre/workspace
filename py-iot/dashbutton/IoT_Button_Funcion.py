import json
import boto3
from botocore.exceptions import ClientError
import os
import logging

# Logging Configuration
logger = logging.getLogger()
logger.setLevel(logging.INFO)
logging.getLogger('boto3').setLevel(logging.WARNING)
logging.getLogger('botocore').setLevel(logging.WARNING)

# AWS Services
sns = boto3.client('sns')
sqs = boto3.client('sqs')

# Lambda Variables
LOG_LEVEL = os.getenv("LOG_LEVEL", "INFO")
SNS_TOPIC = os.environ['SNS_TOPIC']
SQS_QUEUE_URL = os.environ['SQS_QUEUE_URL']


if LOG_LEVEL == 'DEBUG':
    logger.setLevel(logging.DEBUG)

def get_sqs_approximate_number_of_messages():
    number_of_messages = sqs.get_queue_attributes(
        QueueUrl=SQS_QUEUE_URL,
        AttributeNames=[
            'ApproximateNumberOfMessages'
            ]
    )
    number_of_messages = number_of_messages['Attributes']['ApproximateNumberOfMessages']
    return number_of_messages


def publish_message_to_sns(message):
    response = sns.publish(
        TopicArn=SNS_TOPIC,
        Message=message,
        Subject='Process status',
    
    )
    logger.debug("Message sent to SNS.")



def button_single_click(button_click_type):
    logger.debug("Button click type: '{}'".format(button_click_type))
    number_of_files = get_sqs_approximate_number_of_messages()
    message = "Number of files to process is: '{}'".format(number_of_files)
    logger.debug("Number of files to process is: '{}'".format(number_of_files))
    return (number_of_files)


def lambda_handler(event, context):
    logger.debug("Received event is: '{}'".format(event))
    
    button_click_type = event['clickType']
    
    if button_click_type == 'SINGLE':
        number_of_files = button_single_click(button_click_type)
        message = "You have '{}' files to process".format(number_of_files)
        publish_message_to_sns(message)
        return ("You have '{}' files to process".format(number_of_files))
    
    if button_click_type == 'DOUBLE':
        button_double_click(button_click_type)
    
    if button_click_type == 'LONG':
        button_long_click(button_click_type)
    
    
    return 'Done'