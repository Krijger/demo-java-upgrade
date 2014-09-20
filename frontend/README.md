Docker hot-swap demo
====================
This is application, that allows updating Dockerfile from browser, displaying container "homepage" with Java version number
and displaying logs from the host.

WIP.

Requirements
============
- Meteor 0.9.2.2

Run the app
===========
- vagrant ssh
- cd /vagrant
- sudo ./build-java.sh
- sudo ./build.sh
- cd /vagrant/frontend
- meteor run

Todo
====
- Run ./build.sh after Dockerfile is updated
