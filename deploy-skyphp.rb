result = `aws opsworks --region us-east-1 create-deployment --stack-id 582fe17a-020f-44e9-9af6-57935f97d016 --app-id c2f497dc-5434-4564-8069-faa9ff204068 --command '{\"Name\":\"deploy\"}'`
puts result
