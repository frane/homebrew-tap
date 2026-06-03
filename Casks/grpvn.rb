cask "grpvn" do
  version "0.1.4"

  on_macos do
    on_intel do
      sha256 "b1224a2ecb7939a012b7a4bdfa056b519c364ab03139338810bba955c0901412"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_darwin_x86_64.tar.gz",
        verified: "github.com/frane/grpvn"
    end
    on_arm do
      sha256 "8d85e6f5b2c67afbb2bc38a446e65a83530964e2516f98632749a427fb6f3f59"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_darwin_arm64.tar.gz",
        verified: "github.com/frane/grpvn"
    end
  end

  on_linux do
    on_intel do
      sha256 "06e4e9dc2500a576dd5599c7916675967dee0732764c99729c7bf80a6df89f1d"
      url "https://github.com/frane/grpvn/releases/download/v#{version}/grpvn_#{version}_linux_x86_64.tar.gz",
        verified: "github.com/frane/grpvn"
    end
    on_arm do
      sha256 "5b355b32fd021d2a986db5207f29bde03a1f4a6dfd9d460e8a70e5b5d8b6da07"
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
