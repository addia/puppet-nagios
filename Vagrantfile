# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "landregistry/centos"
  config.vm.provision "shell", inline: <<-SCRIPT
    puppet module install puppetlabs-stdlib
    ln -s /vagrant /etc/puppet/modules/nagiosclient
  SCRIPT

end
