#!/usr/bin/env node

const ejs = require('ejs')
const fs = require('fs')
const path = require('path')

const homepageSrc = fs.readFileSync(path.join(__dirname, '../index.ejs'), 'utf8')
const apilevels = fs.readdirSync(path.join(__dirname, '../dist/docs'))
  .filter((name) => name !== 'latest')

const outputs = ejs.render(homepageSrc, {
  apilevels,
  yodaosVersion: '7.29'
})
process.stdout.write(outputs)
