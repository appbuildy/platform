#!/bin/bash

REVISION=$(git rev-parse head)

flutter build web
cp build/web/main.dart.js ~/projects/nocode/master_of_puppets/public/app_build/.
cp build/web/main.dart.js ~/projects/nocode/master_of_puppets/public/projects/.

cp -r assets/icons/ ~/projects/nocode/master_of_puppets/public/projects/.
cp -r assets/icons/ ~/projects/nocode/master_of_puppets/public/app_build/.

cd ~/projects/nocode/master_of_puppets
sed -i '' 's/assets\//https:\/\/www.appbuildy.com\/app_build\//g' ~/projects/nocode/master_of_puppets/public/app_build/main.dart.js
sed -i '' 's/assets\//https:\/\/www.appbuildy.com\/app_build\//g' ~/projects/nocode/master_of_puppets/public/projects/main.dart.js

git add public/
git commit -m "Update platform build to $REVISION"
git push origin master
git push heroku master
