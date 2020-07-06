#####
# Ruby includes
require 'yaml'

# Get abs path to vagrant_dir
vagrant_dir = File.expand_path(File.dirname(__FILE__))

# Load the custom-config.yml file or set some defaults otherwise
if File.file?(File.join(vagrant_dir, 'custom-config.yml')) then
  custom_config_file = File.join(vagrant_dir, 'custom-config.yml')
else
  custom_config_file = File.join(vagrant_dir, 'config.yml')
end

# Load the configuration from YAML
custom_config = YAML.load_file(custom_config_file)

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "bento/ubuntu-16.04"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  #config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    # Customize the amount of memory on the VM:
    #vb.memory = "1024"
  #end
  
  config.ssh.forward_agent = true
  config.vm.hostname = custom_config['vm_config']['hostname']
  
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL
  
  # Run pre-provisioning script, if one is defined.
  if File.exists?(File.join(vagrant_dir,'playbooks','provision-pre.yml')) then
    config.vm.provision "ansible_local" do |ansible|
      ansible.playbook = File.join( "playbooks", "provision-pre.yml" )
      ansible.tags = ENV["TAGS"]
    end
  end

  # Run main provisioning script or custom playbooks script if one exists.
  config.vm.provision "ansible_local" do |ansible|
    ansible.extra_vars = custom_config['host_config']
    ansible.playbook = File.join( "playbooks", "provision.yml" )
  end

  # Run post-previsioning script, if one is defined.
  if File.exists?(File.join(vagrant_dir,'playbooks','provision-post.yml')) then
    config.vm.provision "ansible_local" do |ansible|
      ansible.playbook = File.join( "playbooks", "provision-post.yml" )
    end
  end

end
