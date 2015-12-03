result = `aws opsworks --region us-east-1 create-deployment --stack-id 582fe17a-020f-44e9-9af6-57935f97d016 --app-id 7e98b351-4120-4e50-aab1-b17036958b43 --command '{\"Name\":\"deploy\"}'`
puts result
