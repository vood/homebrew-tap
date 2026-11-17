cask "fitlock" do
  version "1.1.1"
  sha256 "9f5cd393ad2a3484324a7812dc96cf60822feaf69b610e5d27809616e7f4bf89"

  url "https://github.com/vood/fitlock/releases/download/v#{version}/fitlock-#{version}.dmg"
  name "fitlock"
  desc "Menu-bar agent that locks the screen until your Fitbit reports steps"
  homepage "https://github.com/vood/fitlock"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  binary "fitlock"

  # An upgrade removes the old agent; put it back when one was set up before.
  postflight_steps do
    if_path_exists "~/.config/fitlock/config.json" do
      run "fitlock", args: ["install"]
    end
  end

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
