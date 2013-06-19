# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.synced_folder ".", "/etc/puppet/modules/rvm"

  # install the epel module needed for rvm in CentOS
  config.vm.provision :shell, :inline => "test -d /etc/puppet/modules/epel || puppet module install stahnma/epel -v 0.0.3"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "tests"
    puppet.manifest_file  = "init.pp"
  end

  config.vm.define :centos63 do |config|
    config.vm.box = "CentOS-6.3-x86_64-minimal"
    config.vm.box_url = "https://repo.maestrodev.com/archiva/repository/public-releases/com/maestrodev/vagrant/CentOS/6.3/CentOS-6.3-x86_64-minimal.box"
  end

  config.vm.define :centos64 do |config|
    config.vm.box = "CentOS-6.4-x86_64-minimal"
    config.vm.box_url = "https://repo.maestrodev.com/archiva/repository/public-releases/com/maestrodev/vagrant/CentOS/6.4/CentOS-6.4-x86_64-minimal.box"
  end

end
