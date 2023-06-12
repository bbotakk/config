# Directories to search for custom commands in interactive mode
let-env NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts')
]

# source all scripts that need to be loaded (save theme configs, define custom commands...)
# source "~/.config/nushell/scripts/solarized.nu"
# source "~/.config/nushell/scripts/extract.nu"

# Directories to search for plugin binaries when calling register
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins')
]

# Nushell Environment Config File
let-env STARSHIP_SHELL = "nu"

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = {|| create_left_prompt}
let-env PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = ""
let-env PROMPT_INDICATOR_VI_INSERT = ""
let-env PROMPT_INDICATOR_VI_NORMAL = ""
let-env PROMPT_MULTILINE_INDICATOR = ".. "


# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: {|s| $s | split row (char esep) | path expand -n}
    to_string: {|v| $v | path expand -n | str join (char esep)}
  }
  "Path": {
    from_string: {|s| $s | split row (char esep) | path expand -n}
    to_string: {|v| $v | path expand -n | str join (char esep)}
  }
}

