#!/usr/bin/env node

const ejs = require('ejs')
const fs = require('fs')
const path = require('path')
const axios = require('axios')

const name = process.argv[2]
const filename = path.join(__dirname, `../pages/${name}.ejs`)
const src = fs.readFileSync(filename, 'utf8')
const apilevels = fs.readdirSync(path.join(__dirname, '../dist/docs'))
  .filter((name) => name !== 'latest')

!(async function main () {
  const releases = await axios.get('https://yodaos-project.github.io/release/yodaos.json')
  const outputs = ejs.render(src, {
    apilevels,
    releases: releases.data,
    yodaosVersion: '7.29'
  }, {
    filename,
    root: path.join(__dirname, '../pages/')
  })
  process.stdout.write(outputs)
})()
