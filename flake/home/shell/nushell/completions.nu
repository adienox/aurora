def "nu-complete fabric-patterns" [] {
     ls ~/.config/fabric/patterns
     | get name | path parse | get stem
}

extern fabric [
    -p: string@"nu-complete fabric-patterns" # choose a pattern
    -s # stream the output
]
