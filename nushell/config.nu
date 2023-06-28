# custom nu scripts to import
use extract.nu
use lf.nu
use md.nu
use wa.nu

# load standard library: more custom commands
use std

# better programs:
# cat -> bat
alias x =       chmod +x
alias e =       emacsclient  -c
alias emacs =   emacsclient  -c # attach emacs to daemon that is running in background
alias gs =      git status
alias gp =      git push
alias ga =      git add
alias diff =    diff --color=auto
alias ip =      ip -color=auto
alias bat =     bat
alias ls =      ls -d # disk usage in human readable formate
alias dnfs =    sudo dnf search
alias dnfi =    sudo dnf -y install
alias dnfu =    sudo dnf -y update
alias dnfr =    sudo dnf -y remove

let-env PATH = ($env.PATH | append ['~/Code/scripts', '~/.config/scripts', '~/.cargo/bin', "~/.config/emacs/bin"])

let-env EDITOR = 'emacs -nw' # emacs in the terminal
let-env VISUAL = 'emacsclient -c' # gui emacs
let-env BROWSER = 'firefox'
let-env MANPAGER = 'bat'
let-env PAGER = "bat"
let-env BAT_THEME = "Solarized (light)"


# get juicy custom completions from fish shell into nushell until it supports it natively
let fish_completer = {|spans|
    fish --command $'complete "--do-complete=($spans | str join " ")"'
    | str trim
    | split row "\n"
    | each { |line| $line | split column "\t" value description }
    | flatten
}

