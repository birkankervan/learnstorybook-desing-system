export PATH=$(npm bin):$PATH

VERSION=`auto version`

## Support for label 'skip-release'
if [ ! -z "$VERSION" ]; then
  ## Update Changelog
  auto changelog
  cp package.json ./dist
  ## Publish Package
  npm version $VERSION -m "Bump version to: %s [skip ci]"
  npm publish ./dist

  ## Create GitHub Release
  git push --follow-tags --set-upstream origin $branch
  auto release
fi