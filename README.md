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

The formula builds the tagged source and bundles the CLI, app and license notices. Root service installation is explicit; Homebrew never runs privileged setup inside its build sandbox.
