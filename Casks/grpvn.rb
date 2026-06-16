cask "grpvn" do
  version "0.2.0"

  on_macos do
    on_intel do
      sha256 "23e81ddd151423156580e61aa24866757255611903904ef172f16ed754b8526c"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_darwin_x86_64.tar.gz",
        verified: "github.com/frane/grpvn"
    end
    on_arm do
      sha256 "84c10b573a97acdb56bd6553d762113de279f7b6b0aca5942974588dfec790d8"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_darwin_arm64.tar.gz",
        verified: "github.com/frane/grpvn"
    end
  end

  on_linux do
    on_intel do
      sha256 "edd02878260abca6030e1abb41ab8cc7f14bf90996e3cf7f5e148e3646bbc66f"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_linux_x86_64.tar.gz",
        verified: "github.com/frane/grpvn"
    end
    on_arm do
      sha256 "a61c7701443fb00acb5ff33c17610f8cbe70db8e0031bf0ef4fbc458d6ce7368"
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
