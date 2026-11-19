# Hand-authored. Future versions will regenerate this from the
# release-pipeline outputs to mirror agented's GoReleaser flow.
cask "vibesurfer" do
  version "0.2.11"

  on_macos do
    on_arm do
      sha256 "230245a7030489971bd7cff4c4e9a169789607cbd481d7bc6d955b4911d84dda"
      url "https://github.com/frane/vibesurfer/releases/download/v#{version}/vs-v#{version}-aarch64-apple-darwin.tar.gz"
    end
    on_intel do
      sha256 "1f8ff27f88f2757b74d870d7c67eb1cd51fb3ed9d4a6473ebc7e99d7e39f0aca"
      url "https://github.com/frane/vibesurfer/releases/download/v#{version}/vs-v#{version}-x86_64-apple-darwin.tar.gz"
    end
  end

  on_linux do
    on_intel do
      sha256 "08e8dfa6f9e9b231f4d4a54eb78c4f65d79f83be3d2d8dd72471576f45753a67"
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

