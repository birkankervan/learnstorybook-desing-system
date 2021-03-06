export PATH=$(npm bin):$PATH

VERSION=`auto version`

## Support for label 'skip-release'
if [ ! -z "$VERSION" ]; then
  ## Update Changelog
  auto changelog

  ## Publish Package
  yarn config set strict-ssl false
  yarn version --new-version $VERSION -m "Bump version to: %s [skip ci]"
  npm publish

  ## Create GitHub Release
  git push --follow-tags --set-upstream origin $branch
  auto release
fi