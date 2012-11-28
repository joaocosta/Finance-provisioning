# Details about the full stack sandbox environment

The following ports are forwarded from the VM to the host:
- 80 => 8080   #web service

bridged networking support in Vagrant varies, I had to change the following file to get it workaround an issue:
~/.rvm/gems/ruby-1.9.2-p320/gems/vagrant-1.0.5/lib/vagrant/guest/redhat.rb # it's detecting my fedora17 guest as redhat instead

-- vm.channel.sudo("/sbin/ifup eth#{interface} 2> /dev/null")
++ vm.channel.sudo("/sbin/ifup eth#{interface} || /bin/true 2> /dev/null")

