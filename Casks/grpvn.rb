cask "grpvn" do
  version "0.13.3"

  on_macos do
    on_intel do
      sha256 "aa1a50923940ff6838ce59a1a671da26512e39627c9cc701d69750ff6cf2a8e9"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_darwin_x86_64.tar.gz"
    end
    on_arm do
      sha256 "872e782a64b5fa4e4b228dcf25caeafff958936d1371de698ca229d5bbab2b12"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_darwin_arm64.tar.gz"
    end
  end

  on_linux do
    on_intel do
      sha256 "5a6b158f4c0bc7d38fa784c3f9096692543539f8a5ac6151e61e3b2d5fe9cb1f"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_linux_x86_64.tar.gz"
    end
    on_arm do
      sha256 "2fcff937879cc4d9f07a635d2a81a140ee873eebe15c749533ada7ae313364e0"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_linux_arm64.tar.gz"
    end
  end

  name "grpvn"
  desc "Local-first peer chat protocol for AI agents."
  homepage "https://github.com/frane/grpvn"

  livecheck do
    skip "Auto-generated on release."
  end

  binary "grpvn"

  postflight_steps do
    on_macos do
      # Release tarballs are not codesigned. Strip the quarantine xattr
      # so macOS Gatekeeper does not SIGKILL the binary on first launch.
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}/grpvn"]
    end
  end

  caveats <<~EOS
    grpvn is a local-first peer chat substrate for AI agents. After install,
    run:
      grpvn skill install
    to drop SKILL.md into every detected agent's skills directory and wire
    the grpvn MCP server into each one's config in one shot.
  EOS
end
