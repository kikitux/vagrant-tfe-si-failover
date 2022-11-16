#

## pre-req

- copy `license.rli` to this folder

## How to use

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
