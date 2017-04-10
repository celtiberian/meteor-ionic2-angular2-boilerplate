# Meteor - Ionic 2 - Angular 2 boilerplate

A raw boilerplate project for both web/mobile client and server using Angular 2, Ionic 2 and Meteor

## Install Packages

To start using this application run the following commands:

- `$ meteor npm install` - Installs the necessary packages to use the Meteor application.
- `.mobile$ npm install` - Installs the necessary packages to use the Ionic 2 application.

## Using Meteor application

To run the Meteor application, you have to install the necessary packages firstly, and then run the following command:

- `$ meteor run` - This runs the server Meteor and the web application. By default, the URL of the web application is: `http:\\localhost:3000`. 

It is not possible to run only the server Meteor. It is neccesary to run both: web application and Meteor server.

## Using Ionic 2 application

If you want to run the mobile application, you have to add iOS and Android platforms:

- `.mobile$ ionic platform add android` - To add Android platform to Ionic 2 project.
- `.mobile$ ionic platform add ios` - To add iOS platform to Ionic 2 project. 

In order to connect the mobile application with Meteor server, you have to run:

- `.mobile$ meteor-client bundle -c meteor-client.config.json`

To test the mobile application in your web browser, you have to run the following command:

- `.mobile$ ionic serve` - This will run the mobile application in your web browser using the default URL `http:\\localhost:8100`. 

If you want to run this application in a mobile device, it is recommended to use Ionic Cloud. The steps to use this are described in [Ionic Cloud setup](https://docs.ionic.io/setup.html). 
Then, you have to download the Ionic Cloud application in your mobile device, log in, and run this Ionic 2 application.

You can also run this application in a mobile device using an USB cable. You can follow the steps explained in [Ionic 2 deploying](https://ionicframework.com/docs/intro/deploying).


## Folder structure

This boilerplate is organized following [Meteor 1.3 recommendation](https://guide.meteor.com/structure.html) and [Ionic 2 recommendation](http://moduscreate.com/ionic-2-project-structure).

The actual folder corresponds to a Meteor application and `/.mobile` contains an Ionic2 application. 

In the Meteor application we can find the following folders:

- `client` - Contains single TypeScript (`.ts`) file which is the main file (`/client/app.component.ts`), and 
bootstrap's the Angular 2 application. The main component uses HTML template and SASS file. The `index.html` file is the main HTML which loads the application by using the main 
component selector (`<app>`). All the other client files are under `client/imports` and organized by the context of the components (in our example, the context is `demo`).
- `server` - Contains the Meteor server which is based on Node.js. There is a single TypeScript (`.ts`) file which is the main file (`/server/main.ts`), 
and creates the main server instance, and then starts it. The `/methods` folder should contain the different methods which can be called from web and mobile applications.
All other server files should be located under `/server/imports`.
- `both` - Contains the files which are shared by the Meteor server and the web application (collections and models).

In the other way, the `/.mobile` folder contains the Ionic2 application:

- `src` - Contains single TypeScript (`.ts`) file which is the main file (`/app/app.component.ts`), and 
          bootstrap's the Ionic 2 application. The main component uses HTML template and SASS file. The `index.html` file is the main HTML which loads the application by using the main 
          component selector (`<ion-app>`).
- `resources` - Contains the resources used by the Ionic 2 application. It differentiates between Android and iOS resources.
        

## Meteor application

The Meteor application contains the `client`, `server` and `both` folders, and also the following files:

- `package.json` - Contains the dependencies of the Meteor project.
- `tsconfig.json` - It is the configuration file of the Meteor project.
- `typings.d.ts` - Declares the default modules which are used in the Meteor project.

## Ionic 2 application

The Ionic 2 application is under `.mobile` folder. The configuration files are:

- `webpack.config.js` - This is a JavaScript configuration file to preprocess and minify different non-JavaScript files such as TypeScript and SASS files.
- `tsconfig.json` - This is the configuration file of the Ionic 2 project.
- `tslint.json` - This is a configuration file which defines the rules to get run third-party tools.
- `meteor-client.config.json` - This is the configuration file which defines the URL of the Meteor server in the field `DDP_DEFAULT_CONNECTION_URL`, and the Meteor libraries 
  to use in the Ionic 2 application. If you change this configuration file, you have to run `.mobile$ meteor-client bundle -c meteor-client.config.json` in order to apply changes.
- `ionic.config.json` - This file is useful when you use Ionic Cloud to run the mobile application. For this, you have to do the [Ionic Cloud setup](https://docs.ionic.io/setup.html).

