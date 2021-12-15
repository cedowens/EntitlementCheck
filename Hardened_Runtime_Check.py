#!/usr/bin/env python3
import sys
import os
import subprocess

d = os.listdir("/Applications/")

for each in d:
	if each.endswith('.app'):
		apath = "/Applications/%s/Contents/MacOS" % each
		if os.access(apath, os.R_OK):
			p = os.listdir(apath)
			for item in p:
				apath2 = apath + "/" + item
				try:
					x = subprocess.getstatusoutput('codesign --display --verbose "%s"' % apath2)
					if (('flags' in x[1]) and ('runtime' in x[1])):
						print("\033[92m[+] Hardened runtime enabled in: %s\033[0m" % apath2)
					elif (('flags' in x[1]) and ('runtime' not in x[1])):
						print("\033[33m[-] Hardened runtime NOT enabled in: %s\033[0m" % apath2)
					else:
						pass
				except:
					pass



c = os.listdir("/usr/local/bin")

for binary in c:
	pth = "/usr/local/bin/%s" % binary
	try:
		if os.access(pth, os.R_OK):
			z = subprocess.getstatusoutput('codesign --display --verbose "%s"' % pth)
			if (('flags' in z[1]) and ('runtime' in z[1])):
				print("\033[92m[+] Hardened runtime enabled in: %s\033[0m" % pth)
			elif (('flags' in z[1]) and ('runtime' not in z[1])):
				print("\033[33m[-] Hardened runtime NOT enabled in: %s\033[0m" % pth)
			else:
				pass
	except:
		pass




b = os.listdir("/usr/sbin")

for bin in b:
	pth2 = "/usr/sbin/%s" % bin
	try:
		if os.access(pth2, os.R_OK):
			y = subprocess.getstatusoutput('codesign --display --verbose "%s"' % pth2)
			if (('flags' in y[1]) and ('runtime' in y[1])):
				print("\033[92m[+] Hardened runtime enabled in: %s\033[0m" % pth2)
			elif (('flags' in y[1]) and ('runtime' not in y[1])):
				print("\033[33m[-] Hardened runtime NOT enabled in: %s\033[0m" % pth2)
			else:
				pass
	except:
		pass




a = os.listdir("/usr/bin")

for file in a:
	pth3 = "/usr/bin/%s" % file
	try:
		q = subprocess.getstatusoutput('codesign --display --verbose "%s"' % pth3)
		if (('flags' in q[1]) and ('runtime' in q[1])):
			print("\033[92m[+] Hardened runtime enabled in: %s\033[0m" % pth3)
		elif (('flags' in q[1]) and ('runtime' not in q[1])):
			print("\033[33m[-] Hardened runtime NOT enabled in: %s\033[0m" % pth3)
		else:
			pass
	except:
		pass 
