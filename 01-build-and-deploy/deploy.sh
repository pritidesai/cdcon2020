#!/usr/bin/env bash

#
# ARGS:
#   COMMAND (default is apply)
#

APPLY="apply"
DELETE="delete"
OPERATION=$APPLY

# Usage details is stored here
USAGE=$(cat <<-END
Usage:
    Environment Variables DOCKER_USERNAME and DOCKER_PASSWORD must be set.
    deploy.sh [-o $APPLY|$DELETE]
    Default: deploy.sh -o $APPLY
END
)

# Fail and display usage if DOCKER_USERNAME is not set in env.
if [[ -z $DOCKER_USERNAME ]]; then
    echo "$USAGE"
    exit 1
fi

# Fail and display usage if DOCKER_PASSWORD is not set in env.
if [[ -z $DOCKER_PASSWORD ]]; then
    echo "$USAGE"
    exit 1
fi

# Read the command line options and set appropriate arguments, including
# --operations|-o
while (( "$#" )); do
  case "$1" in
    -o|--operation)
      OPERATION=$2
      shift 2
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      echo $USAGE
      exit 1
      ;;
  esac
done

# validate operations specified in command line
if [ "$OPERATION" != "$APPLY" ] && [ "$OPERATION" != "$DELETE" ]; then
  echo "Invalid Operation: $OPERATION"
  echo "$USAGE"
  exit 1
fi

# Create a docker registry secret
sed -e 's/${DOCKER_USERNAME}/'"$DOCKER_USERNAME"'/' -e 's/${DOCKER_PASSWORD}/'"$DOCKER_PASSWORD"'/' docker-secret.yaml.tmpl > docker-secret.yaml
kubectl $OPERATION -f docker-secret.yaml
if [ "$OPERATION" = "$DELETE" ]; then
  rm docker-secret.yaml
fi

# Create a Service Account called cdcon-app-builder
kubectl $OPERATION -f service-account.yaml

# Create Persistent Volume
if [ "$OPERATION" != "$DELETE" ]; then
kubectl $OPERATION -f cdcon-workspace.yaml
fi

# Create Tasks
# Clone Application Source
kubectl $OPERATION -f tasks/00-git-clone.yaml
# Build Image
kubectl $OPERATION -f tasks/01-build-image.yaml
# Deploy
kubectl $OPERATION -f tasks/02-deploy.yaml


# Create Pipeline
kubectl $OPERATION -f pipelines/pipeline-build-image.yaml

# Run OpenWhisk Pipeline for NodeJS App after replacing DOCKER_USERNAME with user specified name
sed -e 's/${DOCKER_USERNAME}/'"$DOCKER_USERNAME"'/' use-case-1/pipelinerun.yaml.tmpl > use-case-1/pipelinerun.yaml
kubectl $OPERATION -f use-case-1/pipelinerun.yaml
if [ "$OPERATION" = "$DELETE" ]; then
  rm use-case-1/pipelinerun.yaml
fi
