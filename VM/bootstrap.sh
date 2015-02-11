#!/bin/sh -e

#GEMS - todo move to .bashrc
if [ ! -d $HOME/gems ];
then
	mkdir $HOME/gems
	echo 'export GEM_HOME=$HOME/gems' >> .bashrc
fi

apt-get update

#dependency
sudo apt-get install -y ruby1.9.1 ruby1.9.1-dev zlib1g-dev rubygems1.9.1 libxml2-dev libxslt1-dev \
                       libsqlite3-dev libhttpclient-ruby imagemagick irb1.9.1 \
                       libxmlsec1-dev postgresql python-software-properties

#node
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y nodejs
sudo npm install -g coffee-script@1.6.2

#install git
sudo apt-get install -y  git-core
					   
   
#bundler
gem install bundler -v 1.6.0

sudo apt-get install -y make
sudo apt-get install -y postgresql-server-dev-9.3
sudo apt-get install -y g++

#canvas source
if [ ! -d canvas ];
then
	git init
	git clone https://github.com/instructure/canvas-lms.git canvas
	cd canvas
	git checkout stable


sudo bundle install --without mysql

#default config
 for config in amazon_s3 delayed_jobs domain file_store outgoing_mail security external_migration; \
          do cp -v config/$config.yml.example config/$config.yml; done
else 
	cd canvas
fi

#db install	
if [ ! -e config/database.yml ];	
then  
sudo cp config/database.yml.example config/database.yml
sudo -u postgres createuser root
sudo -u postgres createdb canvas_development --owner=root
sudo -u postgres createdb canvas_queue_development --owner=root


#replace vagrant with your own information 
echo 'vagrant\navagrant\navagrant\nvagrant\nvagrant\n3\n' | bundle exec rake db:initial_setup 
fi


#test db
#sudo -u postgres createuser canvas
#sudo -u postgres createdb canvas_test
#sudo psql -c 'CREATE USER canvas' -d canvas_test
#sudo psql -c 'GRANT ALL PRIVILEGES ON DATABASE canvas_test TO canvas' -d canvas_test
#sudo psql -c 'GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO canvas' -d canvas_test
#sudo psql -c 'GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO canvas' -d canvas_test

#RAILS_ENV=test bundle exec rake db:test:reset
#bundle exec rake spec
if [ ! -e logs/install.txt ];
then
	sudo npm install
	sudo bundle exec rake canvas:compile_assets
	mkdir logs
	touch logs/install.txt
fi

#automated jobs
#sudo ln -s /home/vagrant/canvas/script/canvas_init /etc/init.d/canvas_init
#sudo update-rc.d canvas_init defaults
#sudo /etc/init.d/canvas_init start
bundle exec script/delayed_job run &

#start canvas
bundle exec rails server


