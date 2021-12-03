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

echo "====================POTENTIALLY PROBLEMATIC ENTITLEMENTS IN /APPLICATIONS/====================" >> results.txt
for p in $(ls /Applications)
	do
		if [[ $p == *".app" ]];then
		for x in $(ls /Applications/$p/Contents/MacOS)
			do
			rslt=$(codesign -d --entitlements - /Applications/$p/Contents/MacOS/$x)
			if [[ $rslt == *"dyld-environment-variables"* ]];then
				echo "[-] /Applications/$p/Contents/MacOS/$x\: POTENTIALLY INJECTABLE APP (has com.apple.security.cs-allow-dyld-environment-variables entitlement)" >> results.txt
			fi

			if [[ $rslt == *"disable-library-validation"* ]];then
				echo "[-] /Applications/$p/Contents/MacOS/$x: APP CAN LOAD ARBITRARY UNSIGNED PLUGINS/FRAMEWORKS (has com.apple.security.cs.disable-library-validation entitlement)" >> results.txt
			fi
			
			if [[ $rslt == *"get-task-allow"* ]];then
				echo "[-] /Applications/$p/Contents/MacOS/$x: APP ALLOWS OTHER NON-SANDBOXED PROCESSES TO ATTACH (has com.apple.security.get-task-allow entitlement)" >> results.txt
			fi
			
			if [[ $rslt == *"allow-unsigned-executable-memory"* ]];then
				echo "[-] /Applications/$p/Contents/MacOS/$x: APP ALLOWS C CODE PATCHING, NSCREATEOBJECTFILEIMAGEFROMMEMORY, OR DVDPLAYBACK FRAMEWORK (has com.apple.security.cs.allow-unsigned-executable-memory entitlement)" >> results.txt
			fi
				
			if [[ $rslt == *"security.files.downloads"* ]];then
				echo "[-] /Applications/$p/Contents/MacOS/$x: APP MAY HAVE ACCESS TO DOWNLOADS FOLDER (has either the com.apple.security.files.downloads.read-only or com.apple.security.files.downloads-read-write entitlement)" >> results.txt
			fi
			
			if [[ $rslt == *"security.files.all"* ]];then
				echo "[-] /Applications/$p/Contents/MacOS/$x: APP MAY HAVE ACCESS TO ALL FILES (is deprecated...but has com.apple.security.files.all entitlement)" >> results.txt
			fi

			if [[ $rslt == *"security.files.user-selected"* ]];then
				echo "[-] /Applications/$p/Contents/MacOS/$x: APP MAY HAVE ACCESS TO FILES THE USER HAS SELECTED IN AN OPEN OR SAVE DIALOG (has either com.apple.security.files.user-selected.read-only or com.apple.security.files.user-selected.read-write entitlement)" >> results.txt
			fi
			done
		fi
	done
echo "" >> results.txt
echo "" >> results.txt
echo "====================POTENTIALLY PROBLEMATIC ENTITLEMENTS IN /USR/BIN/====================" >> results.txt
for c in $(ls /usr/bin)
	do
		if [[ -f /usr/bin/$c ]];then
			rslt2=$(codesign -d --entitlements - /usr/bin/$c)
			
			if [[ $rslt2 == *"dyld-environment-variables"* ]];then
				echo "[-] /usr/bin/$c: POTENTIALLY INJECTABLE APP (has com.apple.security.cs-allow-dyld-environment-variables entitlement)" >> results.txt
            		fi

            		if [[ $rslt2 == *"disable-library-validation"* ]];then
				echo "[-] /usr/bin/$c: APP CAN LOAD ARBITRARY UNSIGNED PLUGINS/FRAMEWORKS (has com.apple.security.cs.disable-library-validation entitlement)" >> results.txt
            		fi
                        
            		if [[ $rslt2 == *"get-task-allow"* ]];then
				echo "[-] /usr/bin/$c: APP ALLOWS OTHER NON-SANDBOXED PROCESSES TO ATTACH (has com.apple.security.get-task-allow entitlement)" >> results.txt
            		fi
 
            		if [[ $rslt2 == *"allow-unsigned-executable-memory"* ]];then
				echo "[-] /usr/bin/$c: APP ALLOWS C CODE PATCHING, NSCREATEOBJECTFILEIMAGEFROMMEMORY, OR DVDPLAYBACK FRAMEWORK (has com.apple.security.cs.allow-unsigned-executable-memory entitlement)" >> results.txt
            		fi

            		if [[ $rslt2 == *"security.files.downloads"* ]];then
				echo "[-] /usr/bin/$c: APP MAY HAVE ACCESS TO DOWNLOADS FOLDER (has either the com.apple.security.files.downloads.read-only or com.apple.security.files.downloads-read-write entitlement)" >> results.txt
            		fi
  
            		if [[ $rslt2 == *"security.files.all"* ]];then
				echo "[-] /usr/bin/$c: APP MAY HAVE ACCESS TO ALL FILES (is deprecated...but has com.apple.security.files.all entitlement)" >> results.txt
            		fi
       
            		if [[ $rslt2 == *"security.files.user-selected"* ]];then
				echo "[-] /usr/bin/$c: APP MAY HAVE ACCESS TO FILES THE USER HAS SELECTED IN AN OPEN OR SAVE DIALOG (has either com.apple.security.files.user-selected.read-only or com.apple.security.files.user-selected.read-write entitlement)" >> results.txt
            		fi

		fi
	done

