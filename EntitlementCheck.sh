#!/bin/bash

sysinfo=$(uname -a)

if [[ $sysinfo == *"x86_64" ]];then
	ARCH=x86_64
elif [[ $sysinfo == *"arm64e" ]];then
        ARCH=arm64e
elif [[ $sysinfo == *"arm64_32" ]];then
	ARCH=arm64_32
elif [[ $sysinfo == *"arm64" ]];then
	ARCH=arm64
else
	echo "Architecture match not found. Exiting"
	exit 0
fi

mkdir -p "/tmp/appcheck/dyld-env-variables"
mkdir -p "/tmp/appcheck/disable-library-validation"
mkdir -p "/tmp/appcheck/get-task-allow"
mkdir -p "/tmp/appcheck/allow-unsigned-executable-memory"
mkdir -p "/tmp/appcheck/files-downloads"
mkdir -p "/tmp/appcheck/files-all"
mkdir -p "/tmp/appcheck/files-user-selected"

for p in $(ls /Applications)
	do
		if [[ $p == *".app" ]];then
		for x in $(ls /Applications/$p/Contents/MacOS)
			do
			rslt=$(codesign -d --entitlements - /Applications/$p/Contents/MacOS/$x)
			if [[ $rslt == *"dyld-environment-variables"* ]];then
				echo $rslt > /tmp/appcheck/dyld-env-variables/Applications:$p:Contents:MacOS:$x-entitlements.txt
			fi

			if [[ $rslt == *"disable-library-validation"* ]];then
				echo $rslt > /tmp/appcheck/disable-library-validation/Applications:$p:Contents:MacOS:$x-entitlements.txt
			fi
			
			if [[ $rslt == *"get-task-allow"* ]];then
				echo $rslt > /tmp/appcheck/get-task-allow/Applications:$p:Contents:MacOS:$x-entitlements.txt
			fi
			
			if [[ $rslt == *"allow-unsigned-executable-memory"* ]];then
				echo $rslt > /tmp/appcheck/allow-unsigned-executable-memory/Applications:$p:Contents:MacOS:$x-entitlements.txt
			fi
				
			if [[ $rslt == *"security.files.downloads"* ]];then
				echo $rslt > /tmp/appcheck/files-downloads/Applications:$p:Contents:MacOS:$x-entitlements.txt
			fi
			
			if [[ $rslt == *"security.files.all"* ]];then
				echo $rslt > /tmp/appcheck/files-all/Applications:$p:Contents:MacOS:$x-entitlements.txt
			fi

			if [[ $rslt == *"security.files.user-selected"* ]];then
				echo $rslt > /tmp/appcheck/files-user-selected/Applications:$p:Contents:MacOS:$x-entitlements.txt
			fi
			done
		fi
	done

for c in $(ls /usr/bin)
	do
		if [[ -f /usr/bin/$c ]];then
			rslt2=$(codesign -d --entitlements - /usr/bin/$c)
			
			if [[ $rslt2 == *"dyld-environment-variables"* ]];then
                                echo $rslt2 > /tmp/appcheck/dyld-env-variables/usr:bin:$c-entitlements.txt
            fi

            if [[ $rslt2 == *"disable-library-validation"* ]];then
                                echo $rslt2 > /tmp/appcheck/disable-library-validation/usr:bin:$c-entitlements.txt
            fi
                        
            if [[ $rslt2 == *"get-task-allow"* ]];then
                                echo $rslt2 > /tmp/appcheck/get-task-allow/usr:bin:$c-entitlements.txt
            fi
 
            if [[ $rslt2 == *"allow-unsigned-executable-memory"* ]];then
                                echo $rslt2 > /tmp/appcheck/allow-unsigned-executable-memory/usr:bin:$c-entitlements.txt
            fi

            if [[ $rslt2 == *"security.files.downloads"* ]];then
                                echo $rslt2 > /tmp/appcheck/files-downloads/usr:bin:$c-entitlements.txt
            fi
  
            if [[ $rslt2 == *"security.files.all"* ]];then
                                echo $rslt2 > /tmp/appcheck/files-all/usr:bin:$c-entitlements.txt
            fi
       
            if [[ $rslt2 == *"security.files.user-selected"* ]];then
                                echo $rslt2 > /tmp/appcheck/files-user-selected/usr:bin:$c-entitlements.txt
            fi

		fi
	done


