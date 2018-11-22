require 'serverspec'
require 'net/ssh'
require 'tempfile'

set :backend, :exec

if ENV['ASK_SUDO_PASSWORD']
  begin
    require 'highline/import'
  rescue LoadError
    fail "highline is not available. Try installing it."
  end
  set :sudo_password, ask("Enter sudo password: ") { |q| q.echo = false }
else
  set :sudo_password, ENV['SUDO_PASSWORD']
end



# retrieve the hostname
host = ENV['TARGET_HOST']
puts "host =  '#{host}'"



# check if a Vagrant machine is running
begin
  vagrant_status = `vagrant status`
  if match = /running/.match(vagrant_status)
    puts "vagrant machine is running..."
    
    # check if this is a manual serverspec run
    vagrant_run = ENV['VAGRANT_INSTALLER_VERSION'] || 'none'
    if vagrant_run != "2"
      
      puts "vagrant, manual serverspec run..."
      host = "default"
    
      # retrieve the vagrant ssh config
      config = Tempfile.new('', Dir.tmpdir)
      config.write(`vagrant ssh-config #{host}`)
      config.close
      
      # configure the SSH connection for serverspec
      options = Net::SSH::Config.for(host, [config.path])
      options[:user] ||= Etc.getlogin
      set :host,        options[:host_name] || host
      set :ssh_options, options
      set :backend, :ssh
    end
  end
rescue Errno::ENOENT => e
  puts 'Rescued by Errno::ENOENT statement.'
end



# check if this is a Packer run
packer_status = ENV['PACKER_RUN_UUID'] || 'none'
if packer_status != 'none'
  puts "packer run detected..."
  
  # retrieve the packer_builder
  packer_builder = ENV['PACKER_BUILDER'] || 'none'
  
  # attempt to fail early
  if packer_builder == 'none'
    puts "ERROR: PACKER_BUILDER env variable not set"
    exit 1
    
  # check for a virtualbox-ovf run
  elsif packer_builder == "virtualbox-ovf"
    puts "packer, virtualbox run detected..."
    
    # retrieve the VM_NAME
    vm_name = ENV['VM_NAME'] || 'none'
    
    # ensure VM_NAME is set
    if vm_name == 'none'
      puts "ERROR: VM_NAME env variable not set"
      exit 1
    end
    
    # retrieve the dynamic SSH port set by Packer in Virtualbox
    ssh_port=`vboxmanage showvminfo #{vm_name} --machinereadable | grep "Forwarding"`
    ssh_port = ssh_port.split(',')
    ssh_port = ssh_port[3].to_i
  
    # set the host and hostname to local
    host = "127.0.0.1"
  
    # configure the SSH connection
    options = Net::SSH::Config.for(host)
    options[:host_name]     = host
    options[:port]          = ssh_port
    options[:user]          = "vagrant"
    options[:password]      = "vagrant"
    options[:auth_methods]  = ['none','publickey','password']
    options[:user_known_hosts_file] = "/dev/null"
    options[:keys]          = [
      "~/.ssh/vagrant.pub",
      "~/.ssh/vagrant.pem"
    ]
    options[:keys_only]     = false
  
    set :host, host
    set :ssh_options, options
    set :backend, :ssh
    p options, host, ssh_port
    
  # check for an amazon-ebs run
  elsif packer_builder == "amazon-ebs"
    puts "packer, amazon-ebs run detected..."
    
    # retrieve AMI_NAME
    ami_name = ENV['AMI_NAME'] || 'none'
    
    # ensure AMI_NAME is set
    if ami_name == 'none'
      puts "ERROR: AMI_NAME env variable not set"
      exit 1
    end
    
    # retrieve the keypair filename
    ssh_private_key_file = ENV['SSH_PRIVATE_KEY_FILE'] || 'none'
    
    # ensure SSH_PRIVATE_KEY_FILE is set
    if ssh_private_key_file == 'none'
      puts "ERROR: SSH_PRIVATE_KEY_FILE env variable not set"
      exit 1
    end

    # retrieve AMI IP
    aws_ip=`aws ec2 describe-instances \
      --filters Name=instance-state-name,Values=running,Name=tag:Name,Values='#{ami_name}' \
      --query 'Reservations[].Instances[].PublicIpAddress' \
      --output text`
    host = aws_ip
  
    # configure the SSH connection
    options = Net::SSH::Config.for(host)
    options[:host_name]     = host
    options[:user]          = "ubuntu"
    options[:port]          = 22
    options[:auth_methods]  = ['none','publickey','password']
    options[:keys]          = [
      ssh_private_key_file
    ]
  
    set :host, host
    set :ssh_options, options
    set :backend, :ssh
    # p ami_name, aws_ip, options, host, ssh_private_key_file
  end
end



# Disable sudo
# set :disable_sudo, true


# Set environment variables
# set :env, :LANG => 'C', :LC_MESSAGES => 'C'

# Set PATH
# set :path, '/sbin:/usr/local/sbin:$PATH'



# Define installed packages
Packages = {
}

# Define Enabled services
EnabledServices = [
]

# Define Running services
RunningServices = [
]