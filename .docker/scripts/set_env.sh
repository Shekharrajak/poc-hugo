#!/bin/bash

# tried setting env while running dockerfile but not working. It is
# not taking variable values during dockerfile execution
export TRAVIS_REPO_SLUG=${TRAVIS_REPO_SLUG}
export TRAVIS_PULL_REQUEST=${TRAVIS_PULL_REQUEST}
export TRAVIS_TAG=${TRAVIS_TAG}
export TRAVIS_BRANCH=${TRAVIS_BRANCH}
export GITHUB_API_TOKEN=${GITHUB_API_TOKEN}
export SURGE_TOKEN=${SURGE_TOKEN}
export SURGE_LOGIN=${SURGE_LOGIN}
