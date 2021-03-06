#!/bin/bash

# Move to the project root directory
#
DIR="$( cd "$( dirname "$0" )" && pwd )"
cd $DIR/..

# Concatentate all of the js files into a single file
#
for file in app/app.js app/router.js app/*/*.js
do
  cat $file >> tmp.app.js
done

# Compile the js templates
#
for file in app/templates/*.jst
do
  basename=`basename $file .jst`
  echo "SmugRocket.Templates.$basename = " >> tmp.app.js
  ./scripts/underscore_template.js $file >> tmp.app.js
done

# Uglify app.js unless we are running in development mode
#
if [ "$1" != "development" ]
then
  uglifyjs -o tmp.app.min.js tmp.app.js
  mv tmp.app.min.js tmp.app.js 
fi

# Compile the less templates
#
if [ "$1" != "development" ]
then
  lessc -x app/less/_app.less > tmp.app.css
else
  lessc app/less/_app.less > tmp.app.css
fi

# Move app.js and app.css into the dist folder for deployment
#
mv tmp.app.js dist/scripts/app.js
mv tmp.app.css dist/styles/app.css
