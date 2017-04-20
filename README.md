# Meteor - Ionic 2 - Angular 2 boilerplate

A boilerplate using Meteor+Angular2 for the **server and web app**, as well as Meteor+Ionic2+Angular2 for **mobile**.

If you need help to make this run, please create a Github issue. If you need a developer for your project based on this stack, you can [hire an expert at Celtiberian](http://www.celtiberian.es).

## Get Ready

First of all, you need to install (or update) Meteor and Ionic2 following the steps in the next links:

- [Meteor Installation](https://www.meteor.com/install)
  - OSX / Linux: `curl https://install.meteor.com/ | sh`
  - [Windows Installer](https://install.meteor.com/windows)
- [Ionic 2 Installation / Update](http://ionicframework.com/docs/intro/installation/)
  - `npm install -g ionic cordova`
- Typescript Typings:
  - `npm install typings -g`
  - `typings install registry:env/meteor --global`

To start using this application run the following commands:

- `cd <project root folder>`
- `meteor npm install` - Install the necessary packages to use the Meteor application.
- `cd client/.mobile` - Change to Ionic 2 directory.
  - `npm install` - Install the necessary packages to use the Ionic 2 application.
  - Windows: `mkdir www`
  - Mac/Linux: `md www`
  - `ionic platform add android` - To add Android platform to Ionic 2 project.
  - `ionic platform add ios` - To add iOS platform to Ionic 2 project.
  - `npm install -g meteor-client-bundler`
  - In Windows: `cls`
  - `meteor-client bundle` - collect Meteor files and config in a bundle to be used from Ionic. Run again if the URL of the server changes or new Meteor packages are added to *meteor-client.config.json*.


## Windows Troubleshooting

Meteor might not work or be too slow on Windows platforms. The following might help:

- disable file sync apps (like Dropbox or BT Sync)
- disable the AntiVirus
- use a CMD with admin privileges

## Security Warning

This Meteor project is configured for **fast prototyping**. All clients will receive the whole server database (*[AutoPublish](https://www.meteor.com/tutorials/blaze/publish-and-subscribe)*), even the secrets from other users! and will be able to modify the whole database without authorization ([Insecure](https://www.meteor.com/tutorials/blaze/security-with-methods)). This speeds up prototypes as we don't need to query the server database, check permissions or subscribe to publications. Just focus on UI/UX.
- To disable AutoPublish: `meteor remove autopublish`.
- To disable Insecure: `meteor remove insecure`


## SERVER


`cd <project root folder>`

**Debug**: `meteor run` - This runs the server Meteor and the web application. By default, the URL of the web application is: *http://localhost:3000*. See the instructions below to debug the server with WebStorm.

## WEB APP

Point your browser to *http://localhost:3000*

To debug, open your browser's Development Tools (in Windows press F12 in your keyboard).


## MOBILE APP

`cd <project root folder>/client/.mobile`

**Debug in Browser**: `ionic serve --debug` - This will run the mobile application in your web browser using the default URL *http://localhost:8100*. Open your browser's Development Tools to debug (in Windows press F12 in your keyboard).

**Test in Ionic View app**: ([native cordova plugins](https://cordova.apache.org/plugins/) won't be available)
- Download [Ionic View](http://view.ionic.io/) from [App Store](https://itunes.apple.com/us/app/ionic-view/id849930087?ls=1&mt=8) or [Google Play](https://play.google.com/store/apps/details?id=com.ionic.viewapp).
- [Sign Up](https://apps.ionic.io/signup) to get your Ionic account.
- `ionic upload` - you will need your Ionic credentials.
- Open *Ionic View* and choose the app that you just uploaded.
- You CANNOT debug with Ionic View, just test.

**Debug in Device Emulator**

IOS: `ionic build ios`, then `ionic emulate ios`

Android:
- install Android Studio.
- Open Tools->AVD Manager
- Create a virtual device based on a fast emulator image, like Marshmallow 6.0 x86, and make sure you [enable hardware acceleration](https://software.intel.com/en-us/android/articles/intel-hardware-accelerated-execution-manager).
- launch the virtual device from AVD Manager.
- `ionic emulate android --debug -l`
- To debug:
  - open a browser and point it to `chrome://inspect `
  - configure port forwarding, i.e. 3000 => 192.168.1.133:3000. Make sure you use the internal network IP of the computer running the host, don't use localhost or 127.0.0.1.
  - to restart the app, press F5 in your Browser's development tools.

**Debug in Real Device**

IOS: open the XCode project within .mobile/www and run.

Android:
  - connect your device with a USB cable.
  - Open Device Monitor from Android Studio to make sure your device is detected by ADB, you cannot continue until that works.
  - `ionic run android --debug -l`
  - to debug, follow the same steps described previously for the device emulator.

## Debug Server and Web App with WebStorm

- in WebStorm => 'Open Folder => root folder of this boilerplate
- Run Menu => Edit Configurations => +  (to add a new configuration)
  - Choose 'Meteor' as the base configuration and give a name to the new one (i.e. 'Meteor App')
    - in 'Configuration' tab:
      - Make sure the paths of the meteor executable and the project folder are correct.
      - in production add '--production' to meteor arguments.
    - in Browser/Live Edit Tab
      - Enable 'After launch', use Chrome, with 'Javascript Debugger'.
      - make sure the URL is 'http://localhost:3000'
- click Apply.
- Install the 'JetBrains IDE Support' extension in Chrome.
- click Run or Debug.

## Production Deployment

For more information [read the Meteor instructions](https://guide.meteor.com/deployment.html#custom-deployment). We found the following methods to be easy and reliable:

  - delete `<project folder>/node_modules` and `<project folder>/.meteor/local`
  - `cd <project folder>`
  - `npm install --production`
  - launch MongoDB:
    - 1st time, you'll need to create an empty folder i.e. `<project>/db`
    - `mongod --port 27017 --dbpath "<project>/db"`
  - Alternative 1, convenient with hot-reload but inefficient and less secure:
    - `meteor --production` - this will create a production bundle and run it.
    - stop with CTRL-C: although it works, but is innefficient and insecure. We already have a working bundle, let's launch it manually without meteor.
    - `cd <project>/.meteor/local/build`
    - Linux/OSX:
      - `MONGO_URL=mongodb://localhost:27017/myapp ROOT_URL=http://my-app.com PORT=3000 meteor node main`
    - Windows:
      - `SET MONGO_URL=mongodb://localhost:27017/myapp`
      - `SET ROOT_URL=http://my-app.com`
      - `SET PORT=3000`
      - `meteor node main`
    - to daemonize the server, restarting on crashes or source code changes:
      - `npm install forever -g`
      - `forever -c "meteor node" -w --watchDirectory program main.js`

  - **Didn't work for us (with Meteor 1.4.4.1)**:
    - we were not able to run the production bundle outside `.meteor/local/build`.
    - we were not able to successfully deploy to dockers, they seem to lack maintainance.

## Project structure

From the point of view of Build Tools, there are 2 nested projects:

- `/` - Meteor project. All config files belong to Meteor.
- `/client/.mobile` - Ionic 2 project. All config files belong to Ionic.

This boilerplate is inspired but doesn't strictly follow the [Meteor 1.3 recommendation](https://guide.meteor.com/structure.html) and [Ionic 2 recommendation](http://moduscreate.com/ionic-2-project-structure). The following basic restrictions were respected:
- Meteor shares all code between server and clients, except code hanging from folders called `server/` or `client/`, that may appear multiple times in different parts of the folder structure.
- Meteor ignores folders that start with a dot, like `.mobile/`
- Both Meteor and Ionic have strict requirements regarding the location of entry point files and startup files. Leave them even if you don't like how they are named or organized.
- Meteor needs that all your importable files reside in an `imports/` folder. That's weird but needed for backward compatibility. Ionic doesn't need it.

The proposed structure tries to make both platforms as similar as possible:

- `/client`
  - `/web/imports` - Meteor web app
    - `/app` - **startup code**: declare pages, routes, headers, footers, menus, jump to 1st page.
    - `/pages` - **UI and logic** of pages, with components and subcomponents.
    - `/assets` - **icons, images**, sounds, etc, to be used exclusively by this client (not shared).
  - `/.mobile` - Ionic2 mobile app. The dot tells Meteor to ignore this folder when building the server and web apps.
    - `/app` - **startup code** (see above).
    - `/pages` - **UI and logic** (see above).
    - `/assets` - **icons, images** (see above).
    - `/themes` - Ionic2 global styles (aka [Themes](http://ionicframework.com/docs/theming/)).
- `/server/imports` - Meteor server
  - `main.ts` - init data and import all server dependencies.
- `/shared` - code shared between server and clients.
  - `/collections/Acme/` - collection, model and methods of Acme
  - `/methods` - methods not directly related to any collection

## Meteor application

The Meteor application contains the `client`, `server` and `both` folders, and also the following files:

- `package.json` - Contains the dependencies of the Meteor project.
- `tsconfig.json` - It is the configuration file of the Meteor project.
- `typings.d.ts` - It declares Javascript modules as Typescript.

## Ionic 2 application

The Ionic 2 application is under `.mobile` folder. The configuration files are:

- `webpack.config.js` - webpack configuration, used for transpilation, minification, etc.
- `tsconfig.json` - typescript configuration.
- `tslint.json` - typescript linter rules to detect bad coding style.
- `meteor-client.config.json` - configuration for meteor-client-bundler. Remember to run `meteor-client bundle -c meteor-client.config.json` if it changes, to create a new bundle in *node_modules/meteor-client.js*. These are the important parts:
  - *DDP_DEFAULT_CONNECTION_URL* - URL of the Meteor server
  - Meteor libraries required in the Ionic2 project.
- `ionic.config.json` - This file is useful when you use Ionic Cloud to run the mobile application. For this, you have to do the [Ionic Cloud setup](https://docs.ionic.io/setup.html).
