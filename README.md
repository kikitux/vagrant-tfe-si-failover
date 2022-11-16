#

![diagram](https://raw.githubusercontent.com/kikitux/vagrant-tfe-si-failover/main/diagram/diagram.png)

## pre-req

- virtualbox
- vagrant
- copy `license.rli` to this folder

## How this works

On mounted disk installation, replicated will generate a database password for internal user `hashicorp`.
To be able to mount the same mounted disk on a different TFE, we need to seed this password to replicated

```
    "generated_postgres_password": {
        "value": "Password1#"        
    }
```

In this example, we seed the same value to the original TFE, so is a known value for our lab.


## How to use

- clone

```
git clone https://github.com/kikitux/vagrant-tfe-si-failover
```

- change directory

```
cd vagrant-tfe-si-failover
```

### Passwords

all the passwords used here are `Password1#`


### Scenario 1, same VM

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



### Scenario 2, different VM

This is to test clone disk from vm1 to vm2
hostname/ip will be different


- 
```
vagrant up
```

- 
```
vagrant suspend vm1
```

- 
```
vagrant up vm2
```

-
```
vagrant destroy vm2
```

- 
```
vagrant resume vm1
```
