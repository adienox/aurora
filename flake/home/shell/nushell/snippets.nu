# These come mostly from the internet

# Basic concept by @kspatlas on discord
# https://discord.com/channels/601130461678272522/615253963645911060/1272315085708328960
def xkcd [number = ""] {
  let xkcd = (http get $"https://xkcd.com/($number)/info.0.json" | reject news link)
  let display = {
      date: $"($xkcd.day)-($xkcd.month)-($xkcd.year)"
      title: $xkcd.title
      ...($xkcd | reject day month year safe_title title)
  }
  print $display
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

# By @maxim on discord
# https://discord.com/channels/601130461678272522/615253963645911060/1242478946587508797
use std iter scan

def format-nu [
] {
    let $input = default (
        history | last 2 | first | get command
    )

    let pipe = char --integer 2000

    let closures = $input | str replace --all ' | ' $pipe

    let chars = $closures
        | split chars --grapheme-clusters

    $chars
    | each {|i|
        {'(': 1 '{': 1 ')': -1 '}': -1}
        | get -i $i
        | default 0
    }
    | scan 0 {|i acc| [($acc + $i) 0] | math max } --noinit
    | wrap level
    | merge ($chars | wrap chars)
    | update chars {|i|
        if $i.chars == $pipe {
            seq 1 $i.level | each {'    '} | str join | $"\n($in)| "
        } else {
            $i.chars
        }
    }
    | get chars
    | str join
    | commandline edit -r $in
}

# https://github.com/nushell/nu_scripts/blob/main/modules/data_extraction/ultimate_extractor.nu
# Function to extract archives with different extensions.
def extract [name:string] {
    let handlers = [ [extension command];
                   ['tar\.bz2|tbz|tbz2' 'tar xvjf']
                   ['tar\.gz|tgz'       'tar xvzf']
                   ['tar\.xz|txz'       'tar xvf']
                   ['tar\.Z'            'tar xvZf']
                   ['bz2'               'bunzip2']
                   ['deb'               'ar x']
                   ['gz'                'gunzip']
                   ['pkg'               'pkgutil --expand']
                   ['rar'               'unrar x']
                   ['tar'               'tar xvf']
                   ['xz'                'xz --decompress']
                   ['zip|war|jar|nupkg' 'unzip']
                   ['Z'                 'uncompress']
                   ['7z'                '7za x']
                 ]
    let maybe_handler = ($handlers | where $name =~ $'\.(($it.extension))$')
    if ($maybe_handler | is-empty) {
        error make { msg: "unsupported file extension" }
    } else {
        let handler = ($maybe_handler | first)
        nu -c ($handler.command + ' ' + $name)
  }
}

def package-locate [package:string] {
    try {
        print $"Trying to locate package: ($package)"
        let options = (
            nix-locate --no-group --type x --type s --top-level --whole-name --minimal $"bin/($package)"
            | parse -r "^(.*?)(?=.out$)"
            | get capture0
            | to text
        )
        if ($options | is-empty) {
            print $"($package) not found"
            return null
        }
        let option = ($options | gum choose --header="Choose to Run:")
        print $"Creating a nix shell out of package ($option)"
        nix-shell --command nu -p $option
    }
}
