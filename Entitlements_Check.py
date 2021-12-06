import sys
import os
import subprocess

d = os.listdir("/Applications/")
print("=======================================/Applications Directory Check============================================")
for each in d:
	if each.endswith('.app'):
		apath = "/Applications/%s/Contents/MacOS" % each
		try:
			p = os.listdir(apath)
			for item in p:
				apath2 = apath + "/" + item
				x = subprocess.getstatusoutput('codesign -d --entitlements :- %s' % apath2)
				if 'dyld-environment-variables' in x[1]:
					print("\033[33m[-] POTENTIALLY INJECTABLE APP (has com.apple.security.cs-allow-dyld-environment-variables entitlement): %s\033[0m" % apath2)
				if 'disable-library-validation' in x[1]:
					print("\033[33m[-] Binary can load artibrary unsigned plugins/frameworks (has com.apple.security.cs.disable-library-validation entitlement): %s\033[0m" % apath2)
				if 'get-task-allow' in x[1]:
					print("\033[33m[-] Binary allows otehr non sandboxed processes to attach (has com.apple.security.get-task-allow entitlement): %s\033[0m" % apath2)
				if 'allow-unsigned-executable-memory' in x[1]:
					print("\033[33m[-] Binary allows c code patching, NSCreateObjectFileImageFromMemory, or dvdplayback framework (has com.apple.security.cs.allow-unsigned-executable-memory entitlement): %s\033[0m" % apath2)
				if 'security.files.downloads' in x[1]:
					print("\033[33m[-] Binary may  have access to the Downloads folder (has com.apple.security.files.downloads.read-only or com.apple.security.files.downloads.read-write entitlement): %s\033[0m" % apath2)
				if 'security.files.all' in x[1]:
					print("\033[33m[-] Binary may have access to all files (has deprecated com.apple.security.files.all entitlement): %s\033[0m" % apath2)
				if 'security.files.user-selected' in x[1]:
					print("\033[33m[-] Binary may have access to files the user has selected in an open or save dialog (has com.apple.security.files.user-selected.read-only or com.apple.security.files.user-selected.read-write entitlement): %s\033[0m" % apath2)
		except:
			pass



print("=======================================/usr/local/bin Directory Check============================================")
c = os.listdir("/usr/local/bin")

for binary in c:
	bpath = "/usr/local/bin/" + binary
	try:
		y = subprocess.getstatusoutput('codesign -d --entitlements :- %s' % bpath)
		if 'dyld-environment-variables' in y[1]:
			print("\033[91m[-] POTENTIALLY INJECTABLE APP (has com.apple.security.cs-allow-dyld-environment-variables entitlement): %s\033[0m" % bpath)
		if 'disable-library-validation' in y[1]:
			print("\033[33m[-] Binary can load artibrary unsigned plugins/frameworks (has com.apple.security.cs.disable-library-validation entitlement): %s\033[0m" % bpath)
		if 'get-task-allow' in y[1]:
			print("\033[33m[-] Binary allows otehr non sandboxed processes to attach (has com.apple.security.get-task-allow entitlement): %s\033[0m" % bpath)
		if 'allow-unsigned-executable-memory' in y[1]:
			print("\033[33m[-] Binary allows c code patching, NSCreateObjectFileImageFromMemory, or dvdplayback framework (has com.apple.security.cs.allow-unsigned-executable-memory entitlement): %s\033[0m" % bpath)
		if 'security.files.downloads' in y[1]:
			print("\033[33m[-] Binary may  have access to the Downloads folder (has com.apple.security.files.downloads.read-only or com.apple.security.files.downloads.read-write entitlement): %s\033[0m" % bpath)
		if 'security.files.all' in y[1]:
			print("\033[33m[-] Binary may have access to all files (has deprecated com.apple.security.files.all entitlement): %s\033[0m" % bpath)
		if 'security.files.user-selected' in y[1]:
			print("\033[33m[-] Binary may have access to files the user has selected in an open or save dialog (has com.apple.security.files.user-selected.read-only or com.apple.security.files.user-selected.read-write entitlement): %s\033[0m" % bpath)
	except:
		pass



