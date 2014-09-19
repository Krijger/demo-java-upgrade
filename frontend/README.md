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
- IP of the container should be fixed and configured as part of hot-swap-demo.js ContainerURL.
- Container ID needs to be determined and used in hot-swap-demo.js ContainerID.
- Run ./build.sh after Dockerfile is updated
