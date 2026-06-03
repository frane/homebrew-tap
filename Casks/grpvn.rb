cask "grpvn" do
  version "0.1.3"

  on_macos do
    on_intel do
      sha256 "8fd916057c5204677575049658e0c33a5a008caaf78f82da305011eb6708d185"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_darwin_x86_64.tar.gz",
        verified: "github.com/frane/grpvn"
    end
    on_arm do
      sha256 "6024afa63ea23be030d4913cf86692203de575f270117125bacf42a5a36c48f3"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_darwin_arm64.tar.gz",
        verified: "github.com/frane/grpvn"
    end
  end

  on_linux do
    on_intel do
      sha256 "221e32de6c7c62e026d0f0a194199cd164f340255de522fdcfa53cb635f9e2c4"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_linux_x86_64.tar.gz",
        verified: "github.com/frane/grpvn"
    end
    on_arm do
      sha256 "6054862b1b3c6fd4870a0987ec8017fd27baea7741c3d0d716321b1527fa42e9"
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
      system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{staged_path}/grpvn"]
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
