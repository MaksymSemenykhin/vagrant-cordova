INSTALLATION REQUIREMENTS
------------
  - GIT
  - VirtualBox
  - Vagrant
  - Vagrant hostmanager pulugin
  - console or terminal
  - 512 Memory 
  - 1 Gb of free space
  - One hour of time 
  
INSTALLATION
------------
1. Install [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
2. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
3. Install [vagrant](https://www.vagrantup.com/)
4. Install [vagrant hostmanager pulugin](https://github.com/devopsgroup-io/vagrant-hostmanager)
5. Install [vagrant proxyconf pulugin](https://github.com/tmatilai/vagrant-proxyconf) if you need to use proxy
6. Copy ./vagrant/config/vagrant-local.example.yml as ./vagrant/config/vagrant-local.yml
7. Setup proxy in system variables and restart your console. In needed
8. Take a short look at vagrant-local.yml settings if all ok
9. Take a short look at android-tool.cfg settings if all ok
10. Start [vagrant](https://www.vagrantup.com/docs/getting-started/)
11. Reload vagrant

```sh
$ vagrant plugin install vagrant-hostmanager
$ vagrant plugin install vagrant-proxyconf
$ vagrant up
$ vagrant reload
$ vagrant global-status
```

What you get
------------
1. Synced folder './vagrant/provision' => '/image/provision' with all provisions, vagrant start up scripts
2. Synced folder './vagrant/config' => '/image/config' with all configs
3. Synced folder './' => '/app'
4. JDK 8, Android-sdk, cordova-cli 


Additionally, on windows vagrant up needs to be executed in a shell with admin rights. No workarounds necessary.

