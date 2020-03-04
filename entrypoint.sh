#!/usr/bin/env bash
set -e
set -o pipefail

HOME="/root"
if [[ -z "${HELM_VERSION}" ]]; then HELM_VERSION="${INPUT_HELMVERSION}"; fi
if [[ -z "${HELMFILE_VERSION}" ]]; then HELMFILE_VERSION="${INPUT_HELMFILEVERSION}"; fi
if [[ -z "${ISTIOCTL_VERSION}" ]]; then ISTIOCTL_VERSION="${INPUT_ISTIOCTLVERSION}"; fi
if [[ -z "${KUBEVAL_VERSION}" ]]; then KUBEVAL_VERSION="${INPUT_KUBEVALVERSION}"; fi
if [[ -z "${KUBECTL_VERSION}" ]]; then KUBECTL_VERSION="${INPUT_KUBECTLVERSION}"; fi
if [[ -z "${AWS_ACCESS_KEY_ID}" ]]; then AWS_ACCESS_KEY_ID="${INPUT_AWSACCESSKEYID}"; fi
if [[ -z "${AWS_SECRET_ACCESS_KEY}" ]]; then AWS_SECRET_ACCESS_KEY="${INPUT_AWSSECRETACCESSKEY}"; fi
if [[ -z "${AWS_DEFAULT_REGION}" ]]; then AWS_DEFAULT_REGION="${INPUT_AWSDEFAULTREGION}"; fi
if [[ -z "${EKS_CLUSTER_NAME}" ]]; then EKS_CLUSTER_NAME="${INPUT_EKSCLUSTERNAME}"; fi

echo -e "\n\ngithub-actions-ek8s-toolbox: installing tools ..."
wget -qO helm-v${HELM_VERSION}-linux-amd64.tar.gz https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz &&
    tar xzf helm-v${HELM_VERSION}-linux-amd64.tar.gz &&
    mv linux-amd64/helm /usr/local/bin/helm &&
    chmod +x /usr/local/bin/helm &&
    rm -Rf linux-amd64/ helm-v${HELM_VERSION}-linux-amd64.tar.gz
helm init --client-only 1>/dev/null 2>&1
helm plugin install https://github.com/databus23/helm-diff --version master 1>/dev/null 2>&1

wget -qO helmfile https://github.com/roboll/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_linux_amd64 &&
    mv helmfile /usr/local/bin/helmfile &&
    chmod +x /usr/local/bin/helmfile

wget -qO istio-${ISTIOCTL_VERSION}-linux.tar.gz https://github.com/istio/istio/releases/download/${ISTIOCTL_VERSION}/istio-${ISTIOCTL_VERSION}-linux.tar.gz &&
    tar xzf istio-${ISTIOCTL_VERSION}-linux.tar.gz &&
    mv istio-${ISTIOCTL_VERSION}/bin/istioctl /usr/local/bin/istioctl &&
    chmod +x /usr/local/bin/istioctl &&
    rm -Rf istio-${ISTIOCTL_VERSION}/ istio-${ISTIOCTL_VERSION}-linux.tar.gz

wget -qO kubeval-linux-amd64.tar.gz https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz &&
    tar xzf kubeval-linux-amd64.tar.gz &&
    mv kubeval /usr/local/bin/kubeval &&
    chmod +x /usr/local/bin/kubeval &&
    rm -Rf kubeval-linux-amd64.tar.gz LICENCE README.md

wget -qO /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl &&
    chmod +x /usr/local/bin/kubectl
wget -qO /usr/local/bin/kubectx https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx &&
    chmod +x /usr/local/bin/kubectx
wget -qO /usr/local/bin/kubens https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens &&
    chmod +x /usr/local/bin/kubens

aws configure set aws_access_key_id "${AWS_ACCESS_KEY_ID}"
aws configure set aws_secret_access_key "${AWS_SECRET_ACCESS_KEY}"
aws configure set default.region "${AWS_DEFAULT_REGION}"
aws eks update-kubeconfig --name "${EKS_CLUSTER_NAME}"

echo -e "\n\ngithub-actions-ek8s-toolbox: executing command..."
bash -c "set -e; set -o pipefail; $1"
