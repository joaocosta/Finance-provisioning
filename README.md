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

    Delete the relevant section from the .gitmodules file.
    Delete the relevant section from .git/config.
    Run git rm --cached path_to_submodule (no trailing slash).
    Delete the now untracked submodule files.
    Delete .git/modules/$PATH_TO_MODULE
    Commit
    http://stackoverflow.com/questions/1260748/how-do-i-remove-a-git-submodule

To branch and track a remote submodule
    git remote add upstream git@github.com:puppetlabs/puppetlabs-apache.git
    git fetch upstream

To update a submodule

    cd submoduledir (ie: cd puppet/modules/mysql)
    git checkout master
    git pull
    cd ..
    git commit -m "Updated submodule" mysql
    git push

To update all submodules

    git submodule foreach git checkout master
    git submodule foreach git pull
    git commit -am "Updated all submodules"
    git push

To debug puppet runs:

    puppet apply --summarize --evaltrace --modulepath=puppet/modules manifests/somemanifest.pp
