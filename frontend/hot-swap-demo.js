
BasePath = '/vagrant';
ContainerName = 'demoapp';
ContainerURL = 'http://127.0.0.1:8000/';
DockerfilePath = BasePath + '/Dockerfile';
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
    var setHomepage = function() {
        Meteor.call('getContainerHomepage', function(error, result) {
            Session.set('homepage', result);
        });
    }
    Template.guest.events({
        'click button': function() {
            setHomepage();
        }
    });
    setHomepage();
    Template.guest.homepage = function() {
        return Session.get('homepage');
    }
}

if (Meteor.isServer) {
    var fs = Npm.require('fs');
    var process = Npm.require('child_process');
    var spawn = Npm.require('child_process').spawn;
    Meteor.methods({
        updateDockerfile: function(content) {
            fs.writeFile(DockerfilePath, content);
            process.exec('cd ' + BasePath + ' && ./build.sh', {maxBuffer: 1024 * 500}, function (error, stdout, stderr) {
                if (error) {
                    console.log(error.stack);
                    console.log('Error code: '+error.code);
                    console.log('Signal received: '+error.signal);
                }
            });
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
        Logs.remove({});
        var addEntry = function(data) {
            data.split(/\r?\n/).forEach(function(entry) {
                entry && Logs.insert({entry: entry});
            });
        };
        var tailDockerLogs = function() {
            var tail = spawn('docker', ['logs', '-f', ContainerName]);
            tail.stdout.setEncoding('utf8');
            tail.stdout.on('data', Meteor.bindEnvironment(addEntry));
            tail.stdout.on('end', Meteor.bindEnvironment(function() {
                setTimeout(Meteor.bindEnvironment(function() {
                    tailDockerLogs();
                }), 300);
            }));
        }
        tailDockerLogs();
    });
    Meteor.publish('logs', function() {
        return Logs.find({});
    });

}
