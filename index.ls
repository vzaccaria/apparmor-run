
{docopt} = require('docopt')
require! 'fs'

doc = """
Usage:
        apparmor-run gen-profiles [-d | --dry] [-n N] -l LANGUAGE -t DIRECTORY 
        apparmor-run -h | --help 

Options:
        -n, --number N                  Number of profiles to generate (defaults to 1)
        -l, --language LANGUAGE         Use a specific language profile (currently `C` or `Matlab`)
        -t, --target DIRECTORY          Generate profiles for DIRECTORY/LANGUAGE/ID/main
"""

get-option = (a, b, def, o) ->
    if not o[a] and not o[b]
        return def
    else
        return o[b]

o = docopt(doc)


number          = get-option('-n' , '--number'     , 1 , o)
dry             = o['-d'] or o['--dry']
language        = get-option('-l' , '--language'   , null , o)
directory       = get-option('-t' , '--target'     , null , o)

console.log o



