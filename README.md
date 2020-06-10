# GilmanLab Images

This repository provides the Packer and Ansible configurations for generating the base images used to deploy
infrastructure for GilmanLab.

## Usage

All configured images can be built and uploaded to vSphere by running the build script:

```bash
$> ./build.sh
```

Alternatively, individual images can be built by invoking packer directly:

```bash
$> packer build -var-file=vars.common.json -var-file=kube/vars.json -force -on-error=ask kube/build.json
```

### Environment

Running Packer requires the following environment variables to be configured correctly:

* `VAULT_ADDR`: The URL for the Vault server.
* `VAULT_TOKEN`: A valid Vault token with permissions to read the following secrets:
  * `secret/packer/base`
  * `secret/vsphere/api`
  * `secret/ssh/config/ca`
  * `secret/user/josh`
  
## Images

The current configured images are:

* `ubuntu18044`: A base Ubuntu installation for running virtualized services (i.e. game server)
* `kube`: A base Ubuntu image optimized for running as a Kubernetes node

### Adding images

Most images should be able to derive their variables from `vars.common.json`. It includes the details for connecting 
to vSphere and provides sane defaults for most hardware configuration. Since hardware is generally changed during the
deployment process, it's typically unnecessary to modify these values. New images should follow this format:

* `image_name`
  * `build.json`: The primary build script passed to Packer
  * `preseed.cfg`: A Ubuntu preseed file for generating the base image
  * `vars.json`: Additional variables not defined in `vars.common.json`
  
Once the new image is configured it should be added to `build.sh` and this README. 