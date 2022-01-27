export PATH=$(npm bin):$PATH

VERSION=`auto version`

## Support for label 'skip-release'
if [ ! -z "$VERSION" ]; then
  ## Update Changelog
  auto changelog
  npm run build
  cp package.json ./dist
# or, if you need to have package.json "main" entry different,
# e.g. for being able to use `npm link`, you need to replace "main" value:
# sed 's#"main": "./dist/index.js"#"main": "./index.js"#' package.json > ./dist/package.json
  cd ./dist
  npm publish

  cd dist
  ## Publish Package
  npm version $VERSION -m "Bump version to: %s [skip ci]"
  npm publish
  cd ..

  ## Create GitHub Release
  git push --follow-tags --set-upstream origin main
  auto release
fi