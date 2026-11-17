cask "fitlock" do
  version "1.1.0"
  sha256 "82c6cf1a89fce03391dbf9e2ed911d7640152c7bad4912cf42210ae14ab701b3"

  url "https://github.com/vood/fitlock/releases/download/v#{version}/fitlock-#{version}.dmg"
  name "fitlock"
  desc "Menu-bar agent that locks the screen until your Fitbit reports steps"
  homepage "https://github.com/vood/fitlock"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  binary "fitlock"

  uninstall launchctl: "io.fitlock.agent",
            delete:    [
              "~/.local/bin/fitlock",
              "~/Library/LaunchAgents/io.fitlock.agent.plist",
            ]

  zap trash: [
    "~/.config/fitlock",
    "~/.local/state/fitlock",
  ]

  caveats <<~EOS
    To keep fitlock running in the menu bar, and to connect your tracker:
      fitlock install
      fitlock auth
    "auth" needs your own Google OAuth client file first:
      https://github.com/vood/fitlock#install
  EOS
end
