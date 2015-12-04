require 'rubygems'
require 'json'

result = `aws opsworks --region us-east-1 create-deployment --stack-id 582fe17a-020f-44e9-9af6-57935f97d016 --command '{\"Name\":\"execute_recipes\", \"Args\":{\"recipes\":[\"deploy_setup::deploy\"]}}'`
puts result



