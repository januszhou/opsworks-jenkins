require 'rubygems'
require 'json'

result = `aws opsworks --region us-east-1 describe-instances --layer-id e13e9dfd-4b78-4736-8e9a-429ca8310749`

summary = JSON.parse(result)
instances = summary['Instances']

def createLoadBasedInstance()
    result = `aws opsworks --region us-east-1 create-instance --stack-id 582fe17a-020f-44e9-9af6-57935f97d016 --layer-id e13e9dfd-4b78-4736-8e9a-429ca8310749 --instance-type c3.large --auto-scaling-type load --os "Amazon Linux 2015.09" --ssh-key-name "CodeDeploy-server"`
    json = JSON.parse(result)
    if json['InstanceId']
        return true
    else
        return false
    end
end

# log online instance, log 
status = {'online' => 0,  'stopped' => 0}

for instance in instances
    if instance['Status'] == 'online'
        status['online'] += 1
    end

    if instance['Status'] == 'stopped'
        status['stopped'] += 1
    end
end

if status['stopped'] == 0
    createLoadBasedInstance()
    puts "Create new load based instance"
else 
    puts "Already has #{status['stopped']} stopped load instances, no need for new one"
end

