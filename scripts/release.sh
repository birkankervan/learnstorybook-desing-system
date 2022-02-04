export PATH=$(npm bin):$PATH

VERSION=`auto version`

## Support for label 'skip-release'
if [ ! -z "$VERSION" ]; then
  ## Update Changelog
  auto changelog

  ## Publish Package
  yarn version --new-version $VERSION -m "Bump version to: %s [skip ci]"
  yarn publish

  ## Create GitHub Release
  git push --follow-tags --set-upstream origin $branch
  auto release
fi