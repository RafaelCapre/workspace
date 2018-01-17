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
autoscaling = boto3.client('autoscaling')

# Lambda Variables
LOG_LEVEL = os.getenv("LOG_LEVEL", "INFO")
SNS_TOPIC_ARN = os.environ['SNS_TOPIC_ARN']
SQS_QUEUE_URL = os.environ['SQS_QUEUE_URL']
AUTO_SCALING_GROUP = os.environ['AUTO_SCALING_GROUP']


if LOG_LEVEL == 'DEBUG':
    logger.setLevel(logging.DEBUG)

def datetime_handler(x):
    if isinstance(x, datetime.datetime):
        return x.isoformat()
    raise TypeError("Unknown type")


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
        TopicArn=SNS_TOPIC_ARN,
        Message=message,
        Subject='Process status',

    )


def check_desired_capacity():
    response = autoscaling.describe_auto_scaling_groups(
        AutoScalingGroupNames=[
            AUTO_SCALING_GROUP
        ]
    )
    asg_desired_capacity = json.dumps(response['AutoScalingGroups'][0]['DesiredCapacity'], default=datetime_handler)
    return (asg_desired_capacity)

def increase_desired_capacity(previous_desired_capacity):
    new_capacity = int(previous_desired_capacity) + 1
    response = autoscaling.set_desired_capacity(
        AutoScalingGroupName=AUTO_SCALING_GROUP,
        DesiredCapacity=new_capacity
    )
    logger.debug(response)
    return(new_capacity)


def lambda_handler(event, context):
    logger.debug("Received event is: '{}'".format(event))

    button_click_type = event['clickType']

    if button_click_type == 'SINGLE':
        number_of_files = get_sqs_approximate_number_of_messages()
        message = "You have '{}' files to process".format(number_of_files)
        publish_message_to_sns(message)
        return 'Done'

    if button_click_type == 'DOUBLE':
        asg_desired_capacity = check_desired_capacity()
        message = "Number of running instances is: '{}'".format(asg_desired_capacity)
        publish_message_to_sns(message)
        return ("Number of running instances is: '{}'".format(asg_desired_capacity))


    if button_click_type == 'LONG':
        previous_desired_capacity = check_desired_capacity()
        new_desired_capacity = increase_desired_capacity(previous_desired_capacity)
        message = "You had '{}' instances running. The new running instances number is '{}'".format(previous_desired_capacity, new_desired_capacity)
        publish_message_to_sns(message)
        return ("You had '{}' instances running. The new running instances number is '{}'".format(previous_desired_capacity, new_desired_capacity))


    return 'Done'