# The default config record. This is where much of your global configuration is setup.
let-env config = {
	show_banner: false # true or false to enable or disable the welcome banner at startup
	ls: {
		use_ls_colors: true # use the LS_COLORS environment variable to colorize output
		clickable_links: true # enable or disable clickable links. Your terminal has to support links.
	}
	rm: {always_trash: true} # always act as if -t was given. Can be overridden with -p
	cd: {abbreviations: false} # allows `cd s/o/f` to expand to `cd some/other/folder`
	table: {
		mode: compact # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
		index_mode: always # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
		show_empty: true # show 'empty list' and 'empty record' placeholders for command output
		trim: {
			methodology: wrapping # wrapping or truncating
			wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
			truncating_suffix: "..." # A suffix used by the 'truncating' methodology
		}
	}

	explore: {
		help_banner: true
		exit_esc: true
		command_bar_text: '#C4C9C6'
		# command_bar: {fg: '#C4C9C6' bg: '#223311' }
		status_bar_background: {fg: '#1D1F21', bg: '#C4C9C6' }
		# status_bar_text: {fg: '#C4C9C6' bg: '#223311' }
		highlight: {bg: 'yellow', fg: 'black' }
		status: {
		  # warn: {bg: 'yellow', fg: 'blue'}
		  # error: {bg: 'yellow', fg: 'blue'}
		  # info: {bg: 'yellow', fg: 'blue'}
		}
		try: {
			# border_color: 'red'
			# highlighted_color: 'blue'
			# reactive: false
		}
		table: {
			split_line: '#404040'
			cursor: true
			line_index: true
			line_shift: true
			line_head_top: true
			line_head_bottom: true
			show_head: true
			show_index: true
			# selected_cell: {fg: 'white', bg: '#777777'}
			# selected_row: {fg: 'yellow', bg: '#C1C2A3'}
			# selected_column: blue
			# padding_column_right: 2
			# padding_column_left: 2
			# padding_index_left: 2
			# padding_index_right: 1
		}
		config: {
			cursor_color: {bg: 'yellow', fg: 'black' }
			# border_color: white
			# list_color: green
		}
	}

	history: {
		max_size: 10000 # Session has to be reloaded for this to take effect
		sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
		file_format: "plaintext" # "sqlite" or "plaintext"
	}

	completions: {
		case_sensitive: false # set to true to enable case-sensitive completions
		quick: true  # set this to false to prevent auto-selecting completions when only one remains
		partial: true  # set this to false to prevent partial filling of the prompt
		algorithm: "prefix"  # prefix or fuzzy
		external: {
			enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up my be very slow
			max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
			completer: $fish_completer # check 'carapace_completer' above as an example
		}
	}

	filesize: {
		metric: true # true => KB, MB, GB (ISO standard), false => KiB, MiB, GiB (Windows standard)
		format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, zb, zib, auto
	}

	cursor_shape: {
		emacs: line # block, underscore, line (line is the default)
		vi_insert: line # block, underscore, line (block is the default)
		vi_normal: block # block, underscore, line  (underscore is the default)
	}

	color_config: (solarized)
	use_grid_icons: true
	footer_mode: "25" # always, never, number_of_rows, auto
	float_precision: 2 # the precision for displaying floats in tables
	use_ansi_coloring: true
	edit_mode: vi # emacs, vi
	shell_integration: true # enables terminal markers and a workaround to arrow keys stop working issue
	render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.

	hooks: {
		pre_prompt: [ {||
			null  # replace with source code to run before the prompt is shown
		} ]
		pre_execution: [ {||
			null  # replace with source code to run before the repl input is run
		} ]
		env_change: {
			PWD: [ {|before, after|
				null  # replace with source code to run if the PWD environment is different since the last repl input
			} ]
		}
		display_output: {||
			if (term size).columns >= 100 {table -e } else { table}
		}
		command_not_found: {||
			null  # replace with source code to return an error message when a command is not found
		}
	}

	menus: [  # Configuration for default nushell menus
		{name: completion_menu
		only_buffer_difference: false
		marker: "| "
		type: {
			layout: columnar
			columns: 1
			col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
			col_padding: 2
		}
		style: {
			text: green
			selected_text: green_reverse
			description_text: yellow
		}}

		{name: history_menu
		only_buffer_difference: true
		marker: "? "
		type: {layout: list, page_size: 100}
		style: {
			  text: green
			  selected_text: green_reverse
			  description_text: yellow
		}}

		{name: help_menu
			only_buffer_difference: true
			marker: "? "
			type: {
				layout: description
				columns: 4
				col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
				col_padding: 2
				selection_rows: 4
				description_rows: 10
			}
			style: {
				text: green
				selected_text: green_reverse
				description_text: yellow
				}
			}

		# Example of extra menus created using a nushell source
		# Use the source field to create a list of records that populates
		# the menu
		{name: commands_menu
			only_buffer_difference: false
			marker: "# "
			type: {
				layout: columnar
				columns: 4
				col_width: 20
				col_padding: 2
			}
			style: {
				text: green
				selected_text: green_reverse
				description_text: yellow
			}
			source: { |buffer, position|
				$nu.scope.commands
				| where name =~ $buffer
				| each {|it| {value: $it.name description: $it.usage}}
			}
		}
	 ]
    
    # to view available keybindings: `keybindings list`
	keybindings: [
		{name: completion_menu
			modifier: none
			keycode: tab
			mode: [emacs vi_normal vi_insert]
			event: {
				until: [
					{send: menu name: completion_menu}
					{send: menunext}
				 ]
		}}

		{name: completion_previous
			modifier: shift
			keycode: backtab
			mode: [emacs vi_normal vi_insert] # Note: You can add the same keybinding to all modes by using a list
			event: {send: menuprevious}
		}

		{name: history_menu
			modifier: alt
			keycode: char_r
			mode: [emacs vi_normal vi_insert] 
			event: {send: menu name: history_menu}
		}

		{name: next_page
			modifier: control
			keycode: char_u
			mode: [emacs vi_normal vi_insert] 
			event: {send: menupagenext}
		}

		{name: previous_page
			modifier: control
			keycode: char_d
			mode: [emacs vi_normal vi_insert] 
			event: {send: menupageprevious}
		}

		{name: commands_with_description
			modifier: alt
			keycode: Enter
			mode: [emacs, vi_normal, vi_insert]
			event: {send: menu name: commands_menu}
		}

		{name: fzf_insert_file
			modifier: alt
			keycode: char_f
			mode: [emacs, vi_normal, vi_insert]
			event: [
				{edit: InsertString, value: "ls **/* | where type == file | find -v 'Music' 'Pictures' 'Videos' 'Documents' 'Books' | get name | to text | fzf"}
				{send: Enter}
			 ]
		}

		{name: change_dir_with_fzf
			modifier: alt
			keycode: char_g
			mode: [emacs, vi_normal, vi_insert] 
			event: {send: executehostcommand, cmd: "cd (ls **/* | where type == dir | find -v 'Music' 'Pictures' 'Videos' 'Documents' 'Books' | get name | to text | fzf )"}
		}

		{name: listcontents
			modifier: alt
			keycode: char_l
			mode: [emacs, vi_normal, vi_insert] 
			event: {send: executehostcommand, cmd: "ls -d"}
		}

		{name: quick_help
			modifier: alt
			keycode: char_h
			mode: [emacs, vi_normal, vi_insert] 
			event: [
				{edit: MoveToLineEnd}
				{edit: InsertString, value: " -h | bat"}
				{send: Enter}
			 ]
		}

		{name: view_manpage
			modifier: alt_shift
			keycode: char_h
			mode: [emacs, vi_normal, vi_insert] 
			event: [
				{edit: MoveToLineStart}
				{edit: InsertString, value: "man "}
				{send: Enter}
			 ]
		}

		{name: prevdir
			modifier: alt
			keycode: char_p
			mode: [emacs, vi_normal, vi_insert] 
			event: {send: executehostcommand, cmd: "cd .."}
		}

		{name: filexplorer
			modifier: alt
			keycode: char_x
			mode: [emacs, vi_normal, vi_insert] 
			event: {send: executehostcommand, cmd: "emacs -c -nw --eval '(dired-jump)'"} # or use lf
		}

		{name: open_editor
			modifier: alt
			keycode: char_e
			mode: [emacs vi_normal vi_insert] 
			event: {send: OpenEditor}
		}

        # use this when prototyping a script on the command line
		{name: prev_cmd_in_editor
			modifier: alt_shift
			keycode: char_e
			mode: [emacs vi_normal vi_insert] 
			event: [ 
                {send: Up}
                {send: OpenEditor}
            ]
		}
	 ]
}

