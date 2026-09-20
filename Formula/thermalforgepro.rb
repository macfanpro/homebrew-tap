class Thermalforgepro < Formula
  desc "Apple Silicon fan control with an English and Chinese menu bar app"
  homepage "https://github.com/hongyukeji/ThermalForgePro"
  url "https://github.com/hongyukeji/ThermalForgePro.git", tag: "v0.3.1", revision: "d3c1da4e5df77098ece5273db093b4ac56f574d4"
  license "MIT"

  depends_on xcode: ["16.0", :build]
  depends_on macos: :sonoma
  depends_on arch: :arm64

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox", "--force-resolved-versions"
    system ".build/release/thermalforgepro", "build-app",
           "--binary", ".build/release/ThermalForgeProApp",
           "--icon", "ThermalForgePro.icns",
           "--dest", "#{prefix}/ThermalForgePro.app"
    system "codesign", "--force", "--deep", "--sign", "-", "#{prefix}/ThermalForgePro.app"
    bin.install ".build/release/thermalforgepro"
    pkgshare.install "LICENSE", "NOTICE.md", "ThirdPartyNotices"
  end

  def caveats
    <<~EOS
      Install or synchronize the root-owned daemon and menu bar app:
        sudo thermalforgepro install

      To replace an existing ThermalForge installation:
        sudo thermalforgepro install --migrate-thermalforge
        brew uninstall thermalforge

      Open /Applications/ThermalForgePro.app and enable Launch at Login if wanted.
      After brew upgrade, run sudo thermalforgepro install again.

      Before brew uninstall, remove the privileged runtime:
        sudo thermalforgepro uninstall
      User profiles, calibration and logs are preserved unless --purge-data is used.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/thermalforgepro --version").strip
    assert_match "Fan control", shell_output("#{bin}/thermalforgepro --help")
    assert_match "--migrate-thermalforge", shell_output("#{bin}/thermalforgepro install --help")
    app = prefix/"ThermalForgePro.app"
    assert_equal "io.github.hongyukeji.thermalforgepro.app",
                 shell_output("/usr/libexec/PlistBuddy -c 'Print CFBundleIdentifier' #{app}/Contents/Info.plist").strip
    assert_path_exists app/"Contents/Resources/LICENSE"
    assert_path_exists app/"Contents/Resources/ThermalForgePro_ThermalForgeProLocalization.bundle"
    system "codesign", "--verify", "--deep", "--strict", app
  end
end
