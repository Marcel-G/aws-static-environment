#!/bin/bash
rootDir="${0%/*}"

# Test to make sure variables are defined
: "${1:? domainName not set. create-stack <domainName> <environment> <?stackName>}"
: "${2:? environment not set. create-stack <domainName> <environment> <?stackName>}"

projectName=$3

if [ -z "$3" ]
then
    projectName=$npm_package_name
else
    projectName=$3
fi

: "${projectName:? stackName not provided. Run create-stack through npm or provide stackName as third arg.}"

stackName="$projectName-$2"
fullDomain="$2.$1"


read -p "Creating stack with the following details:
Stack name: $stackName
Domain: $fullDomain
Continue? (y/n)
" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    if
        aws cloudformation create-stack \
            --stack-name $stackName \
            --capabilities CAPABILITY_NAMED_IAM \
            --template-body file://$rootDir/resources-cloudformation.yml \
            --parameters \
                ParameterKey=RootDomainName,ParameterValue=$1 \
                ParameterKey=EnvironmentName,ParameterValue=$2 ;

    then 
        echo "Creating stack... (this can take several minutes)"
        aws cloudformation wait stack-create-complete --stack-name $stackName
        echo "Stack creation complete."
        sh $rootDir/stack-info.sh $2 $projectName
    else 
        echo "Could not create stack"
    fi
else 
    echo "Exiting..."
fi