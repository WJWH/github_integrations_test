#!/bin/bash
REPO_URL=https://github.com/WJWH/github_integrations_test
TAG_PREFIX=ci-test-

commit_sha=$1 

# Clone repo and move to that place
git clone $REPO_URL clone_dirs/$commit_sha
cd $commit_sha

docker build -t test-registry:$TAG_PREFIX-$commit_sha .
