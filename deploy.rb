require 'rubygems'
require 'json'
require 'trollop'

appsQuery = `aws opsworks --region us-east-1 describe-apps --stack-id 582fe17a-020f-44e9-9af6-57935f97d016`


opts = Trollop::options do
    opt :app, "App name", :type => :string
end

result = JSON.parse(appsQuery)
apps = result['Apps']
appNames = {}

def deploy(appId)
    result = `aws opsworks --region us-east-1 create-deployment --stack-id 582fe17a-020f-44e9-9af6-57935f97d016 --app-id #{appId} --command '{\"Name\":\"deploy\"}'`
    puts result
end

apps.each do |app|
    appNames[app['Name']] = app['AppId']
end

if opts[:app] == 'ALL'
    appNames.each do |appName, appId|
        deploy(appId)
    end
else
    if !appNames[opts[:app]].nil?
        deploy(appNames[opts[:app]])
    else
        puts "APP #{opts[:app]} not exists"
    end
end

