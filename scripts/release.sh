export PATH=$(npm bin):$PATH

VERSION=`auto version`

## Support for label 'skip-release'
if [ ! -z "$VERSION" ]; then
  ## Update Changelog
  auto changelog
  
  cp package.json ./dist
  cd ./dist
  ## Publish Package
  npm config set registry https://github.com/birkankervan/learnstorybook-desing-system
  
  npm version $VERSION -m "Bump version to: %s [skip ci]"
  npm publish 

  ## Create GitHub Release
  git push --follow-tags --set-upstream origin main
  auto release
fi