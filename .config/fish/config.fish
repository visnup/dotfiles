if status is-interactive
    # Commands to run in interactive sessions can go here
    abbr --add dc docker compose
    abbr --add gti git
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

set -gx JAVA_HOME /opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home

# uv tool shims: frida, frida-ps, frida-trace, ...
fish_add_path $HOME/.local/bin

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/visnup/.lmstudio/bin
# End of LM Studio CLI section

