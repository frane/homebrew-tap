# Hand-authored. Future versions will regenerate this from the
# release-pipeline outputs to mirror agented's GoReleaser flow.
cask "vibesurfer" do
  version "0.2.17"

  on_macos do
    on_arm do
      sha256 "ed78b0a9e15824abce483f5fbe70bf1334ab53319d0a0f30f6d879bd48f20020"
      url "https://github.com/frane/vibesurfer/releases/download/v#{version}/vs-v#{version}-aarch64-apple-darwin.tar.gz"
    end
    on_intel do
      sha256 "73d40c30b1509305241c72bcebb7b3fc3a34e6c32fae837cabe4829ee0d495e3"
      url "https://github.com/frane/vibesurfer/releases/download/v#{version}/vs-v#{version}-x86_64-apple-darwin.tar.gz"
    end
  end

  on_linux do
    on_intel do
      sha256 "3ca7f20ab89c891e11b8f647f3cc752cf33aebe3bb78ffa574ccf006573f490c"
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

