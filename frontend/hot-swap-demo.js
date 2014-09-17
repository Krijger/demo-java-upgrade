
ContainerID = '80b7edf6edf6';
ContainerURL = 'http://127.0.0.1/';
DockerfilePath = '/vagrant/Dockerfile';
Logs = new Mongo.Collection("logs");

if (Meteor.isClient) {
    // Logs
    Meteor.subscribe('logs');
    Template.logs.entries = function() {
        return Logs.find({});
    };

    // Dockerfile
    Meteor.call('readDockerfile', function(error, result) {
        Session.setDefault('dockerfile', result);
    });
    Template.wysiwyg.dockerfile = function() {
        return Session.get('dockerfile');
    }
    Template.wysiwyg.events({
        'click button': function() {
            var content = document.getElementById("dockerfile").value;
            Meteor.call('updateDockerfile', content);
        }
    });

    // Guest
    Template.guest.events({
        'click button': function() {
            Meteor.call('getContainerHomepage', function(error, result) {
                Session.set('homepage', result);
            });
        }
    });
    Template.guest.homepage = function() {
        return Session.get('homepage');
    }
}

if (Meteor.isServer) {
    var fs = Npm.require('fs');
    var spawn = Npm.require('child_process').spawn;

    Meteor.methods({
        updateDockerfile: function(content) {
            fs.writeFile(DockerfilePath, content);
        },
        readDockerfile: function() {
            return fs.readFileSync(DockerfilePath, 'utf-8');
        },
        getContainerHomepage: function() {
            var res = Meteor.http.get(ContainerURL);
            return res.content;
        }
    });

    Meteor.startup(function() {
        var tail = spawn('docker', ['logs', '-f', ContainerID]);
        tail.stdout.setEncoding('utf8');
        tail.stdout.on('data', Meteor.bindEnvironment(function(data) {
            data.split(/\r?\n/).forEach(function(entry) {
                entry && Logs.insert({entry: entry});
            });
        }));
    });
    Meteor.publish('logs', function() {
        return Logs.find({});
    });

}