echo "" >> results.txt
echo "" >> results.txt
echo "====================POTENTIALLY PROBLEMATIC ENTITLEMENTS IN /USR/SBIN/====================" >> results.txt
for b in $(ls /usr/sbin)
        do
                if [[ -f /usr/sbin/$b ]];then
                        rslt3=$(codesign -d --entitlements - /usr/sbin/$b)

			if [[ $rslt3 == *"dyld-environment-variables"* ]];then
				echo "[-] /usr/sbin/$b: POTENTIALLY INJECTABLE APP (has com.apple.security.cs-allow-dyld-environment-variables entitlement)" >> results.txt
            		fi

            		if [[ $rslt3 == *"disable-library-validation"* ]];then
				echo "[-] /usr/sbin/$b: APP CAN LOAD ARBITRARY UNSIGNED PLUGINS/FRAMEWORKS (has com.apple.security.cs.disable-library-validation entitlement)" >> results.txt
            		fi
                      
            		if [[ $rslt3 == *"get-task-allow"* ]];then
				echo "[-] /usr/sbin/$b: APP ALLOWS OTHER NON-SANDBOXED PROCESSES TO ATTACH (has com.apple.security.get-task-allow entitlement)" >> results.txt
            		fi

            		if [[ $rslt3 == *"allow-unsigned-executable-memory"* ]];then
				echo "[-] /usr/sbin/$b: APP ALLOWS C CODE PATCHING, NSCREATEOBJECTFILEIMAGEFROMMEMORY, OR DVDPLAYBACK FRAMEWORK (has com.apple.security.cs.allow-unsigned-executable-memory entitlement)" >> results.txt
            		fi
                      
            		if [[ $rslt3 == *"security.files.downloads"* ]];then
				echo "[-] /usr/sbin/$b: APP MAY HAVE ACCESS TO DOWNLOADS FOLDER (has either the com.apple.security.files.downloads.read-only or com.apple.security.files.downloads-read-write entitlement)" >> results.txt
            		fi
                      
            		if [[ $rslt3 == *"security.files.all"* ]];then
				echo "[-] /usr/sbin/$b: APP MAY HAVE ACCESS TO ALL FILES (is deprecated...but has com.apple.security.files.all entitlement)" >> results.txt
            		fi
              
            		if [[ $rslt3 == *"security.files.user-selected"* ]];then
				echo "[-] /usr/sbin/$b: APP MAY HAVE ACCESS TO FILES THE USER HAS SELECTED IN AN OPEN OR SAVE DIALOG (has either com.apple.security.files.user-selected.read-only or com.apple.security.files.user-selected.read-write entitlement)" >> results.txt
            		fi
               

        fi
        done
echo "" >> results.txt
echo "" >> results.txt
echo "====================POTENTIALLY PROBLEMATIC ENTITLEMENTS IN /USR/LOCAL/BIN/====================" >> results.txt
for a in $(ls /usr/local/bin)
        do
                if [[ -f /usr/local/bin/$a ]];then
                        rslt4=$(codesign -d --entitlements - /usr/local/bin/$a)

			if [[ $rslt4 == *"dyld-environment-variables"* ]];then
				echo "[-] /usr/local/bin/$a: POTENTIALLY INJECTABLE APP (has com.apple.security.cs-allow-dyld-environment-variables entitlement)" >> results.txt
            		fi

            		if [[ $rslt4 == *"disable-library-validation"* ]];then
				echo "[-] /usr/local/bin/$a: APP CAN LOAD ARBITRARY UNSIGNED PLUGINS/FRAMEWORKS (has com.apple.security.cs.disable-library-validation entitlement)" >> results.txt
            		fi
                      
            		if [[ $rslt4 == *"get-task-allow"* ]];then
				echo "[-] /usr/local/bin/$a: APP ALLOWS OTHER NON-SANDBOXED PROCESSES TO ATTACH (has com.apple.security.get-task-allow entitlement)" >> results.txt
            		fi
                       
            		if [[ $rslt4 == *"allow-unsigned-executable-memory"* ]];then
				echo "[-] /usr/local/bin/$a: APP ALLOWS C CODE PATCHING, NSCREATEOBJECTFILEIMAGEFROMMEMORY, OR DVDPLAYBACK FRAMEWORK (has com.apple.security.cs.allow-unsigned-executable-memory entitlement)" >> results.txt
            		fi
               
            		if [[ $rslt4 == *"security.files.downloads"* ]];then
				echo "[-] /usr/local/bin/$a: APP MAY HAVE ACCESS TO DOWNLOADS FOLDER (has either the com.apple.security.files.downloads.read-only or com.apple.security.files.downloads-read-write entitlement)" >> results.txt
            		fi
               
            		if [[ $rslt4 == *"security.files.all"* ]];then
				echo "[-] /usr/local/bin/$a: APP MAY HAVE ACCESS TO ALL FILES (is deprecated...but has com.apple.security.files.all entitlement)" >> results.txt
            		fi
               
            		if [[ $rslt4 == *"security.files.user-selected"* ]];then
				echo "[-] /usr/local/bin/$a: APP MAY HAVE ACCESS TO FILES THE USER HAS SELECTED IN AN OPEN OR SAVE DIALOG (has either com.apple.security.files.user-selected.read-only or com.apple.security.files.user-selected.read-write entitlement)" >> results.txt
            		fi
               
        	fi
        done

echo "[+] DONE! Check results.txt for findings"

