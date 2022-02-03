export PATH=$(npm bin):$PATH

VERSION=`auto version`

GITHUB_TOKEN=$GITHUB_TOKEN
NPM_TOKEN=$NPM_TOKEN

echo "GITHUB_TOKEN: $NPM_TOKEN"
echo "NPM_TOKEN: $GITHUB_TOKEN"
## Support for label 'skip-release'
if [ ! -z "$VERSION" ]; then
  ## Update Changelog
  auto changelog
  
  cd ./dist
  ## Publish Package
  npm config set registry http://registry.npmjs.org
  npm version $VERSION -m "Bump version to: %s [skip ci]"
  npm publish 

  ## Create GitHub Release
  git push --follow-tags --set-upstream origin main
  auto release
fi