INSTALLATION REQUIREMENTS
------------
  - GIT
  - VirtualBox
  - Vagrant
  - Vagrant hostmanager pulugin
  - Vagrant proxyconf pulugin
  - console or terminal
  - 512 Memory 
  - 1 Gb of free space
  - One hour of time 
  
INSTALLATION
------------
1. Install [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
2. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) - VirtualBox 5.x.xx platform packages - Windows hosts
3. doanload and save on disk [VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads) - VirtualBox 5.x.xx Oracle VM VirtualBox Extension Pack:
   [Install instrisction](https://www.smarthomebeginner.com/install-virtualbox-extension-pack-on-linux-windows/) - from part Install VirtualBox Extension Pack 
4. Install [Vagrant](https://www.vagrantup.com/downloads.html) - Windows x64 bit
5. Install [vagrant hostmanager pulugin](https://github.com/devopsgroup-io/vagrant-hostmanager)
6. Install [vagrant proxyconf pulugin](https://github.com/tmatilai/vagrant-proxyconf) if you need to use proxy
7. Create on C: or D: folder Virtual (as example D:/Virtual)
8. Clone this repo content to folder Virtual and go to this folder.
9. In Virtual folder copy ./vagrant/config/vagrant-local.example.yml as ./vagrant/config/vagrant-local.yml
10. Setup proxy in system variables and restart your console. If needed.
11. Take a short look at vagrant-local.yml settings if all ok (Use proxy or not, CPU, Memory, hostname, etc)
12. Run cmd as Administrator & go to folder Virtual:
```bash
cd D:
cd Virtual
```
13. Install Vagrant plugins:
```bash
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-proxyconf
```
14. Start Android local env deploy
```bash
vagrant up
```
15. Wait 10-15 min & check correct VM work:
```bash
vagrant global-status
```

What you get
------------
1. Synced folder './vagrant/provision' => '/image/provision' with all provisions, vagrant start up scripts
2. Synced folder './vagrant/config' => '/image/config' with all configs
3. Synced folder './' => '/app'
4. JDK 8, Android-sdk, cordova-cli 
5. Proxyed usb ports to linux adb



