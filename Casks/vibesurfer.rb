# Hand-authored. Future versions will regenerate this from the
# release-pipeline outputs to mirror agented's GoReleaser flow.
cask "vibesurfer" do
  version "0.1.24"

  on_macos do
    on_arm do
      sha256 "b77ba9448238e677583fa837f017e7ca025d214e7b71d27c934df9b3de7abfe3"
      url "https://github.com/frane/vibesurfer/releases/download/v#{version}/vs-v#{version}-aarch64-apple-darwin.tar.gz",
        verified: "github.com/frane/vibesurfer"
    end
    on_intel do
      sha256 "47332aae50164ef06fa2ba92cbd79f5af76b3028c05e88515198ab7d53e0b437"
      url "https://github.com/frane/vibesurfer/releases/download/v#{version}/vs-v#{version}-x86_64-apple-darwin.tar.gz",
        verified: "github.com/frane/vibesurfer"
    end
  end

  on_linux do
    on_intel do
      sha256 "29f910a7a6bcad629db848f702b69576bd7a87a3a5e1e3d7c91fff492286d52a"
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
