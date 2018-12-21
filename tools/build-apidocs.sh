#!/usr/bin/env bash

ROOT_DIR=.tmp
DEST_DIR=dist/docs
JSDOC=./node_modules/.bin/jsdoc

init_source() {
  rm -rf $ROOT_DIR
  mkdir -p $ROOT_DIR
  git clone git@github.com:yodaos-project/yodart.git $ROOT_DIR/yodart
}

init_target() {
  rm -rf $DEST_DIR
  mkdir -p $DEST_DIR
}

git_checkout() {
  cd $ROOT_DIR/yodart
  git checkout $1
  cd ../../
}

build_apidoc() {
  echo "\nbuilding apidoc for $1 on $2"
  git_checkout $1
  $JSDOC -c jsdoc.config \
    -R $ROOT_DIR/yodart/README.md \
    -r $ROOT_DIR/yodart \
    -u ./tutorials \
    -d $DEST_DIR/$2
}

build_latest() {
  build_apidoc master latest
}

build_tags() {
  cd $ROOT_DIR/yodart
  declare -a list=(`git tag | grep apilevel`)
  for elem in "${list[@]}"
  do
    local id=`echo $elem | sed -e 's/apilevel-//g'`
    build_apidoc $elem $id
  done
  cd ../../
}

init_source
init_target
build_latest
build_tags
