#

![diagram](https://raw.githubusercontent.com/kikitux/vagrant-tfe-si-failover/main/diagram/diagram.png)

## pre-req

- virtualbox ( tested with latest 7 )
- vagrant ( use vagrant 2.3.3 or higher on new macos with Virtualbox )
- copy `license.rli` to this folder

## What this does?

This is a simple lab for TFE that install Terraform Enterprise on vm1 as mounted disk.
And allow test the 2 scenarios of recovery.

- reinstall on same vm
- failover to a new vm with a copy of `mounted disk`

## Monitoring

Each tfe instance have `netdata` install on port `19999`

## How this works?

On mounted disk installation, replicated will generate a database password for internal user `hashicorp`.
To be able to mount the same mounted disk on a different TFE, we need to seed this password to replicated

```
    "generated_postgres_password": {
        "value": "Password1#"        
    }
```

When `vm1` is started, we use Virtualbox to create a mounted disk

When `vm2` is started, we use Virtualbox clone medium to duplicate the mounted disk from `vm1`

In this example, [we seed the same value to the original TFE](https://github.com/kikitux/vagrant-tfe-si-failover/blob/94c2d5d30c8d675bddd081dd251196590f481b78/scripts/config_replicated.sh#L30-L32), so is a known value for our lab.


## How to use

- clone

```
git clone https://github.com/kikitux/vagrant-tfe-si-failover
```

- change directory

```
cd vagrant-tfe-si-failover
```

- copy `license.rli`

```
cp <path>/license.rli license.rli
```

### Passwords

all the passwords used here are `Password1#`


# Scenario 1, same VM

-
```
vagrant ssh vm1
sudo su -
./uninstall.sh
exit
```

-
```
vagrant reload vm1 --provision
```



# Scenario 2, different VM

This is to test clone disk from vm1 to vm2
hostname/ip will be different


- start `vm1`

```
vagrant up
```

- wait until all privisioning completes

- suspend `vm1`
 
```
vagrant suspend vm1
```

- start `vm2`

```
vagrant up vm2
```

- wait until all provisioning completes

## How to go back to original state

- destroy `vm2`

```
vagrant destroy vm2
```

- start `vm1`

```
vagrant resume vm1
```

## How to destroy the vms

- vagrant destroy

```
vagrant destroy
```

