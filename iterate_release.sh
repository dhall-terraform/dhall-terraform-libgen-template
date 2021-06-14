#!/bin/bash
source ./lib-gen
for f in $(cat releases.yaml)
do
    DTF_PROVIDER_VERSION=$f
    generate_all && clean_leave_libs && \
    ./mkPackages.sh lib/registry.terraform.io/$DTF_SHORT_REPOSITORY_PATH/data_sources && \
    ./mkPackages.sh lib/registry.terraform.io/$DTF_SHORT_REPOSITORY_PATH/provider && \
    ./mkPackages.sh lib/registry.terraform.io/$DTF_SHORT_REPOSITORY_PATH/resources && \
    git add ./lib && \
    git ci -m $DTF_PROVIDER_VERSION && \
    git branch v$DTF_PROVIDER_VERSION && \
    git tag v$DTF_PROVIDER_VERSION && \
    clean_all
    clean_all
done
