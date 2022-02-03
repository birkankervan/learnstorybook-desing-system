export PATH=$(npm bin):$PATH

VERSION=`auto version`

echo "$VERSION"
echo "$PATH"

## Support for label 'skip-release'
if [ ! -z "$VERSION" ]; then
  ## Update Changelog
  auto changelog
  
  ## Publish Package

  npm version $VERSION -m "Bump version to: %s [skip ci]"
  npm publish 

  ## Create GitHub Release
  git push --follow-tags --set-upstream origin main
  auto release
fi