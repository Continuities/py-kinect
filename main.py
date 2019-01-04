#!/usr/bin/env python

import freenect

# This just prints a depth snapshot to prove that it works
print(freenect.sync_get_depth())

# TODO: Write the app