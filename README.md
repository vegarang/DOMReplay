# DOMReplay
Track, record and replay user-triggered changes to the HTML-DOM


# Getting started

This project is written entirely using coffeescript, buildt using grunt.js, and uses a small testserver based on
express.js with MongoDB

## Installing dependencies
Install Node.js and npm (Node package manager)

Then run

`$ npm install`

in the root directory to install all dev dependencies.

## Building project using grunt
There are multiple grunt build-targets, but if all you want is the javascript package, just run `grunt` from the project root.
The DOMReplay javascript file will then be in the `src/js` folder, while a minified javascript file can be found in `build`.

For development (including a simple express.js server), you will first need to start a Mongodb server:

`$ mongod --dbpath=devserver/data/`

Then, to run the grunt task to build and watch the coffeescript code (and restart the expressjs server when needed), run:

`$ grunt dev-full`

If you dont care about the server or examples (in other words, you have your own), run:

`$ grunt dev-project`

More stuff will come here later, at the moment the entire project is under heavy development, so everything is subject to change at any time..