# README

## Create layers

publish both zip files under ./layers with command similar to bellow

```bash
aws lambda publish-layer-version --layer-name bash-runtime --zip-file fileb://runtime.zip 
aws lambda publish-layer-version --layer-name mysql-layer --zip-file fileb://mysql-8.0.28-layer.zip 
```

runtime is the layer that bootstraps and runs the user bash funtions, see source code ./runtime/boostrap
and mysql-layer is what provides mysql client commands, i.e. `mysql -u ...` etc.

see [details](https://docs.aws.amazon.com/en_us/lambda/latest/dg/runtimes-walkthrough.html)

## Test locally with SAM cli

follow [the instructions](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install-linux.html) to install SAM cli

Modify/complete ./functions/mysqldump/function.sh to your liking

now you can

```bash
# build artifacts
sam build

# test run the function locally via docker container
sam local invoke MySQLDumpFunction \
  --parameter-overrides \
    TargetHost="127.0.0.1" TargetDb=tmp_uat TargetUser=root TargetPassword="123" \
    SourceHost="127.0.0.1" SourceDb=tmp_prod SourceUser=root SourcePassword="123" \
```

## package

...

## deployment

...
