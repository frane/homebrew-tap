# Hand-authored. Future versions will regenerate this from the
# release-pipeline outputs to mirror agented's GoReleaser flow.
cask "vibesurfer" do
  version "0.2.21"

  on_macos do
    on_arm do
      sha256 "9591cef503a00dea0d8e9f716914fe7a4ce686ab03ef191667ecc012c7f8978d"
      url "https://github.com/frane/vibesurfer/releases/download/v#{version}/vs-v#{version}-aarch64-apple-darwin.tar.gz"
    end
    on_intel do
      sha256 "5c57204f0456b1e60a45186acd542fce7235512841abbd8856293d1c677525f1"
      url "https://github.com/frane/vibesurfer/releases/download/v#{version}/vs-v#{version}-x86_64-apple-darwin.tar.gz"
    end
  end

  on_linux do
    on_intel do
      sha256 "ad1d8220e509f6d791b28469fdc687a6d04a5be33ca463441d32e6b65e2702f2"
      url "https://github.com/frane/vibesurfer/releases/download/v#{version}/vs-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
    end
  end

  name "vibesurfer"
  desc "A browser for LLMs, not humans."
  homepage "https://github.com/frane/vibesurfer"

  livecheck do
    skip "Manually authored; auto-regenerate from release pipeline planned."
  end

  binary "vs"

  postflight_steps do
    on_macos do
      # Release tarballs are not codesigned. Strip the quarantine xattr
      # so macOS Gatekeeper does not block the binary on first launch.
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}/vs"]
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

