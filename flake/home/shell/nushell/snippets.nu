# These come mostly from the internet

# By @kspatlas on discord
# https://discord.com/channels/601130461678272522/615253963645911060/1272315085708328960
def xkcd [number = ""] {
  let xkcd = (http get $"https://xkcd.com/($number)/info.0.json")
  print $xkcd
  http get $xkcd.img | kitty icat --align left
}

# By @firegem on discord
# https://discord.com/channels/601130461678272522/615253963645911060/1272633616647585903
def usage [ cmd: string --no-ansi(-A) --update(-u) ] {
    if $update {
        ^tldr -u --raw $cmd
    } else {
        ^tldr --raw $cmd
    } | lines | compact -e
    | skip until { str starts-with '- ' }
    | chunks 2 | each { str join ' ' }
    | parse '- {desc}: `{example}`'
    | update example {
        str replace -ra '{{(.+?)}}' $'(ansi u)$1(ansi reset)' # Underline shown for user input
        | str replace -r '^(\w\S*)' $'(ansi bo)$1(ansi reset)' # Make first word (usually command) bold
        | str replace -ar ' (-{1,2}\S+)' $' (ansi d)$1(ansi reset)' # Make cli flags dim
    } | if $no_ansi { update example { ansi strip } } else {}
    | move desc --after example
    | collect
}
