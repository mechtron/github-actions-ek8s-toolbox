# github-actions-ek8s-toolbox

This action sets up awscli & helm so you can deploy to EKS easily.

## Inputs

### `command`

The helm command to run  
**Required**

### `eksClusterName`

Name of the EKS cluster you want to deploy to  
**Required**

### `helmVersion`

helm version to install, for example 2.12.1  
default: "2.16.1"

### `awsAccessKeyId`

Your AWS access key id to get cluster context  
**Required**

### `awsSecretAccessKey`

Your AWS Secret access key to get cluster context  
**Required**

### `awsDefaultRegion`

Your AWS region to get cluster context  
default: "eu-west-1"

## Usage

```yaml
uses: actions/github-actions-ek8s-toolbox@v1
with:
  eksClusterName: 'example'
  helmVersion: '2.15.1'
  awsAccessKeyId: 'AKIA3EXAMPLEY3X4MPLE'
  awsSecretAccessKey: '3X4MPLEiHm3X4MPLEXWev3X4MPLEp1UmE3X4MPLE'
  awsDefaultRegion: 'eu-west-1'
  command: |
    echo "Linting charts ..."
    helm lint charts/
```
