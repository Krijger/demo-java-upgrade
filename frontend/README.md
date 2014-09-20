Docker hot-swap demo
====================

This is application, that allows updating Dockerfile from browser, displaying container "homepage" with Java version number
and displaying logs from the host.

###Requirements

- Meteor 0.9.2.2

###Run the application

- `vagrant ssh`
- `cd /vagrant`
- `sudo ./build-java.sh`
- `sudo ./build.sh`
- `cd /vagrant/frontend`
- `meteor run`

###Usage

_To demostrate the Java version hot-swap functionality, follow these steps:_

- go to `http://localhost:3000/`, you can see Dockerfile contents, container homepage displaying the currently running Java version and logs from the container
- update the Dockerfile jdk tag to `quintenk/jdk-oracle:8` or `quintenk/jdk-oracle:7`
- click "Update Dockerfile!" button and watch the logs
- when the console reads `demoapp` is running again, reload the container homepage
- voilà, the Java version has updated and it literally took seconds!
