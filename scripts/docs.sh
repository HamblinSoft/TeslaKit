#
jazzy \
  --clean \
  --author Jaren Hamblin \
  #--author_url https://realm.io \
  --github_url https://github.com/Jarious-Apps/TeslaKit \
  #--github-file-prefix https://github.com/realm/realm-cocoa/tree/v0.96.2 \
  --module-version 0.1.0 \
  #--xcodebuild-arguments -scheme,Mock \
  --module TeslaApp \
  #--root-url https://realm.io/docs/swift/0.96.2/api/ \
  --output ./docs/ \
  #--exclude=App/*,UI/*,Resources/* \
