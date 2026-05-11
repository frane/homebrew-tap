# Hand-authored for v0.1.0; future versions will regenerate this from
# the release-pipeline outputs to mirror agented's GoReleaser flow.
cask "vibesurfer" do
  version "0.1.0"

  on_macos do
    on_arm do
      sha256 "e34033e6ab1bcfc77496608ffb5af238163ea61eb736b7d8541038e678dc6266"
      url "https://github.com/frane/vibesurfer/releases/download/v#{version}/vs-v#{version}-aarch64-apple-darwin.tar.gz",
        verified: "github.com/frane/vibesurfer"
    end
    # x86_64 darwin build is added in a follow-up — the macos-13 runner
    # queue stalled during v0.1.0's release pipeline. Apple Silicon
    # users get the cask path; Intel Mac users fall back to install.sh
    # or `cargo install --path crates/vs-cli` until the next release.
  end

  on_linux do
    on_intel do
      sha256 "727e09b39b695d66f3a845746227cdaf2dab75974685fed469bdb1ff7b1647c6"
      url "https://github.com/frane/vibesurfer/releases/download/v#{version}/vs-v#{version}-x86_64-unknown-linux-gnu.tar.gz",
        verified: "github.com/frane/vibesurfer"
    end
    # Linux aarch64 is not built in v0.1.0's release pipeline — add in
    # a follow-up if there's demand.
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
