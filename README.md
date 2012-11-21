Finance-provisioning
====================

To clone source tree
    git clone git@github.com:joaocosta/Finance-provisioning.git
    git submodule init
    git submodule update

To add a new submodule
    git submodule add <URL> PATH
    eg: git submodule add git://github.com/puppetlabs/puppetlabs-mysql.git puppet/modules/mysql

To remove a submodule
    http://stackoverflow.com/questions/1260748/how-do-i-remove-a-git-submodule

To debug puppet runs:
    puppet apply --summarize --evaltrace --modulepath=puppet/modules manifests/somemanifest.pp
