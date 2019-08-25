#!/bin/bash

npm install -g surge

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


for DEPLOY_SUBDOMAIN_UNFORMATTED in "${DEPLOY_SUBDOMAIN_UNFORMATTED_LIST[@]}"
do
  echo $DEPLOY_SUBDOMAIN_UNFORMATTED
  # replaces "/" or "." with "-"
  # sed -r is only supported in linux, ref http://stackoverflow.com/a/2871217/689223
  # Domain names follow the RFC1123 spec [a-Z] [0-9] [-]
  # The length is limited to 253 characters
  # https://en.wikipedia.org/wiki/Domain_Name_System#Domain_name_syntax
  DEPLOY_SUBDOMAIN=`echo "$DEPLOY_SUBDOMAIN_UNFORMATTED" | sed -r 's/[\/|\.]+/\-/g'`
  echo $DEPLOY_SUBDOMAIN
  DEPLOY_DOMAIN=https://${DEPLOY_SUBDOMAIN}-${REPO_NAME}-${REPO_OWNER}.surge.sh
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
done