for b in $(ls /usr/sbin)
        do
                if [[ -f /usr/sbin/$b ]];then
                        rslt3=$(codesign -d --entitlements - /usr/sbin/$b)

			if [[ $rslt3 == *"dyld-environment-variables"* ]];then
                                echo $rslt3 > /tmp/appcheck/dyld-env-variables/usr:sbin:$b-entitlements.txt
            fi

            if [[ $rslt3 == *"disable-library-validation"* ]];then
                                echo $rslt3 > /tmp/appcheck/disable-library-validation/usr:sbin:$b-entitlements.txt
            fi
                      
            if [[ $rslt3 == *"get-task-allow"* ]];then
                                echo $rslt3 > /tmp/appcheck/get-task-allow/usr:sbin:$b-entitlements.txt
            fi

            if [[ $rslt3 == *"allow-unsigned-executable-memory"* ]];then
                                echo $rslt3 > /tmp/appcheck/allow-unsigned-executable-memory/usr:sbin:$b-entitlements.txt
            fi
                      
            if [[ $rslt3 == *"security.files.downloads"* ]];then
                                echo $rslt3 > /tmp/appcheck/files-downloads/usr:sbin:$b-entitlements.txt
            fi
                      
            if [[ $rslt3 == *"security.files.all"* ]];then
                                echo $rslt3 > /tmp/appcheck/files-all/usr:sbin:$b-entitlements.txt
            fi
              
            if [[ $rslt3 == *"security.files.user-selected"* ]];then
                                echo $rslt3 > /tmp/appcheck/files-user-selected/usr:sbin:$b-entitlements.txt
            fi
               

        fi
        done

for a in $(ls /usr/local/bin)
        do
                if [[ -f /usr/local/bin/$a ]];then
                        rslt4=$(codesign -d --entitlements - /usr/local/bin/$a)

			if [[ $rslt4 == *"dyld-environment-variables"* ]];then
                                echo $rslt4 > /tmp/appcheck/dyld-env-variables/usr:local:bin:$a-entitlements.txt
            fi

            if [[ $rslt4 == *"disable-library-validation"* ]];then
                                echo $rslt4 > /tmp/appcheck/disable-library-validation/usr:local:bin:$a-entitlements.txt
            fi
                      
            if [[ $rslt4 == *"get-task-allow"* ]];then
                                echo $rslt4 > /tmp/appcheck/get-task-allow/usr:local:bin:$a-entitlements.txt
            fi
                       
            if [[ $rslt4 == *"allow-unsigned-executable-memory"* ]];then
                                echo $rslt4 > /tmp/appcheck/allow-unsigned-executable-memory/usr:local:bin:$a-entitlements.txt
            fi
               
            if [[ $rslt4 == *"security.files.downloads"* ]];then
                                echo $rslt4 > /tmp/appcheck/files-downloads/usr:local:bin:$a-entitlements.txt
            fi
               
            if [[ $rslt4 == *"security.files.all"* ]];then
                                echo $rslt4 > /tmp/appcheck/files-all/usr:local:bin:$a-entitlements.txt
            fi
               
            if [[ $rslt4 == *"security.files.user-selected"* ]];then
                                echo $rslt4 > /tmp/appcheck/files-user-selected/usr:local:bin:$a-entitlements.txt
            fi
               
        fi
        done

echo "[+] DONE! Check /tmp/appcheck subdirectories for results"

