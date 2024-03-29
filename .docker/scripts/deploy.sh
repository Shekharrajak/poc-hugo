#!/bin/bash

npm install -g surge

# trying setting env while script run but it is not taking travis
# env variables
# echo $pwd
# echo "Deploy script is about to run set_env script."
# sh set_env.sh
# echo "Deploy script has just run set_env script."

# Split on "/", ref: http://stackoverflow.com/a/5257398/689223
REPO_SLUG_ARRAY=${TRAVIS_REPO_SLUG//\// }
echo $TRAVIS_REPO_SLUG
REPO_OWNER=${REPO_SLUG_ARRAY[0]}
echo $REPO_OWNER
REPO_NAME=${REPO_SLUG_ARRAY[1]}
echo $REPO_NAME
DEPLOY_PATH=./public


DEPLOY_SUBDOMAIN_UNFORMATTED_LIST=()
if [ "$TRAVIS_PULL_REQUEST" != "false" ]
then
  DEPLOY_SUBDOMAIN_UNFORMATTED_LIST+=(pr-${TRAVIS_PULL_REQUEST})
fi

if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
    echo "Not a Pull Request. Skipping surge deployment"
    exit 0
fi

DEPLOY_DOMAIN=https://pr-${TRAVIS_PULL_REQUEST}-hugo.surge.sh
echo $DEPLOY_DOMAIN
surge --project ${DEPLOY_PATH} --domain $DEPLOY_DOMAIN;
if [ "$TRAVIS_PULL_REQUEST" != "false" ]
then
  # Using the Issues api instead of the PR api
  # Done so because every PR is an issue, and the issues api allows to post general comments,
  # while the PR api requires that comments are made to specific files and specific commits
  GITHUB_PR_COMMENTS=https://api.github.com/repos/${TRAVIS_REPO_SLUG}/issues/${TRAVIS_PULL_REQUEST}/comments
  echo $GITHUB_PR_COMMENTS
  curl -H "Authorization: token ${GITHUB_API_TOKEN}" --request POST ${GITHUB_PR_COMMENTS} --data '{"body":"Travis automatic deployment: '${DEPLOY_DOMAIN}'"}'
fi
