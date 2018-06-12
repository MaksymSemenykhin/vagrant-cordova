require 'yaml'
require 'fileutils'



config = {
  local: './vagrant/config/vagrant-local.yml',
  example: './vagrant/config/vagrant-local.example.yml'
}

# copy config from example if local config not exists
FileUtils.cp config[:example], config[:local] unless File.exist?(config[:local])


# read config
options = YAML.load_file config[:local]



# vagrant configurate
Vagrant.configure(2) do |config|
  # select the box
  config.vm.box = options['vmbox']

  # should we ask about box updates?
  config.vm.box_check_update = options['box_check_update']

  config.vm.provider 'virtualbox' do |vb|
    # machine cpus count
    vb.cpus = options['cpus']
    # machine memory size
    vb.memory = options['memory']
    # machine name (for VirtualBox UI)
    vb.name = options['machine_name']

    #https://stackoverflow.com/questions/24200333/symbolic-links-and-synced-folders-in-vagrant
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    vb.customize ["modifyvm", :id, "--usb", "on"]
    vb.customize ["usbfilter", "add", "0",
        "--target", :id,
        "--action", "hold",
        "--name", "hey hey"
    ]

    if Vagrant.has_plugin?("vagrant-proxyconf") && options['proxy_use'] == true
        config.proxy.http     = options['proxy_http']
        config.proxy.https    = options['proxy_https']
        config.proxy.no_proxy = options['no_proxy']
    end

  end

  # machine name (for vagrant console)
  config.vm.define options['machine_name']

  # machine name (for guest machine console)
  config.vm.hostname = options['machine_name']

  # network settings
  config.vm.network 'private_network', ip: options['ip']

  config.vm.synced_folder './vagrant/provision', '/image/provision', owner: 'vagrant', group: 'vagrant'
  config.vm.synced_folder './vagrant/config', '/image/config', owner: 'vagrant', group: 'vagrant'

  config.vm.synced_folder './app', '/app', owner: 'vagrant', group: 'vagrant'

  # provisioners
  config.vm.provision 'shell', path: './vagrant/provision/once-as-root.sh'
  config.vm.provision 'shell', path: './vagrant/provision/once-as-vagrant.sh', args: [], privileged: false
  config.vm.provision 'shell', path: './vagrant/provision/android.sh'

  config.vm.provision 'shell', path: './vagrant/provision/always-as-root.sh', run: 'always'
#  config.vm.provision 'shell', path: './vagrant/provision/always-as-vagrant.sh', run: 'always', privileged: false



end
