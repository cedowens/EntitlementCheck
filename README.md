# EntitlementCheck
Wrapper around the codesign binary to recursively check installed apps for problematic entitlements. Currently it checks for:

- com.apple.security.cs.disable-library-validation
- com.apple.security.cs-allow-dyld-environment-variables
- comapple.security.get-task-allow
- com.apple.security.cs.allow-unsigned-executable-memory
- com.apple.security.files.downlaods.read-only
- com.apple.security.files.downloads.read-write 
- com.apple.security.files.all (deprecated...but you never know...)
- com.apple.security.files.user-selected.read-only 
- com.apple.security.files.user-selected.read-write 

The following directories are checked:
- /Applications
- /usr/local/bin 
- /usr/bin 
- /usr/sbin

**Steps:**

1. remove the quarantine attribute from all files in the dir (ex: xattr -c [file])
2. `chmod +x AppChecker.sh`
3. `./AppChecker.sh `

The script will create subdirectories for each of the entitlements checked above under the /tmp folder:

/tmp/appcheck/dyld-env-variables
/tmp/appcheck/disable-library-validation
/tmp/appcheck/get-task-allow
/tmp/appcheck/allow-unsigned-executable-memory
/tmp/appcheck/files-downloads
/tmp/appcheck/files-all
/tmp/appcheck/files-user-selected

Any files that contain any of the entitlements above will have its entitlement output written to the appropriate /tmp/ subidrectory above and the filename will contain the path to the source file that has the entitlements. (ex: a binary in /usr/local/bin with the `com.apple.security.cs-allow-dyld-environment-variables` will be written to `/tmp/appcheck/dyld-env-variables/usr:local:bin:[filename]-entitlements.txt`). You can then open that file and look at the entitlements. 

Lastly, the script will then take each file that had the `com.apple.security.cs-allow-dyld-environment-variables entitlement` check and attempt a DYLIB injection using the included inj.dylib file. A list of these files will be in `/tmp/appcheck-results.txt`.
