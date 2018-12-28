'use strict'

const path = require('path')
const axios = require('axios')
const _ = require('lodash')

async function listRelease () {
  const res = await axios.get('https://yodaos-project.github.io/release/yodaos.json')
  return _.toPairs(
    _.groupBy(res.data.linux, 'category'))
}

exports.listRelease = listRelease

function getReleaseName (url) {
  return path.basename(url)
}
exports.getReleaseName = getReleaseName
