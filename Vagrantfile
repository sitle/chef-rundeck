# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.require_version '>= 1.5.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = 'rundeck'
  config.omnibus.chef_version = '11.16.4'
  config.vm.box = 'ubuntu-14.04-chef'
  config.vm.box_url = 'http://bit.ly/dsi-ubuntu-1404-box'
  config.vm.network :private_network, ip: '172.28.128.3'
  config.berkshelf.enabled = true
  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.auto_detect = true
    config.cache.scope = :box
  end
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true
  config.hostmanager.aliases = %w(local.dev rundeck.dev)
  config.vm.provision :chef_solo do |chef|
    chef.json = {
      rundeck: {
        version: '2.4.2-1',
        database_root_password: 'password',
        database: 'rundeck',
        database_user: 'rundeck',
        database_password: 'password',
        database_server: 'localhost',
        apps_server: 'localhost',
        domain_name: 'rundeck.dev',
        ssh_user: 'sysadmin',
        ssh_key_path: '/var/lib/rundeck/.ssh/id_rsa'
      }
    }

    chef.run_list = [
      'recipe[rundeck::database]',
      'recipe[rundeck::apps]',
      'recipe[rundeck::reverse]'
    ]
  end

  config.vm.provider :virtualbox do |p|
    p.customize ['modifyvm', :id, '--memory', '1024']
    p.customize ['modifyvm', :id, '--cpus', '2']
  end
end
