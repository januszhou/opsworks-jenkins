require 'rubygems'
require 'json'

result = `aws opsworks --region us-east-1 describe-stack-summary --stack-id 582fe17a-020f-44e9-9af6-57935f97d016`

summary = JSON.parse(result)
status = summary['StackSummary']['InstancesCount']

def createLoadBasedInstance()
    result = `aws opsworks --region us-east-1 create-instance --stack-id 582fe17a-020f-44e9-9af6-57935f97d016 --layer-id e13e9dfd-4b78-4736-8e9a-429ca8310749 --instance-type t2.micro --auto-scaling-type load --os "Ubuntu 14.04 LTS" --ssh-key-name "CodeDeploy-server"`
    json = JSON.parse(result)
    if json['InstanceId']
        return true
    else
        return false
    end
end

if status['Stopped'] == nil
    createLoadBasedInstance()
    puts "Create new load based instance"
else 
    puts "Already has #{status['Stopped']} stopped load instances, no need for new one"
end

