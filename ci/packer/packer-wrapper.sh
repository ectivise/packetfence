#!/bin/bash
set -o nounset -o pipefail -o errexit

configure_and_check() {
    GOVERSION=${GOVERSION:-}
    REGISTRY=${REGISTRY:-docker.io}
    REGISTRY_USER=${REGISTRY_USER:-inverseinc}
    ANSIBLE_FORCE_COLOR=${ANSIBLE_FORCE_COLOR:-1}
    ANSIBLE_CENTOS_GROUP=${ANSIBLE_CENTOS_GROUP:-devel_centos}
    ANSIBLE_CENTOS7_GROUP=${ANSIBLE_CENTOS7_GROUP:-devel_centos7}
    ANSIBLE_CENTOS8_GROUP=${ANSIBLE_CENTOS8_GROUP:-devel_centos8}
    ANSIBLE_DEBIAN_GROUP=${ANSIBLE_DEBIAN_GROUP:-devel_debian}
    ANSIBLE_RUBYGEMS_GROUP=${ANSIBLE_RUBYGEMS_GROUP:-devel_rubygems}
    ACTIVE_BUILDS=${ACTIVE_BUILDS:-'pfbuild-centos-7,pfbuild-centos-8,pfbuild-stretch,pfbuild-buster'}
    PARALLEL=${PARALLEL:-2}
    PACKER_TEMPLATE=${PACKER_TEMPLATE:-pfbuild.json}

    declare -p GOVERSION
    declare -p REGISTRY REGISTRY_USER 
    declare -p ANSIBLE_FORCE_COLOR ANSIBLE_CENTOS_GROUP ANSIBLE_CENTOS7_GROUP
    declare -p ANSIBLE_CENTOS8_GROUP ANSIBLE_DEBIAN_GROUP ANSIBLE_RUBYGEMS_GROUP
    declare -p PACKER_TEMPLATE
    
    # Docker tags
    DOCKER_MAIN_TAG=${DOCKER_MAIN_TAG:-}
    DOCKER_EXTRA_TAG=${DOCKER_EXTRA_TAG:-}
    CI_COMMIT_TAG=${CI_COMMIT_TAG:-}

    # extra tag is added when we release to avoid creating two images
    if [ -n "$CI_COMMIT_TAG" ]; then
        echo "Release tag detected, adding maintenance tag"
        DOCKER_MAIN_TAG="${CI_COMMIT_TAG}"
        DOCKER_EXTRA_TAG=$(generate_maintenance_tag)
    else
        echo "Not a release, no need to generate additionnal Docker tag"
    fi
    declare -p CI_COMMIT_TAG DOCKER_MAIN_TAG DOCKER_EXTRA_TAG
    export GOVERSION
    export CI_COMMIT_TAG DOCKER_MAIN_TAG DOCKER_EXTRA_TAG
    export REGISTRY REGISTRY_USER
    export ANSIBLE_FORCE_COLOR ANSIBLE_CENTOS_GROUP ANSIBLE_CENTOS7_GROUP
    export ANSIBLE_CENTOS8_GROUP ANSIBLE_DEBIAN_GROUP ANSIBLE_RUBYGEMS_GROUP
}

# we use this logic to simplify definition of maintenance CI jobs based
# on their branch name using CI_COMMIT_REF_SLUG
generate_maintenance_tag() {
    # pf_release_rev contains X.Y
    local pf_release_rev=$(perl -ne 'print $1 if (m/.*?(\d+\.\d+)./)' ../../conf/pf-release)
    # generated tag is maintenance-X-Y
    echo "maintenance-${pf_release_rev/./-}"
}

run_packer() {
    local pkr_template=${1}
    packer validate ${pkr_template}
    local pkr_command="packer build -only=${ACTIVE_BUILDS} -parallel-builds=${PARALLEL} ${pkr_template}"
    echo "${pkr_command}"
    ${pkr_command}
}

configure_and_check
run_packer ${PACKER_TEMPLATE}
