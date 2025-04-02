# Plugin Manager
evaluate-commands %sh{
    plugins="$HOME/.config/kak/plugins"
    mkdir -p "$plugins"
    [ -d "$plugins/plug.kak" ] || git clone https://github.com/robertmeta/plug.kak.git "$plugins/plug.kak"
}
source "%val{config}/plugins/plug.kak/rc/plug.kak"

# Appearance
plug "kakoune-editor/kakoune-vscode-theme" %{
    colorscheme vscode-dark
}
plug "TeddyDD/kakoune-filetree" %{
    map global normal <c-t> ': filetree-toggle<ret>'
}
plug "andreyorst/powerline.kak" %{
    powerline-start
}
plug "delapouite/kakoune-buffers" %{
    map global normal <c-b> ': enter-buffers-mode<ret>'
}
set-option global modelinefmt '%val{bufname} %val{cursor_line}:%val{cursor_char_column} {{context_info}} {{mode_info}} - %val{client}@%val{session}'

# Keybindings
map global normal <c-s> ': w<ret>'
map global normal <c-z> 'u'
map global normal <c-y> '<a-u>'
map global normal <c-c> '<a-|>xclip -i -selection clipboard<ret>'
map global insert <c-c> '<a-|>xclip -i -selection clipboard<ret>'
map global normal <c-p> '<a-!>xclip -o -selection clipboard<ret>'
plug "andreyorst/fzf.kak" %{
    map global normal <c-p> ': fzf-mode<ret>'
}
map global normal <c-backtick> ': connect terminal<ret>'
plug "alexherbo/kakoune-lsp" %{
    map global normal <f12> ': lsp-definition<ret>'
    map global normal ',d' ': lsp-definition<ret>'
    lsp-enable
}
plug "alexherbo/auto-pairs.kak" %{
    map global normal <c-slash> ': comment-line<ret>'
}

# Additional Settings
set-option global tabstop 4
set-option global indentwidth 4
set-option global scrolloff 3,3
