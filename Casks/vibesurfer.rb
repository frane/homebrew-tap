# Hand-authored. Future versions will regenerate this from the
# release-pipeline outputs to mirror agented's GoReleaser flow.
cask "vibesurfer" do
  version "0.1.10"

  on_macos do
    on_arm do
      sha256 "7b7727360b07dd87109dae27901ede631e7e610d2697284facbc153938627241"
      url "https://github.com/frane/vibesurfer/releases/download/v#{version}/vs-v#{version}-aarch64-apple-darwin.tar.gz",
        verified: "github.com/frane/vibesurfer"
    end
    on_intel do
      sha256 "1204eb9a6a2e4d17360a83a3721b43501b111bc1df891f837da1bc3aca0cb5f2"
      url "https://github.com/frane/vibesurfer/releases/download/v#{version}/vs-v#{version}-x86_64-apple-darwin.tar.gz",
        verified: "github.com/frane/vibesurfer"
    end
  end

  on_linux do
    on_intel do
      sha256 "c56e3ffea1db8bfb295de9fc7e63bc84b4694d683762fbab4356f997c586f159"
      url "https://github.com/frane/vibesurfer/releases/download/v#{version}/vs-v#{version}-x86_64-unknown-linux-gnu.tar.gz",
        verified: "github.com/frane/vibesurfer"
    end
  end

  name "vibesurfer"
  desc "Agent-native headless browser (WKWebView / WebKitGTK / WebView2)."
  homepage "https://github.com/frane/vibesurfer"

  livecheck do
    skip "Manually authored; auto-regenerate from release pipeline planned."
  end

  binary "vs"

  postflight do
    if OS.mac?
      # Release tarballs are not codesigned. Strip the quarantine xattr
      # so macOS Gatekeeper does not block the binary on first launch.
      system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{staged_path}/vs"]
    end
  end

  caveats <<~EOS
    vibesurfer drives a real WebKit / WebKitGTK / WebView2 engine over a
    Unix-socket wire protocol. After install:

      vs skill install     # write SKILL.md + MCP config into Claude/Codex/etc.
      vs session-open      # start a session
      vs --help            # 20 primitives, short-form aliases enabled

    Linux runtime requires WebKitGTK 6 (libwebkitgtk-6.0).
  EOS
end
