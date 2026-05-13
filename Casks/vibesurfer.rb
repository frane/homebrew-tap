# Hand-authored for v0.1.1. Future versions will regenerate this from
# the release-pipeline outputs to mirror agented's GoReleaser flow.
cask "vibesurfer" do
  version "0.1.1"

  on_macos do
    on_arm do
      sha256 "69cf04353fcaa67eea6705edca9dce0ec931aa8dba93afcf378dd00d5beee66b"
      url "https://github.com/frane/vibesurfer/releases/download/v#{version}/vs-v#{version}-aarch64-apple-darwin.tar.gz",
        verified: "github.com/frane/vibesurfer"
    end
    # x86_64 darwin is still pending: the macos-13 runner queue has
    # not allocated for v0.1.0 or v0.1.1 within the workflow window.
    # Apple Silicon users get the cask; Intel Mac users fall back to
    # install.sh or `cargo install --path crates/vs-cli`.
  end

  on_linux do
    on_intel do
      sha256 "76070539e3c225e0bbae7ac43dc07ec5a7c89f7306d337bfb4fe98dfd6fcd466"
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
