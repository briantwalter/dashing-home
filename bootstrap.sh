#!/bin/bash -x

# total hack to setup Ruby and Dashing

# config
RVMRC=~/.rvm/scripts/rvm
NODE=node-v0.10.29-linux-x64.tar.gz
NODEURL=http://nodejs.org/dist/v0.10.29

# setup my git
wget https://raw.githubusercontent.com/briantwalter/etc-puppet/master/modules/dotfiles/files/gitconfig
mv gitconfig ~/.gitconfig

# get RVM and Ruby
curl -sSL https://get.rvm.io | bash -s stable --ruby=1.9.3
# check for the local rc file
if [ -f ${RVMRC} ]; then
  source ${RVMRC}
else
  echo "WARN: didn't find ${RVMRC}"
fi
# check for Ruby binary
which ruby > /dev/null 2>&1
RC=$?
# exit if we don't have a ruby binary
if [ ${RC} != "0" ]; then
  echo "FATAL: some kind of problem with ruby: exit code ${RC}"
  exit 1
fi
gem install dashing
echo "INFO: done installed dashing, hopefully"
wget -O /tmp/${NODE} ${NODEURL}/${NODE}
echo "INFO: downloaded node to /tmp/${NODE}"
cd /tmp
tar zxvf node-v0.10.29-linux-x64.tar.gz 
cd node-v0.10.29-linux-x64/
rm -f ChangeLog LICENSE README.md 
sudo cp -R * /usr/local/
cd /tmp
rm -rf /tmp/node-v0.10.29-linux-x64*
echo "INFO: installed NodeJS"
