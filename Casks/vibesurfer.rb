# Hand-authored. Future versions will regenerate this from the
# release-pipeline outputs to mirror agented's GoReleaser flow.
cask "vibesurfer" do
  version "0.2.3"

  on_macos do
    on_arm do
      sha256 "ab8820f3533a1da1b1066ce03263209a8e4499eb14d2acc3d37c902eb5e5d7c8"
      url "https://github.com/frane/vibesurfer/releases/download/v#{version}/vs-v#{version}-aarch64-apple-darwin.tar.gz",
        verified: "github.com/frane/vibesurfer"
    end
    on_intel do
      sha256 "e3bbda0d57c368700268fdf91b17cd6e7915d625803d818721b7b0ff83b3e222"
      url "https://github.com/frane/vibesurfer/releases/download/v#{version}/vs-v#{version}-x86_64-apple-darwin.tar.gz",
        verified: "github.com/frane/vibesurfer"
    end
  end

  on_linux do
    on_intel do
      sha256 "c372d5509831da691ecb39e3c54dd86f511513528717959cffc8011216086ae3"
      url "https://github.com/frane/vibesurfer/releases/download/v#{version}/vs-v#{version}-x86_64-unknown-linux-gnu.tar.gz",
        verified: "github.com/frane/vibesurfer"
    end
  end

  name "vibesurfer"
  desc "A browser for LLMs, not humans."
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
