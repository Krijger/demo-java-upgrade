
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
- Fix Vagrant port forwarding

Troubleshooting
===============
- meteor not starting: export LC_ALL=C
