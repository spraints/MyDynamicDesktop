const fs = require('fs')
const { Octokit } = require('@octokit/rest')

async function main() {
  const tag = process.argv[2]
  const archive = process.argv[3]

  if (!tag || !archive) {
    console.log('Usage: publishrelease.js TAG ARCHIVE')
    process.exit(1)
  }

  const octokitOpts = {auth: process.env.GITHUB_TOKEN}
  if (process.env.GITHUB_API) {
    octokitOpts['baseUrl'] = process.env.GITHUB_API
  }
  const octokit = new Octokit(octokitOpts)

  const release = {owner: 'spraints', repo: 'MyDynamicDesktop', tag_name: tag}
  console.log(['createRelease', release])
  const createRes = await octokit.repos.createRelease({owner: 'spraints', repo: 'MyDynamicDesktop', tag_name: tag})
  console.log(createRes.data.html_url)

  const upload = {
    url: createRes.data.upload_url,
    headers: {
      'content-type': 'x-tar',
      'content-length': fs.statSync(archive).size
    },
    name: archive
  }
  console.log(['uploadReleaseAsset', upload])
  upload.data = fs.createReadStream(archive)
  await octokit.repos.uploadReleaseAsset(upload)
}

main().then(() => console.log('Done.'), e => console.log(['error', e]))
