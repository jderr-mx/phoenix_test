# Example Project to tag releases using release-it with release-it-learn-changelog

## Purpose
To automate aggregating PRs and appending to the CHANGELOG and putting PRs into release notes

### How does it work?

[release-it](https://github.com/release-it/release-it) and a relase-it plugin for [lerna-changelog](https://github.com/lerna/lerna-changelog)
are added as dev dependencies

release-it is typically used for package management when publishing npm packages. 
There is the option to not publish to npm and use it to cut release tags in your github project

lerna-changelog handles the task of updating the change log and compiling the PRs that were merged in since 
the last release. 

release-it is configured in the package.json

a few things to note:

If using yarn the `releaseNotes` command would be `yarn --silent lerna-changelog --nextVersion=Released`

The repo info is inferred from the package.json and best I can tell needs to be in the root of the repo for projects that do not have the
package.json in the root (like this phoenix app) the package.json gets symlinked to the root in the ci process :sob:
When the release-it command is run it will be run from the working directory that contains the package.json for this project is `assets/`

```json
  "release-it": {
    "plugins": {
      "release-it-lerna-changelog": {
        "infile": "CHANGELOG.md"
      }
    },
    "git": {
      "tagName": "v${version}"
    },
    "github": {
      "release": true,
      "releaseNotes": "npx --quiet lerna-changelog --nextVersion=Released",
      "tokenRef": "GITHUB_AUTH"
    },
    "npm": {
      "publish": false
    }
  }

```

The PRs that are included in the release note the ones that are tagged with these labels by default

* breaking
* enhancement
* bug
* documentation
* internal

They are rendered in Markdown like this: 

#### :boom: Breaking Change

#### :rocket: Enhancement

#### :bug: Bug Fix

#### :memo: Documentation

#### :house: Internal

The PRs can be tagged after they are merged in prior to cutting a release. 

Once PRs are tagged running release it can be run manually or from a ci process

I have setup a github action that runs it with the command
`npx release-it minor --ci`  or `yarn release-it minor --ci` would also do so 

This will bump the package.json a minor number, append the tagged PRs since the last release to the CHANGELOG.md, and add all the tagged PRs since the
last release as the release notes. The CHANGELOG.md, package.json and possibly the lockfile will be commited back to the repo.  
(yarn.lock does not but package-lock.json does, I think :smirk:)

git requires that a git user name and email are configured when running from a github action
I've have it set to be configured in the repo secrets and then run in the action like this

```
  git config user.email ${{ secrets.USER_EMAIL }}
  git config user.name ${{ secrets.USER_NAME }}
```
