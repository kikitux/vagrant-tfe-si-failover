#

![diagram](https://raw.githubusercontent.com/kikitux/vagrant-tfe-si-failover/main/diagram/diagram.png)

## pre-req

- copy `license.rli` to this folder

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
