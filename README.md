#Just a simple Erlang blog

This app is not an app indeed :) It written just for studying Erland and noSQL databases.

You are free to use.

Cheers!

##How to deploy:
For MacOS:

* install Erlang: `brew install erlang` 
* install CouchBD: `brew install couchdb`
* clone this repo: `git clone git@github.com/retgoat/erl-blog.git`
* start couchdb: `couchdb`
* seed the database: `./db_seeds.sh`
* compile the app: `make`
* start it: `./start-dev.sh`

Linux guys I believe you'll find out how to install Erang and CouchDB on your distros. Others steps (starting with clone) are the same as above.




