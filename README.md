# rundeck-cookbook

Install and configure [Rundeck](http://www.rundeck.org)

## Supported Platforms

* Debian 7
* Ubuntu 14.04

## Attributes

* default['rundeck']['version'] = '2.4.2-1'
* default['rundeck']['database_root_password'] = 'password'
* default['rundeck']['database'] = 'rundeck'
* default['rundeck']['database_user'] = 'rundeck'
* default['rundeck']['database_password'] = 'password'
* default['rundeck']['database_server'] = 'localhost'
* default['rundeck']['apps_server'] = 'localhost'
* default['rundeck']['domain_name'] = 'rundeck.dev'

## Usage

### rundeck::default

Include `rundeck` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[rundeck::database]",
    "recipe[rundeck::apps]",
    "recipe[rundeck::reverse]"
  ]
}
```

## Evaluation/Development

### Prerequisite

* chefdk - chef developers only ([https://downloads.chef.io/chef-dk/](https://downloads.chef.io/chef-dk/))
* vagrant ([https://www.vagrantup.com/](https://www.vagrantup.com/))
* vagrant plugins :
  * vagrant-cachier : ```vagrant plugin install vagrant-cachier```
  * vagrant-omnibus : ```vagrant plugin install vagrant-omnibus```
  * vagrant-hostmanager : ```vagrant plugin install vagrant-hostmanager```
  * vagrant-berkshelf : ```vagrant plugin install vagrant-berkshelf```
* virtualbox ([https://www.virtualbox.org/](https://www.virtualbox.org/))
* At least 1Go of RAM for the VM

### Provisionning

#### Evaluation

After installing all the prerequisite, change the BOX_URL and BOX_NAME attributes in ```Vagrantfile``` then :

```
git clone https://github.com/sitle/chef-rundeck.git
cd chef-rundeck
vagrant up
```

Note : you need to wait a few minutes to let rundeck start. You can, then, access to it (http://rundeck.dev - admin/admin).

#### Development

After installing all the prerequisite, change the box_url attribute in ```.kitchen.yml``` then :

```
git clone https://github.com/sitle/chef-rundeck.git
cd chef-rundeck
kitchen converge debian # or ubuntu
```

Note : you need to wait a few minutes to let rundeck start. You can, then, access to it (http://rundeck.dev - admin/admin).

## License and Authors

```
Copyright 2015 Léonard TAVAE

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

Authors :

* Léonard TAVAE (<leonard.tavae@informatique.gov.pf>)
