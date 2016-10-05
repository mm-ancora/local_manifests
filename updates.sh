#!/bin/bash

if [ ! -d ".repo" ]; then
    echo -e "No .repo directory found.  Is this an Android build tree?"
    exit 1
fi

android="${PWD}"

# Add local cherries if they exist
if [ -f ${android}/updates-local.sh ]; then
    source ${android}/updates-local.sh
fi

# MemoryHeapBase: ifdef for gingerbread/froyo compatibility
cherries+=(CM_58227)

# Correctly provide the technology to setup data connection
cherries+=(CM_81082)

# linker: restore prelink support
cherries+=(CM_78604)

# Revert "Revert "Reenable support for non-PIE executables""
cherries+=(CM_117733)


if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/vendor/extra/repopick.py -b ${cherries[@]}
fi
