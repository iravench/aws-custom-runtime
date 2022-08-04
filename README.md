### Create layers

publish both zip files under ./layers with command similar to bellow

```bash
aws lambda publish-layer-version --layer-name bash-runtime --zip-file fileb://runtime.zip 
```

then update template.yaml -> Layers to point to the above published layers' arn

mysql-layer is to provide mysql client commands
runtime is to bootstrap and allow the bash funtion to be executed, see ./runtime/boostrap

### Test locally with SAM cli

follow https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install-linux.html to install SAM cli

Modify/complete ./functions/mysqldump/function.sh to your liking

now you can

```bash
# build artifacts
sam build

# test run the function locally via docker container
sam local invoke MySQLDumpFunction --parameter-overrides Uhostname=127.0.0.1 Udbname=tmp Uusername=root Upassword=123
```
