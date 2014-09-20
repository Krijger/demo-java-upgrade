# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.provider "virtualbox" do |v|
     v.customize ["modifyvm", :id, "--memory", "1024"]
  end

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/trusty64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = ""

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.

  # HTTP
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :forwarded_port, guest: 8000, host: 8000

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.50"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Raspberry cache proxy
  # config.proxy.http     = "http://192.168.0.17:3128"
  # config.proxy.https    = "http://192.168.0.17:3128"
  # config.proxy.no_proxy = "localhost,127.0.0.1"

  config.vm.provision :docker do |d|
    # config.vm.synced_folder ".", "/vagrant", :nfs => true
  end

$script = <<SCRIPT
apt-get -y install default-jdk maven
apt-get -y install mongodb
curl https://install.meteor.com | /bin/sh
# hack to make mongo work with nfs
rm -rf /vagrant/frontend/.meteor/local/db && mkdir -p /vagrant/frontend/.meteor/local && cd /vagrant/frontend/.meteor/local && mkdir /home/vagrant/db && ln -s /home/vagrant/db/
chown vagrant:vagrant /home/vagrant/db
export LANGUAGE="en_US.UTF-8"
echo 'LANGUAGE="en_US.UTF-8"' >> /etc/default/locale
echo 'LC_ALL="en_US.UTF-8"' >> /etc/default/locale
SCRIPT

  config.vm.provision "shell", inline: $script

end
