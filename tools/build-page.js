#!/usr/bin/env node

const ejs = require('ejs')
const fs = require('fs')
const path = require('path')
const listRelease = require('./helper').listRelease
const getReleaseName = require('./helper').getReleaseName

const name = process.argv[2]
const filename = path.join(__dirname, `../pages/${name}.ejs`)
const src = fs.readFileSync(filename, 'utf8')
const apilevels = fs.readdirSync(path.join(__dirname, '../dist/docs'))
  .filter((name) => name !== 'latest')


!(async function main () {
  const outputs = ejs.render(src, {
    // data
    apilevels,
    releases: (await listRelease()),
    yodaosVersion: '7.29',
    // methods
    getReleaseName,
  }, {
    filename,
    root: path.join(__dirname, '../pages/')
  })
  process.stdout.write(outputs)
})()
