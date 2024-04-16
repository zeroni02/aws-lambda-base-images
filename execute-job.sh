#!/bin/bash

export CONTAINER_TASK_ID=$(curl -s ${ECS_CONTAINER_METADATA_URI}/task | jq -r '.TaskARN | split("/") | .[2]')

# Lambdaに併せてログ関連の環境情報をセット
echo TAIAS_IF_LOG_GROUP_NAME $TAIAS_IF_LOG_GROUP_NAME 1>&2;
export AWS_LAMBDA_LOG_GROUP_NAME=$TAIAS_IF_LOG_GROUP_NAME
echo TAIAS_IF_LOG_STREAM_PREFIX $TAIAS_IF_LOG_STREAM_PREFIX 1>&2;
export AWS_LAMBDA_LOG_STREAM_NAME=${TAIAS_IF_LOG_STREAM_PREFIX}/${CONTAINER_TASK_ID}
echo AWS_LAMBDA_LOG_STREAM_NAME $AWS_LAMBDA_LOG_STREAM_NAME 1>&2;
# function.shのダウンロード
echo TAIAS_IF_FUNCTION_SH_S3_URL $TAIAS_IF_FUNCTION_SH_S3_URL 1>&2;
time aws s3 cp $TAIAS_IF_FUNCTION_SH_S3_URL /tmp/function.sh 1>&2;

# Lambda同等のEventJSONを作る
EVENT_DATA=$(echo {} | jq --arg tenantId $1 '.tenantId = $tenantId' | jq --arg boxId $2 '.boxId = $boxId' | jq --arg launchUnitJobId $3 '.launchUnitJobId = $launchUnitJobId' | jq --arg ifId $4 '.ifId = $ifId' | jq --arg ifVersion $5 '.ifVersion = $ifVersion' | jq --arg ifJobId $6 '.ifJobId = $ifJobId' | jq --arg confidentialMode $7 '.confidentialMode = $confidentialMode')
echo $EVENT_DATA 1>&2;

# handlerの実行
source /tmp/function.sh
RESPONSE=$(handler "$EVENT_DATA")
echo RESPONSE $RESPONSE 1>&2;

#Lambdaのレスポンスと形式を合わせる
PAYLOAD=$(echo {} | jq --argjson response $RESPONSE '.Payload = $response')
echo PAYLOAD $PAYLOAD 1>&2;

TASKTOKEN=$8
echo TASKTOKEN $TASKTOKEN 1>&2;

# StepFunctionsにレスポンスを渡す
aws stepfunctions send-task-success --task-token $TASKTOKEN --task-output "$PAYLOAD"
