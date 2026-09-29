# MacFanPro Homebrew tap

Homebrew packages for MacFanPro.

```bash
brew tap macfanpro/tap
brew trust macfanpro/tap
brew install macfanpro
sudo macfanpro install
```

Homebrew 7 does not load formulae from third-party taps until they are trusted; `brew trust` is needed once.

For updates and removal, see [MacFanPro](https://github.com/macfanpro/macfanpro).

On Apple Silicon with macOS 14 or later, Homebrew installs a prebuilt bottle, so no Xcode is needed; elsewhere the formula builds the tagged source. It bundles the CLI, app and license notices. Root service installation is explicit (`sudo macfanpro install`); Homebrew never runs privileged setup inside its build sandbox.

## Maintenance

The [Update formula](.github/workflows/update-formula.yml) workflow follows MacFanPro's latest published release (drafts are ignored). Every hour it checks the release; when there is a new one it points the formula at the tag, builds a bottle, uploads it to a `macfanpro-<version>` release in this repository, checks that Homebrew pours it and that `brew test` passes, and only then commits the formula. To run it right after publishing a release:

```bash
gh workflow run update-formula.yml -R macfanpro/homebrew-tap
```
