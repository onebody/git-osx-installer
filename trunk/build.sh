#!/bin/sh
GIT_VERSION="1.5.5.3"

sudo mv /usr/local/git{,_`date +%s`}
sudo UserScripts/cplibs.sh

rm -rf git_build
mkdir git_build

pushd git_build
    curl -O http://kernel.org/pub/software/scm/git/git-$GIT_VERSION.tar.bz2
    tar jxvf git-$GIT_VERSION.tar.bz2
    pushd git-$GIT_VERSION

        # If you're on PPC, you may need to edit your Makefile and add: 
        # MOZILLA_SHA1=1

         # Tell make to use /usr/local/git/lib rather than MacPorts:
        echo "NO_DARWIN_PORTS=1" > Makefile_tmp
        cat Makefile >> Makefile_tmp
        mv Makefile_tmp Makefile

        make LDFLAGS="-L/usr/local/git/lib,/usr/lib" prefix=/usr/local/git all
        make LDFLAGS="-L/usr/local/git/lib,/usr/lib" prefix=/usr/local/git strip
        sudo make LDFLAGS="-L/usr/local/git/lib,/usr/lib" prefix=/usr/local/git install

        # contrib
        mkdir -p /usr/local/git/contrib/completion
        cp contrib/completion/git-completion.bash /usr/local/git/contrib/completion/
    popd
    
    curl -O http://www.kernel.org/pub/software/scm/git/git-manpages-$GIT_VERSION.tar.bz2
    sudo mkdir -p /usr/local/git/man
    sudo tar xjv -C /usr/local/git/man -f git-manpages-$GIT_VERSION.tar.bz2
popd

# change hardlinks for symlinks
sudo ruby UserScripts/symlink_git_hardlinks.rb

# add .DS_Store to default ignore for new repositories
sudo sh -c "echo .DS_Store >> /usr/local/git/share/git-core/templates/info/exclude"
