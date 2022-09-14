# Entitlement AND Hardened Runtime Check
Wrapper around the codesign binary to recursively check installed apps for problematic entitlements and for whether or not Hardened Runtime is enabled. 

The following entitlements are checked currently:

- com.apple.security.cs.disable-library-validation
- com.apple.security.cs-allow-dyld-environment-variables
- com.apple.security.get-task-allow
- com.apple.security.cs.allow-unsigned-executable-memory
- com.apple.security.files.downlaods.read-only
- com.apple.security.files.downloads.read-write 
- com.apple.security.files.all (deprecated...but you never know...)
- com.apple.security.files.user-selected.read-only 
- com.apple.security.files.user-selected.read-write
- com.apple.private.security.clear-library-validation 
- com.apple.private.tcc.allow

**NOTE: It is possible that an app can have one or more of the entitlements above while also having hardened runtime enabled (which may mitigate the attack path for abusing the entitlement in question). To check specifically for hardened runtime, run the command below and search for flags in the output:**



For Hardened Runtime checks, my script runs the command below and filters based on output:

`codesign --display --verbose /Applications/[name]/Contents/MacOS/[name]`


The following directories are checked by both the Entitlements and Hardened Runtime Check Scripts:
- /Applications
- /System/Applications/Utilities
- /usr/local/bin 
- /usr/bin 
- /usr/sbin

## Steps - To Run The Swift Versions:

**Instructions:**
1. `EntitlementCheck.swift`: Wrapper around the codesign binary to search for apps/bins with potentially problematic entitlements. Swift version of my original python script at https://github.com/cedowens/EntitlementCheck. Steps:

> swiftc -o EntitlementCheck EntitlementCheck.swift
> 
> ./EntitlementCheck

2. `HardenedRuntimeCheck.swift`: Wrapper around the codesign binary to search for apps/bins without hardened runtime enabled. Swift version of my original python script at https://github.com/cedowens/EntitlementCheck. Steps:

> swiftc -o HardenedRuntimeCheck HardenedRuntimeCheck.swift
> 
> ./HardenedRuntimeCheck

## Steps - To Run The Python Versions:

**Instructions:**
1. Entitlements Check: `chmod +x Entitlements_Check.py && ./Entitlements_Check.py ` OR `python3 Entitlements_Check.py `
2. Hardened Runtime Check: `chmod +x Hardened_Runtime_Check.py && ./Hardened_Runtime_Check.py ` OR `python3 Hardened_Runtime_Check.py `
3. results will be displayed to stdout. Can simply redirect to an output file as well (ex: `python3 Hardened_Runtime_Check.py > outfile.txt`)

**you can use my Dylib Injection binary at https://github.com/cedowens/Inject_Dylib to validate/test potentially injectable apps found by these scripts**

## Sample Output
Sample output from Entitlements_Check.py:
![Image](pic2.png)

Sample output from Hardened_Runtime_Check.py:
![Image](pic3.png)
