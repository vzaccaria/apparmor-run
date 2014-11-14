
{docopt} = require('docopt')
require! 'path'
require! 'fs'
require! 'shelljs'
_ = require 'underscore'

doc = """
Usage:
        apparmor-run gen-profiles [-d | --dry] [-n N] -l LANGUAGE -t DIRECTORY [ -y TYPE ]
        apparmor-run del-profiles -t DIRECTORY
        apparmor-run -h | --help 

Options:
        -n, --number N                  Number of profiles to generate (defaults to 1)
        -l, --language LANGUAGE         Use a specific language profile (currently `C` or `Matlab`)
        -t, --target DIRECTORY          Generate profiles for DIRECTORY/LANGUAGE/ID/main
        -y, --type TYPE                 Use a specific version of the profile (default `main`)
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
type            = get-option('-y', '--type', 'main', o)

nprofiles = [1 to number]

ardir = "/etc/apparmor.d"

for i in nprofiles
    dir = "#directory/#i"
    dir = path.resolve(dir)
    components = dir.split('/')
    components = _.filter(components, (-> it != ''))
    programname = '/' + ((components ++ ['main']) * '/')
    profilename = (components ++ ['main']) * '.'
    if o['gen-profiles']
        if dry
            console.log "Writing to #ardir/#profilename"
        else
            plugin = require("./lang/#language")[type]
            plugin(programname).to("#ardir/#profilename")
    if o['del-profiles']
        if dry
            console.log "Removing #ardir/#profilename"
        else
            shelljs.rm('-f', "/#ardir/#profilename")


