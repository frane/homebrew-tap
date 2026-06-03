cask "grpvn" do
  version "0.1.1"

  on_macos do
    on_intel do
      sha256 "e76069f0bb867edff64a0f6dd973473dcfad25d5901930065caf8e32d0378b4f"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_darwin_x86_64.tar.gz",
        verified: "github.com/frane/grpvn"
    end
    on_arm do
      sha256 "7cc906cc1118c4b349fe3dc9777ea4029dba2bdcf3d05e82c67d21151a852e84"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_darwin_arm64.tar.gz",
        verified: "github.com/frane/grpvn"
    end
  end

  on_linux do
    on_intel do
      sha256 "8c235fbab27c3380e277ab756b8fa8e2e207ad1edc4eb7e921a6141b445f985c"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_linux_x86_64.tar.gz",
        verified: "github.com/frane/grpvn"
    end
    on_arm do
      sha256 "7d8456fa2a18e7e084218bbb217d8ad605a3c48d23ae4155a70b7d63897d4076"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_linux_arm64.tar.gz",
        verified: "github.com/frane/grpvn"
    end
  end

  name "grpvn"
  desc "Local-first peer chat protocol for AI agents."
  homepage "https://github.com/frane/grpvn"

  livecheck do
    skip "Auto-generated on release."
  end

  binary "grpvn"

  postflight do
    if OS.mac?
      # Release tarballs are not codesigned. Strip the quarantine xattr
      # so macOS Sequoia Gatekeeper does not SIGKILL the binary on first
      # invocation.
      system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{staged_path}/grpvn"]
    end
  end

  # No zap stanza required

  caveats <<~EOS
    grpvn is a local-first peer chat substrate for AI agents. After install,
    run:
      grpvn skill install
    to drop SKILL.md into every detected agent's skills directory and wire
    the grpvn MCP server into each one's config in one shot.
  EOS
end
