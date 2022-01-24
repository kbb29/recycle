stackname='recycle-classifier'
aws cloudformation create-stack --template-body "`cat ./cloudformation.yml`" --stack-name ${stackname} --capabilities CAPABILITY_NAMED_IAM
sagemakername=`aws cloudformation list-stack-resources --stack-name recycle-classifier | fgrep PhysicalResourceId | grep -oP '(?<=notebook-instance\/)recycleclassifier-[^"]+'`
sagemakerurl=`aws sagemaker describe-notebook-instance --notebook-instance-name ${sagemakername} | jq -r .Url`

url="https://${sagemakerurl}/tree/recycle"
if [[ $OSTYPE == 'darwin'* ]]; then
	echo "opening ${url}"
	open $url
elif [[ $OSTYPE == 'linux'* ]]; then
	echo "opening ${url}"
	xdg-open $url
else
	echo "please open ${url} in a browser"
fi




