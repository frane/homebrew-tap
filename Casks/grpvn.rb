cask "grpvn" do
  version "0.9.0"

  on_macos do
    on_intel do
      sha256 "83c591983d0beb4070b74aeab6c1dde9840a7241380e125e7f667e8ce9eae43d"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_darwin_x86_64.tar.gz",
        verified: "github.com/frane/grpvn"
    end
    on_arm do
      sha256 "5f724ef92a9bce793614d1d0fb7b6281fd526c2d4b5030622d1a80991ff8e2ce"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_darwin_arm64.tar.gz",
        verified: "github.com/frane/grpvn"
    end
  end

  on_linux do
    on_intel do
      sha256 "664b867a54bd9e9621e2e76b47580010384a4d1875ed238721fb759e7afc57de"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_linux_x86_64.tar.gz",
        verified: "github.com/frane/grpvn"
    end
    on_arm do
      sha256 "c98d93c2a4c77ac2f9f6be19aaa871e15a6f21da220f035dd6ef753be20b1b94"
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
