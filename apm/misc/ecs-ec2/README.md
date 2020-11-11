# Splunk APM Trace Generator Demo For AWS ECS EC2

This repo demonstrates a reference implemenation for a single AWS ECS EC2 task example of Splunk APM.

The single task spins up two ECS containers on EC2:

#1 splk-agent - sidecar to observe ECS and relay traces to Splunk SignalFx   
#2 trace-generator - generates traces using Python Requests doing GET requests to https://api.github.com

### SETUP

#### Example of stock SignalFx Agent Setup in AWS ECS EC2 (Not APM Ready)

[AWS ECS CLI](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_CLI.html) must be installed for these examples.

Pay critical attention to setting up:  
VPC: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definitions.html  
Log Environment: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_cloudwatch_logs.html  

To set up a SignalFx SmartAgent container in ECS:

(Adjust values to match your environment)  

Configure ECS Cluster:  
```
ecs-cli configure \
--cluster test-cluster-ec2 \
--default-launch-type EC2 \
--config-name test-cluster-ec2 \
--region YOURREGIONHEREi.e.us-east-1
```

Configure ECS CLI Profile:  
```
ecs-cli \
configure profile \
--access-key YOURAWSKEYHERE \
--secret-key YOURAWSSECRETKEYHERE \
--profile-name ecs-ec2-profile
```

Deploy ECS EC2 VM:  
```
ecs-cli up \
--keypair YOURAWSEC2KEYPAIRNAMEHERE \
--capability-iam --size 2 \
--instance-type t2.medium \
--cluster-config test-cluster-ec2 \
--ecs-profile ecs-ec2-profile \
--port 9080
```

Register your ECS EC2 tasks:

Deploy with the following commands- *you must change the variables in caps in these task .json files to suit your environment:*

RELEASEVERSIONHERE: Use the current SignalFx SmartAgent version in the Helm script below from here: https://github.com/signalfx/signalfx-agent/releases i.e. 5.5.5

`aws ecs register-task-definition --cli-input-json file://splk-agent-task.json`

Make sure to change the AWS REGION and then:

`aws ecs register-task-definition --cli-input-json file://trace-generator-ecs.json`

Note that the task definition will increment each time you try it- from 1 to 2 etc. To check which version is current use:  
`aws ecs list-task-definitions`

Deploy agent task to cluster:

```
aws ecs create-service \
--cluster test-cluster-ec2 \
--task-definition splk-agent:1 \
--service-name splk-agent-ec2 \
--scheduling-strategy DAEMON
```

Deploy trace generator task to cluster:

```
aws ecs create-service \
--cluster test-cluster-ec2 \
--task-definition trace-generator:1 \
--service-name trace-generator-ec2 \
--scheduling-strategy DAEMON
```

Check processes:

`ecs-cli ps --cluster-config test-cluster-ec2 --ecs-profile ecs-ec2-profile`

At this point you should see your Splunk SignalFx ECS Container:

<img src="../../../../assets/ecs-metrics.png" width="360" /> 

And your trace-generator generating traces:

<img src="../../../../assets/ecs-trace-generator.png" width="360" /> 

Cleanup:  
`aws ecs delete-service --cluster test-cluster-ec2 --service splk-agent-ec2 --force`
`aws ecs delete-service --cluster test-cluster-ec2 --service trace-generator-ec2 --force` 
`ecs-cli down --cluster test-cluster --region YOURREGIONHEREi.e.us-east-1` 

### Extras

The [commands.md](./commands.md) file offers helpful commands for ECS Fargate management for the AWS CLI.
