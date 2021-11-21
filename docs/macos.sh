#sudo gem install rails -v 4.1.16


brew install rbenv ruby-build

# Add rbenv to bash so that it loads every time you open a terminal
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
source ~/.bash_profile

# Install Ruby
rbenv install 3.0.2
rbenv global 3.0.2
ruby -v


sudo gem install cocoapods
