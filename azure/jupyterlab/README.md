# Create jupyterlab instances for jupyterhub to use

For more on user-data, custom data and cloud-init on Microsoft Azure go [here](https://azure.microsoft.com/en-gb/blog/custom-data-and-cloud-init-on-windows-azure/)

## About mounting samba shares

If you want this machine to mount samba shares, this module expects mount credentials and filesystem declaration to be in azure blob store this machine has access to
mount credentials == <mount>.cred file should be:

```text
username=<username>
password=<password>
```

mount fs == <mount>.fs file should be:

```text
[Unit]
Description=<mount> samba share on Azure

[Mount]
What=//<mount>.file.core.windows.net/<folder in mount>
Where=/mnt/<mount>
Options=nofail,vers=3.0,credentials=/etc/smbcredentials/<mount>.cred,dir_mode=0777,file_mode=0777,serverino,x-systemd.automount
Type=cifs
TimeoutSec=30

[Install]
WantedBy=multi-user.target
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| azurerm | =2.2.0 |
| random | ~> 2.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| admin\_user | name of the admin user for this instance | `string` | n/a | yes |
| admin\_user\_public\_ssh\_key | public ssh key for the admin user | `string` | n/a | yes |
| csv\_mounts | comma-separated list of samba mounts this machine has access to | `string` | `""` | no |
| environment | See [Sysenvs shortname](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md#short-name-aka-dcvpc-name) | `string` | n/a | yes |
| namespace | Prefix to use with all tag keys | `string` | n/a | yes |
| prompt\_color | Color to use for the shell prompt | `string` | n/a | yes |
| resource\_group\_name | Resource Group to use for these resources. [What is a Resource Group?](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-setup-guide/organize-resources?tabs=AzureManagmentGroupsAndHierarchy) | `string` | n/a | yes |
| subnet\_name | Azure subnet where the VM will be located at | `string` | n/a | yes |
| sysenv | See [System Environments (SysEnvs)](https://github.com/nxtlytics/ivy-documentation/blob/master/howto/Architecture/Specifications_and_Definitions/System_Environments_SysEnvs.md) | `string` | n/a | yes |
| tags | A mapping of tags to assign to the resources in this module. | `map` | `{}` | no |
| team\_email | E-Mail for the team managing these resources | `string` | n/a | yes |
| virtual\_network\_name | Azure virtual network where the VM will be located at | `string` | n/a | yes |
| vm\_size | The SKU which should be used for this Virtual Machine, such as `Standard_F2` | `string` | `"Standard_D4a_v4"` | no |
| vpn\_supernet | CIDR all client\_subnets are a part of | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| azurerm\_linux\_virtual\_machine-this-fqdn | Fully Qualified Domain Name of this Virtual Machine |
| azurerm\_linux\_virtual\_machine-this-id | ID for this virtual machine |
| azurerm\_linux\_virtual\_machine-this-location | Location of this Virtual Machine |
| azurerm\_linux\_virtual\_machine-this-name | Computer Name of this Virtual Machine |
| azurerm\_linux\_virtual\_machine-this-private\_ipv4 | Private IPv4 of this Virtual Machine |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Related links

- [Automount SMB directory with systemd in Arch](https://www.antoniojgutierrez.com/2018/04/09/automounting_systemd.html)
