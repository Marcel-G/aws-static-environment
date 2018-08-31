# AWS static environment

Easily create production ready AWS environments for hosting static files.

Using CloudFormation, the following resources are created for the stack:
- **LogBucket** - S3 bucket for storing bucket & CDN logs
- **RootBucket** - S3 bucket to store website files
- **RedirectBucket** & **RedirectDistribution** - for redirecting traffic from *.domain.com to the root domain.
- **WebsiteCDN** - Main CloudFront distribution
- **StackUser** & **DeploymentKey** - A user is created for the stack and a key is created to use for deployments

![AWS CloudFormation Stack Diagram](https://raw.githubusercontent.com/Marcel-G/aws-static-environment/master/assets/stack-diagram.png)


# How to use

## Prerequisite
  - Configure [AWS CLI](https://aws.amazon.com/cli)

## Running with npm

Add the following scripts to `package.json`
```
...
"scripts": {
    "aws:create-stack": "./aws-static-environment/create-stack.sh",
    "aws:stack-info": "./aws-static-environment/stack-info.sh",
    ...
```

Create a new environment:
```
npm run aws:create-stack -- <domain> <environment>
```

Get the stack info
```
npm run aws:stack-info -- <environment>
```

## Without npm

The project name should also be provided when not running with npm.
```
./aws-static-environment/create-stack.sh <domain> <environment> <project name>
```
```
./aws-static-environment/stack-info.sh <environment> <project name>
```