print("=======================================/usr/sbin Directory Check============================================")
b = os.listdir("/usr/sbin")

for bin in b:
	spath = "/usr/sbin/%s" % bin
	try:
		w = subprocess.getstatusoutput('codesign -d --entitlements :- %s' % spath)
		if 'dyld-environment-variables' in w[1]:
			print("\033[91m[-] POTENTIALLY INJECTABLE APP (has com.apple.security.cs-allow-dyld-environment-variables entitlement): %s\033[0m" % spath)
		if 'disable-library-validation' in w[1]:
			print("\033[33m[-] Binary can load artibrary unsigned plugins/frameworks (has com.apple.security.cs.disable-library-validation entitlement): %s\033[0m" % spath)
		if 'get-task-allow' in w[1]:
			print("\033[33m[-] Binary allows otehr non sandboxed processes to attach (has com.apple.security.get-task-allow entitlement): %s\033[0m" % spath)
		if 'allow-unsigned-executable-memory' in w[1]:
			print("\033[33m[-] Binary allows c code patching, NSCreateObjectFileImageFromMemory, or dvdplayback framework (has com.apple.security.cs.allow-unsigned-executable-memory entitlement): %s\033[0m" % spath)
		if 'security.files.downloads' in w[1]:
			print("\033[33m[-] Binary may  have access to the Downloads folder (has com.apple.security.files.downloads.read-only or com.apple.security.files.downloads.read-write entitlement): %s\033[0m" % spath)
		if 'security.files.all' in w[1]:
			print("\033[33m[-] Binary may have access to all files (has deprecated com.apple.security.files.all entitlement): %s\033[0m" % spath)
		if 'security.files.user-selected' in w[1]:
			print("\033[33m[-] Binary may have access to files the user has selected in an open or save dialog (has com.apple.security.files.user-selected.read-only or com.apple.security.files.user-selected.read-write entitlement): %s\033[0m" % spath)
	except:
		pass



print("=======================================/usr/bin Directory Check============================================")
a = os.listdir("/usr/bin")

for f in a:
	pth = "/usr/bin/%s" % f
	try:
		j = subprocess.getstatusoutput('codesign -d --entitlements :- %s' % pth)
		if 'dyld-environment-variables' in j[1]:
			print("\033[91m[-] POTENTIALLY INJECTABLE APP (has com.apple.security.cs-allow-dyld-environment-variables entitlement): %s\033[0m" % pth)
		if 'disable-library-validation' in j[1]:
			print("\033[33m[-] Binary can load artibrary unsigned plugins/frameworks (has com.apple.security.cs.disable-library-validation entitlement): %s\033[0m" % pth)
		if 'get-task-allow' in j[1]:
			print("\033[33m[-] Binary allows otehr non sandboxed processes to attach (has com.apple.security.get-task-allow entitlement): %s\033[0m" % pth)
		if 'allow-unsigned-executable-memory' in j[1]:
			print("\033[33m[-] Binary allows c code patching, NSCreateObjectFileImageFromMemory, or dvdplayback framework (has com.apple.security.cs.allow-unsigned-executable-memory entitlement): %s\033[0m" % pth)
		if 'security.files.downloads' in j[1]:
			print("\033[33m[-] Binary may  have access to the Downloads folder (has com.apple.security.files.downloads.read-only or com.apple.security.files.downloads.read-write entitlement): %s\033[0m" % pth)
		if 'security.files.all' in j[1]:
			print("\033[33m[-] Binary may have access to all files (has deprecated com.apple.security.files.all entitlement): %s\033[0m" % pth)
		if 'security.files.user-selected' in j[1]:
			print("\033[33m[-] Binary may have access to files the user has selected in an open or save dialog (has com.apple.security.files.user-selected.read-only or com.apple.security.files.user-selected.read-write entitlement): %s\033[0m" % pth)
	except:
		pass

print("[+] DONE!")
