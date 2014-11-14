
_module = ->

    main-profile = (filename) ->
        """
        # Last Modified: Thu Nov 13 09:08:43 2014
        
        \#include <tunables/global>
        
        #filename {
            \#include <abstractions/base>
            #filename mr,
            }
        """

    return {
        main: main-profile
        }

module.exports = _module()
