# github-actions-ek8s-toolbox

This Github Action allows you to work with helm charts & AWS EKS with ease.

## Inputs

- `command`  
  The command(s) to run.  
  **Required**

- `eksClusterName`  
  Name of the EKS cluster operate on.  
  **Required**

- `awsAccessKeyId`  
  Your AWS access key id to get the cluster context.  
  **Required**

- `awsSecretAccessKey`  
  Your AWS Secret access key to get the cluster context.  
  **Required**

- `awsDefaultRegion`  
  Your AWS region to get the cluster context.  
  default: "eu-west-1"

- `helmVersion`  
  helm version to install.  
  default: "2.12.1"

- `helmfileVersion`  
  helmfile version to install.  
  default: "0.102.0"

- `kubectlVersion`  
  kubectl version to install.  
  default: "1.13.9"

- `istioctlVersion`  
  istioctl version to install.  
  default: "1.1.3"

- `kubevalVersion`  
  kubeval version to install.  
  default: "0.14.0"

## Usage

```yaml
- name: github-actions-ek8s-toolbox step
  uses: actions/github-actions-ek8s-toolbox@v1
  with:
    eksClusterName: 'example-cluster'
    awsAccessKeyId: 'AKIA3EXAMPLEY3X4MPLE'
    awsSecretAccessKey: '3X4MPLEiHm3X4MPLEXWev3X4MPLEp1UmE3X4MPLE'
    awsDefaultRegion: 'eu-west-1'
    helmVersion: '2.12.1'
    helmVersion: '0.102.0'
    kubectlVersion: '1.13.9'
    istioctlVersion: '1.1.3'
    kubevalVersion: '0.14.0'
    command: |
      echo "Just a test ..."
      aws --version
      helm version
      helmfile --version
      kubectl version
      istioctl version
      kubeval --version
```
