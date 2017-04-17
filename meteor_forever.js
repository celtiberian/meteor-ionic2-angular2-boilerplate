console.log("Developed by Celtiberian. MIT License. Hire developers at http://celtiberian.es ;)");

console.log("If you experience problems, try to delete /node_modules and /.meteor/local. Then launch meteor_forever.js again.");

// ============= CONFIGURATION ======================================
// MONGODB
var MONGO_LAUNCH = false;  // set to false if you prever to launch your DB manually
var MONGO_PORT = "27017";
var MONGO_URL = "mongodb://localhost:"+MONGO_PORT+"/myapp";
var ROOT_URL = "http://my-app.com";
var PORT = "3000";

// forever-monitor config
var options = {
	max: 20,
	watch: true,
	watchDirectory: __dirname,
	'watchIgnoreDotFiles': true,
	watchIgnorePatterns : ['*.json', '*.md', 'db/**/*', 'logs/**/*', 'build/**/*', '.meteor/**/*', 'client/.mobile/**/*', '.idea/**/*'], 	// it uses minimatch module for patterns
	command: 'meteor',
	'env': {'MONGO_URL': MONGO_URL, 'ROOT_URL': ROOT_URL, 'PORT': PORT},
	sourceDir: __dirname + '/.meteor/local/build',
	logFile: __dirname + '/logs/forever_meteor.log',
    outFile: __dirname + '/logs/forever_meteor.log',
    errFile: __dirname + '/logs/forever_meteor.log'
};

// ============= FOREVER-MONITOR ======================================

var forever = require('forever-monitor');
var fs = require('fs');
var execSync = require('child_process').execSync;

if(!fs.existsSync('.meteor')) {
	console.error(".meteor folder not found. This script is designed to be run from the root folder of a Meteor project.");
	process.exit(1);
}

function execCmd(cmd, cwd, env) {
	console.log("Executing: " + cmd + ", in " + cwd);
	try {
		execSync(cmd, {cwd: __dirname + '/.meteor/local/build'});
	}
	catch(err) {		
		if (err) {
			console.error("ERROR: " + cmd + "\n" + err);
			console.error("\nRetrying\n");
			build_and_launch_production_meteor();
		}
	}
}

/*
function build_and_launch_production_meteor() {

	console.log("making sure /db folder exists");
	fse.ensureDirSync('./db');
	
	console.log("making sure /logs folder exists");
	fse.ensureDirSync('./logs');

	if(MONGO_LAUNCH) {
		console.log("Trying to connect to " + MONGO_URL);
		mongoose.connect(MONGO_URL, function(err, res) {
			if(err) { 
				console.log("Unable to connect to " + MONGO_URL + err + ". Trying to launch mongod instance.");
				execCmd('mongod --port ' + MONGO_PORT + ' --dbpath ./db', __dirname);
			}
			else {console.log('DB already running at ' + options.MONGO_URL); }
		});
	}

	execCmd('npm install --production', __dirname + '/.');
	execCmd('meteor build ./build', __dirname + '/.');
	execCmd('meteor node main', __dirname + '/.meteor/local/build', {'MONGO_URL': MONGO_URL, 'ROOT_URL': ROOT_URL, 'PORT': PORT});

	child = new (forever.Monitor)('server.js', options);
	child.start();
}
build_and_launch_production_meteor();
*/

var child = new (forever.Monitor)('node main.js', options);


function ab2str(buf) {
  return String.fromCharCode.apply(null, new Uint8Array(buf));
}

child.on('watch:restart', function(info) {
    console.error('[Forever] Restarting script because ' + info.file + ' changed');
});

child.on('exit', function () {
	console.error('[Forever][ERROR] Exited after 3 restarts');
});

child.on('restart', function (data) {
	console.error("[Forever][INFO] Restarting server...");
});

child.on('stderr', function (data) {
	console.error('[Forever][ERROR] ' + ab2str(data));
});

child.on('error', function (msg) {
	console.error('[Forever][ERROR] ' + msg);
});

child.start();
