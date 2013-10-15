# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.synced_folder "spec/fixtures/modules", "/etc/puppet/modules"
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

  config.vm.define :ubuntu do |config|
    config.vm.box = "Ubuntu-12.04"
    config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"

    # Upgrade puppet to 3.3.1
    config.vm.provision "shell", inline: <<-EOS
      dpkg -s puppetlabs-release > /dev/null || ( wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb &&
        dpkg -i puppetlabs-release-precise.deb &&
        apt-get update )
      [[ `dpkg -s puppet | grep Version` =~ 3.3.1 ]] || apt-get dist-upgrade -y puppet facter puppet-common
      EOS
  end

end
