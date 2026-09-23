cask "grpvn" do
  version "0.9.3"

  on_macos do
    on_intel do
      sha256 "610420919fab0560fa7b2eb1a0edcec54f7a0103b96a9f93d2c805bbed9737e8"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_darwin_x86_64.tar.gz"
    end
    on_arm do
      sha256 "769c12f715d5ea39343e6f6bd7c175307f6cfc2980504b8499f481040410c1dd"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_darwin_arm64.tar.gz"
    end
  end

  on_linux do
    on_intel do
      sha256 "11b23041bd22e2dd6a90e9610189048fa637faaf9f82e119cfd8252c1b763ae8"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_linux_x86_64.tar.gz"
    end
    on_arm do
      sha256 "6926a92b8d51b8d81f1582bbadc423e167dac9830d20f1e2c15344fa274e8e18"
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
