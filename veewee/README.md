To create a new basebox using the existing veewee definition:


    gem install veewee
    vagrant basebox build 'Fedora-17-x86_64'
    vagrant basebox validate 'Fedora-17-x86_64'
    vagrant basebox export 'Fedora-17-x86_64'
    vagrant box add 'Fedora-17-x86_64'
    vagrant init 'Fedora-17-x86_64'

http://www.ducea.com/2011/08/15/building-vagrant-boxes-with-veewee/
