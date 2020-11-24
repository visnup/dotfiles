function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -l normal (set_color $fish_color_autosuggestion)

    z --add $PWD

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l prefix
    set -l suffix '$'
    if contains -- $USER root toor
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # If we're running via SSH, change the host color.
    set -l color_host $fish_color_autosuggestion
    if set -q SSH_TTY
        set color_host $fish_color_host_remote
    end

    # Simplest vcs prompt
    set -l git_branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
    set -l git " $git_branch "
    if [ $git = "  " ]
        set git ''
    end

    # Write pipestatus
    set -l prompt_status (__fish_print_pipestatus "[" "] " "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)

    # Fill with ---
    set -l length (echo -s "[ 00:00 AM -" $git (prompt_hostname) " " (prompt_pwd) " ]" | wc -c | tr -d ' ')
    set -l fill (printf '%*s\n' (math (tput cols)-$length) '' | tr ' ' –)

    echo $normal
    echo -s "[ " (date +'%I:%M %p') " –" (set_color $fish_color_param) $git $normal $fill " " (set_color $color_host) (prompt_hostname) " " (set_color $fish_color_cwd) (prompt_pwd) $normal " ]"
    echo -n -s $prompt_status $suffix " "
end