def solarized [] { return {
    separator: "#93a1a1"
    leading_trailing_space_bg: {attr: "n"}
    header: {fg: "#859900" attr: "b"}
    empty: "#268bd2"
    bool: {|| if $in {"#2aa198" } else {"light_gray"}}
    int: "#93a1a1"
    filesize: {|e|
      if $e == 0b {
        "#93a1a1"
      } else if $e < 1mb {
        "#2aa198"
      } else {{fg: "#268bd2"}}
    }
    duration: "#93a1a1"
    date: {|| (date now) - $in |
      if $in < 1hr {
        {fg: "#dc322f" attr: "b"}
      } else if $in < 6hr {
        "#dc322f"
      } else if $in < 1day {
        "#b58900"
      } else if $in < 3day {
        "#859900"
      } else if $in < 1wk {
        {fg: "#859900" attr: "b"}
      } else if $in < 6wk {
        "#2aa198"
      } else if $in < 52wk {
        "#268bd2"
      } else {"dark_gray"}
    }
    range: "#93a1a1"
    float: "#93a1a1"
    string: "#93a1a1"
    nothing: "#93a1a1"
    binary: "#93a1a1"
    cellpath: "#93a1a1"
    row_index: {fg: "#859900" attr: "b"}
    record: "#93a1a1"
    list: "#93a1a1"
    block: "#93a1a1"
    hints: "dark_gray"

    shape_and: {fg: "#6c71c4" attr: "b"}
    shape_binary: {fg: "#6c71c4" attr: "b"}
    shape_block: {fg: "#268bd2" attr: "b"}
    shape_bool: "#2aa198"
    shape_custom: "#859900"
    shape_datetime: {fg: "#2aa198" attr: "b"}
    shape_directory: "#2aa198"
    shape_external: "#2aa198"
    shape_externalarg: {fg: "#859900" attr: "b"}
    shape_filepath: "#2aa198"
    shape_flag: {fg: "#268bd2" attr: "b"}
    shape_float: {fg: "#6c71c4" attr: "b"}
    shape_garbage: {fg: "#FFFFFF" bg: "#FF0000" attr: "b"}
    shape_globpattern: {fg: "#2aa198" attr: "b"}
    shape_int: {fg: "#6c71c4" attr: "b"}
    shape_internalcall: {fg: "#2aa198" attr: "b"}
    shape_list: {fg: "#2aa198" attr: "b"}
    shape_literal: "#268bd2"
    shape_match_pattern: "#859900"
    shape_matching_brackets: {attr: "u"}
    shape_nothing: "#2aa198"
    shape_operator: "#b58900"
    shape_or: {fg: "#6c71c4" attr: "b"}
    shape_pipe: {fg: "#6c71c4" attr: "b"}
    shape_range: {fg: "#b58900" attr: "b"}
    shape_record: {fg: "#2aa198" attr: "b"}
    shape_redirection: {fg: "#6c71c4" attr: "b"}
    shape_signature: {fg: "#859900" attr: "b"}
    shape_string: "#859900"
    shape_string_interpolation: {fg: "#2aa198" attr: "b"}
    shape_table: {fg: "#268bd2" attr: "b"}
    shape_variable: "#6c71c4"

    background: "#002b36"
    foreground: "#93a1a1"
    cursor: "#93a1a1"
}}

# External completer example
# let carapace_completer = {|spans|
#	 carapace $spans.0 nushell $spans | from json
# }
