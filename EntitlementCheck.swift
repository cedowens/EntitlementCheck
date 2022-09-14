import Foundation
import Cocoa

let red = "\u{001B}[0;31m"
let green = "\u{001B}[0;32m"
let yellow = "\u{001B}[0;33m"
let colorend = "\u{001B}[0;0m"

func AppDirCheck(){

    do {
        let fileMan = FileManager.default
        let appdir = try fileMan.contentsOfDirectory(atPath: "/Applications")
        print("===========================/Applications Directory Check=================================")
        for dir in appdir{
            if dir.hasSuffix(".app"){
                let app_path = "/Applications/\(dir)/Contents/MacOS"

                do {
                    let contents = try fileMan.contentsOfDirectory(atPath: app_path)

                    for item in contents {
                        let path2 = "\(app_path)/\(item)"

                        let proc = Process()
                        proc.launchPath = "/usr/bin/codesign"
                        let args : [String] = ["-d", "--entitlements", ":-", "\(path2)"]
                        proc.arguments = args
                        let pipe = Pipe()

                        proc.standardOutput = pipe
                        proc.standardError = FileHandle.nullDevice
                        proc.launch()

                        let results = pipe.fileHandleForReading.readDataToEndOfFile()
                        let out = String(data: results, encoding: String.Encoding.utf8)!

                        if out.contains("com.apple.security.cs.allow-dyld-environment-variables</key><true/>"){
                                print("\(red)[-] POTENTIALLY INJECTABLE APP (has com.apple.security.cs-allow-dyld-environment-variables entitlement): \(path2)\(colorend)")
                        }

                        if out.contains("com.apple.security.cs.disable-library-validation</key><true/>"){
                                print("\(yellow)[-] Binary can load arbitrary unsigned plugins/frameworks (has com.apple.security.cs.disable-library-validation entitlement): \(path2)\(colorend)")
                        }

                        if out.contains("com.apple.security.get-task-allow</key><true/>"){
                                print("[-] Binary allows other non sandboxed processes to attach (has com.apple.security.get-task-allow entitlement): \(path2)")
                        }

                        if out.contains("com.apple.security.cs.allow-unsigned-executable-memory</key><true/>"){
                                print("[-] Binary allows c code patching, NSCreateObjectFileImageFromMemory, or dvdplayback framework (has com.apple.security.cs.allow-unsigned-executable-memory entitlement): \(path2)")
                        }

                        if out.contains("com.apple.security.files.downloads.read-only</key><true/>") || out.contains("com.apple.security.files.downloads.read-write</key></true>") {
                                print("[-] Binary may  have access to the Downloads folder (has com.apple.security.files.downloads.read-only or com.apple.security.files.downloads.read-write entitlement): \(path2)")
                        }

                        if out.contains("com.apple.security.files.all</key><true/>"){
                                print("[-] Binary may have access to all files (has deprecated com.apple.security.files.all entitlement): \(path2)")
                        }

                        if out.contains("com.apple.security.files.user-selected.read-only</key><true/>") || out.contains("com.apple.security.files.user-selected.read-write</key><true/>"){
                                print("[-] Binary may have access to files the user has selected in an open or save dialog (has com.apple.security.files.user-selected.read-only or com.apple.security.files.user-selected.read-write entitlement): \(path2)")
                        }

                        if out.contains("com.apple.private.security.clear-library-validation</key><true/>"){
                                print("[-] Binary can load third party plugins signed by non Apple developers (has com.apple.private.security.clear-library-validation entitlement): \(path2)")
                        }

                        if out.contains("com.apple.private.tcc.allow</key>"){
                                print("[-] Binary may have TCC access to some protected portions of the OS (has com.apple.private.tcc.allow entitlement): \(path2)")
                        }

                        if out.contains("kTCCServiceSystemPolicyDocumentsFolder"){
                                print("[-] Binary may have TCC access to ~/Documents (has kTCCServiceSystemPolicyDocumentsFolder access): \(path2)")
                        }

                        if out.contains("kTCCServiceSystemPolicyDownloadsFolder"){
                                print("[-] Binary may have TCC access to ~/Downloads (has kTCCServiceSystemPolicyDownloadsFolder access): \(path2)")
                        }

                        if out.contains("kTCCServiceSystemPolicyDesktopFolder"){
                                print("[-] Binary may have TCC access to ~/Desktop (has kTCCServiceSystemPolicyDesktopFolder access): \(path2)")
                        }

                        if out.contains("kTCCServiceSystemPolicyAllFiles"){
                                print("[-] Binary may have FDA access (has kTCCServiceSystemPolicyAllFiles access): \(path2)")
                        }

                    }
                } catch {

                }
            }
        }
    }
    catch {

    }
    print("")

}

func UtiltiesDirCheck(){

    do {
        let fileMan = FileManager.default
        let appdir = try fileMan.contentsOfDirectory(atPath: "/System/Applications/Utilities/")

        print("===========================/System/Applications/Utilities Directory Check=================================")
        for dir in appdir{
            if dir.hasSuffix(".app"){

                let app_path = "/System/Applications/Utilities/\(dir)/Contents/MacOS"

                do {
                    let contents = try fileMan.contentsOfDirectory(atPath: app_path)

                    for item in contents {
                        let path2 = "\(app_path)/\(item)"

                        let proc = Process()
                        proc.launchPath = "/usr/bin/codesign"
                        let args : [String] = ["-d", "--entitlements", ":-", "\(path2)"]
                        proc.arguments = args
                        let pipe = Pipe()

                        proc.standardOutput = pipe
                        proc.standardError = FileHandle.nullDevice
                        proc.launch()

                        let results = pipe.fileHandleForReading.readDataToEndOfFile()
                        let out = String(data: results, encoding: String.Encoding.utf8)!

                        if out.contains("com.apple.security.cs.allow-dyld-environment-variables</key><true/>"){
                                print("\(red)[-] POTENTIALLY INJECTABLE APP (has com.apple.security.cs-allow-dyld-environment-variables entitlement): \(path2)\(colorend)")
                        }

                        if out.contains("com.apple.security.cs.disable-library-validation</key><true/>"){
                                print("\(yellow)[-] Binary can load arbitrary unsigned plugins/frameworks (has com.apple.security.cs.disable-library-validation entitlement): \(path2)\(colorend)")
                        }

                        if out.contains("com.apple.security.get-task-allow</key><true/>"){
                                print("[-] Binary allows other non sandboxed processes to attach (has com.apple.security.get-task-allow entitlement): \(path2)")
                        }

                        if out.contains("com.apple.security.cs.allow-unsigned-executable-memory</key><true/>"){
                                print("[-] Binary allows c code patching, NSCreateObjectFileImageFromMemory, or dvdplayback framework (has com.apple.security.cs.allow-unsigned-executable-memory entitlement): \(path2)")
                        }

                        if out.contains("com.apple.security.files.downloads.read-only</key><true/>") || out.contains("com.apple.security.files.downloads.read-write</key></true>") {
                                print("[-] Binary may  have access to the Downloads folder (has com.apple.security.files.downloads.read-only or com.apple.security.files.downloads.read-write entitlement): \(path2)")
                        }

                        if out.contains("com.apple.security.files.all</key><true/>"){
                                print("[-] Binary may have access to all files (has deprecated com.apple.security.files.all entitlement): \(path2)")
                        }

                        if out.contains("com.apple.security.files.user-selected.read-only</key><true/>") || out.contains("com.apple.security.files.user-selected.read-write</key><true/>"){
                                print("[-] Binary may have access to files the user has selected in an open or save dialog (has com.apple.security.files.user-selected.read-only or com.apple.security.files.user-selected.read-write entitlement): \(path2)")
                        }

                        if out.contains("com.apple.private.security.clear-library-validation</key><true/>"){
                                print("[-] Binary can load third party plugins signed by non Apple developers (has com.apple.private.security.clear-library-validation entitlement): \(path2)")
                        }

                        if out.contains("com.apple.private.tcc.allow</key>"){
                                print("[-] Binary may have TCC access to some protected portions of the OS (has com.apple.private.tcc.allow entitlement): \(path2)")
                        }

                        if out.contains("kTCCServiceSystemPolicyDocumentsFolder"){
                                print("[-] Binary may have TCC access to ~/Documents (has kTCCServiceSystemPolicyDocumentsFolder access): \(path2)")
                        }

                        if out.contains("kTCCServiceSystemPolicyDownloadsFolder"){
                                print("[-] Binary may have TCC access to ~/Downloads (has kTCCServiceSystemPolicyDownloadsFolder access): \(path2)")
                        }

                        if out.contains("kTCCServiceSystemPolicyDesktopFolder"){
                                print("[-] Binary may have TCC access to ~/Desktop (has kTCCServiceSystemPolicyDesktopFolder access): \(path2)")
                        }

                        if out.contains("kTCCServiceSystemPolicyAllFiles"){
                                print("[-] Binary may have FDA access (has kTCCServiceSystemPolicyAllFiles access): \(path2)")
                        }

                    }
                } catch {

                }
            }
        }
    }
    catch {

    }
    print("")

}

func LocalBinCheck(){

    do {
        let fileMan = FileManager.default
        let appdir = try fileMan.contentsOfDirectory(atPath: "/usr/local/bin/")

        print("===========================/usr/local/bin Directory Check=================================")

        for bin in appdir{

                do {
                    let bin_path = "/usr/local/bin/\(bin)"

                        let proc = Process()
                        proc.launchPath = "/usr/bin/codesign"
                        let args : [String] = ["-d", "--entitlements", ":-", "\(bin_path)"]
                        proc.arguments = args
                        let pipe = Pipe()

                        proc.standardOutput = pipe
                        proc.standardError = FileHandle.nullDevice
                        proc.launch()

                        let results = pipe.fileHandleForReading.readDataToEndOfFile()
                        let out = String(data: results, encoding: String.Encoding.utf8)!

                        if out.contains("com.apple.security.cs.allow-dyld-environment-variables</key><true/>"){
                                print("\(red)[-] POTENTIALLY INJECTABLE APP (has com.apple.security.cs-allow-dyld-environment-variables entitlement): \(bin_path)\(colorend)")
                        }

                        if out.contains("com.apple.security.cs.disable-library-validation</key><true/>"){
                                print("\(yellow)[-] Binary can load arbitrary unsigned plugins/frameworks (has com.apple.security.cs.disable-library-validation entitlement): \(bin_path)\(colorend)")
                        }

                        if out.contains("com.apple.security.get-task-allow</key><true/>"){
                                print("[-] Binary allows other non sandboxed processes to attach (has com.apple.security.get-task-allow entitlement): \(bin_path)")
                        }

                        if out.contains("com.apple.security.cs.allow-unsigned-executable-memory</key><true/>"){
                                print("[-] Binary allows c code patching, NSCreateObjectFileImageFromMemory, or dvdplayback framework (has com.apple.security.cs.allow-unsigned-executable-memory entitlement): \(bin_path)")
                        }

                        if out.contains("com.apple.security.files.downloads.read-only</key><true/>") || out.contains("com.apple.security.files.downloads.read-write</key></true>") {
                                print("[-] Binary may  have access to the Downloads folder (has com.apple.security.files.downloads.read-only or com.apple.security.files.downloads.read-write entitlement): \(bin_path)")
                        }

                        if out.contains("com.apple.security.files.all</key><true/>"){
                                print("[-] Binary may have access to all files (has deprecated com.apple.security.files.all entitlement): \(bin_path)")
                        }

                        if out.contains("com.apple.security.files.user-selected.read-only</key><true/>") || out.contains("com.apple.security.files.user-selected.read-write</key><true/>"){
                                print("[-] Binary may have access to files the user has selected in an open or save dialog (has com.apple.security.files.user-selected.read-only or com.apple.security.files.user-selected.read-write entitlement): \(bin_path)")
                        }

                        if out.contains("com.apple.private.security.clear-library-validation</key><true/>"){
                                print("[-] Binary can load third party plugins signed by non Apple developers (has com.apple.private.security.clear-library-validation entitlement): \(bin_path)")
                        }

                        if out.contains("com.apple.private.tcc.allow</key>"){
                                print("[-] Binary may have TCC access to some protected portions of the OS (has com.apple.private.tcc.allow entitlement): \(bin_path)")
                        }

                        if out.contains("kTCCServiceSystemPolicyDocumentsFolder"){
                                print("[-] Binary may have TCC access to ~/Documents (has kTCCServiceSystemPolicyDocumentsFolder access): \(bin_path)")
                        }

                        if out.contains("kTCCServiceSystemPolicyDownloadsFolder"){
                                print("[-] Binary may have TCC access to ~/Downloads (has kTCCServiceSystemPolicyDownloadsFolder access): \(bin_path)")
                        }

                        if out.contains("kTCCServiceSystemPolicyDesktopFolder"){
                                print("[-] Binary may have TCC access to ~/Desktop (has kTCCServiceSystemPolicyDesktopFolder access): \(bin_path)")
                        }

                        if out.contains("kTCCServiceSystemPolicyAllFiles"){
                                print("[-] Binary may have FDA access (has kTCCServiceSystemPolicyAllFiles access): \(bin_path)")
                        }

                } catch {

                }
        }
    }
    catch {

    }
    print("")

}

func sbinDirCheck(){
    do {
        let fileMan = FileManager.default
        let appdir = try fileMan.contentsOfDirectory(atPath: "/usr/sbin/")

        print("===========================/usr/sbin Directory Check=================================")

        for bin in appdir{

                do {
                    let bin_path = "/usr/sbin/\(bin)"

                        let proc = Process()
                        proc.launchPath = "/usr/bin/codesign"
                        let args : [String] = ["-d", "--entitlements", ":-", "\(bin_path)"]
                        proc.arguments = args
                        let pipe = Pipe()

                        proc.standardOutput = pipe
                        proc.standardError = FileHandle.nullDevice
                        proc.launch()

                        let results = pipe.fileHandleForReading.readDataToEndOfFile()
                        let out = String(data: results, encoding: String.Encoding.utf8)!

                        if out.contains("com.apple.security.cs.allow-dyld-environment-variables</key><true/>"){
                                print("\(red)[-] POTENTIALLY INJECTABLE APP (has com.apple.security.cs-allow-dyld-environment-variables entitlement): \(bin_path)\(colorend)")
                        }

                        if out.contains("com.apple.security.cs.disable-library-validation</key><true/>"){
                                print("\(yellow)[-] Binary can load arbitrary unsigned plugins/frameworks (has com.apple.security.cs.disable-library-validation entitlement): \(bin_path)\(colorend)")
                        }

                        if out.contains("com.apple.security.get-task-allow</key><true/>"){
                                print("[-] Binary allows other non sandboxed processes to attach (has com.apple.security.get-task-allow entitlement): \(bin_path)")
                        }

                        if out.contains("com.apple.security.cs.allow-unsigned-executable-memory</key><true/>"){
                                print("[-] Binary allows c code patching, NSCreateObjectFileImageFromMemory, or dvdplayback framework (has com.apple.security.cs.allow-unsigned-executable-memory entitlement): \(bin_path)")
                        }

                        if out.contains("com.apple.security.files.downloads.read-only</key><true/>") || out.contains("com.apple.security.files.downloads.read-write</key></true>") {
                                print("[-] Binary may  have access to the Downloads folder (has com.apple.security.files.downloads.read-only or com.apple.security.files.downloads.read-write entitlement): \(bin_path)")
                        }

                        if out.contains("com.apple.security.files.all</key><true/>"){
                                print("[-] Binary may have access to all files (has deprecated com.apple.security.files.all entitlement): \(bin_path)")
                        }

                        if out.contains("com.apple.security.files.user-selected.read-only</key><true/>") || out.contains("com.apple.security.files.user-selected.read-write</key><true/>"){
                                print("[-] Binary may have access to files the user has selected in an open or save dialog (has com.apple.security.files.user-selected.read-only or com.apple.security.files.user-selected.read-write entitlement): \(bin_path)")
                        }

                        if out.contains("com.apple.private.security.clear-library-validation</key><true/>"){
                                print("[-] Binary can load third party plugins signed by non Apple developers (has com.apple.private.security.clear-library-validation entitlement): \(bin_path)")
                        }

                        if out.contains("com.apple.private.tcc.allow</key>"){
                                print("[-] Binary may have TCC access to some protected portions of the OS (has com.apple.private.tcc.allow entitlement): \(bin_path)")
                        }

                        if out.contains("kTCCServiceSystemPolicyDocumentsFolder"){
                                print("[-] Binary may have TCC access to ~/Documents (has kTCCServiceSystemPolicyDocumentsFolder access): \(bin_path)")
                        }

                        if out.contains("kTCCServiceSystemPolicyDownloadsFolder"){
                                print("[-] Binary may have TCC access to ~/Downloads (has kTCCServiceSystemPolicyDownloadsFolder access): \(bin_path)")
                        }

                        if out.contains("kTCCServiceSystemPolicyDesktopFolder"){
                                print("[-] Binary may have TCC access to ~/Desktop (has kTCCServiceSystemPolicyDesktopFolder access): \(bin_path)")
                        }

                        if out.contains("kTCCServiceSystemPolicyAllFiles"){
                                print("[-] Binary may have FDA access (has kTCCServiceSystemPolicyAllFiles access): \(bin_path)")
                        }

                } catch {

                }
        }
    }
    catch {

    }
    print("")
}

func binDirCheck(){

    do {
        let fileMan = FileManager.default
        let appdir = try fileMan.contentsOfDirectory(atPath: "/usr/bin/")

        print("===========================/usr/bin Directory Check=================================")

        for bin in appdir{

                do {
                    let bin_path = "/usr/bin/\(bin)"

                        let proc = Process()
                        proc.launchPath = "/usr/bin/codesign"
                        let args : [String] = ["-d", "--entitlements", ":-", "\(bin_path)"]
                        proc.arguments = args
                        let pipe = Pipe()

                        proc.standardOutput = pipe
                        proc.standardError = FileHandle.nullDevice
                        proc.launch()

                        let results = pipe.fileHandleForReading.readDataToEndOfFile()
                        let out = String(data: results, encoding: String.Encoding.utf8)!

                        if out.contains("com.apple.security.cs.allow-dyld-environment-variables</key><true/>"){
                                print("\(red)[-] POTENTIALLY INJECTABLE APP (has com.apple.security.cs-allow-dyld-environment-variables entitlement): \(bin_path)\(colorend)")
                        }

                        if out.contains("com.apple.security.cs.disable-library-validation</key><true/>"){
                                print("\(yellow)[-] Binary can load arbitrary unsigned plugins/frameworks (has com.apple.security.cs.disable-library-validation entitlement): \(bin_path)\(colorend)")
                        }

                        if out.contains("com.apple.security.get-task-allow</key><true/>"){
                                print("[-] Binary allows other non sandboxed processes to attach (has com.apple.security.get-task-allow entitlement): \(bin_path)")
                        }

                        if out.contains("com.apple.security.cs.allow-unsigned-executable-memory</key><true/>"){
                                print("[-] Binary allows c code patching, NSCreateObjectFileImageFromMemory, or dvdplayback framework (has com.apple.security.cs.allow-unsigned-executable-memory entitlement): \(bin_path)")
                        }

                        if out.contains("com.apple.security.files.downloads.read-only</key><true/>") || out.contains("com.apple.security.files.downloads.read-write</key></true>") {
                                print("[-] Binary may  have access to the Downloads folder (has com.apple.security.files.downloads.read-only or com.apple.security.files.downloads.read-write entitlement): \(bin_path)")
                        }

                        if out.contains("com.apple.security.files.all</key><true/>"){
                                print("[-] Binary may have access to all files (has deprecated com.apple.security.files.all entitlement): \(bin_path)")
                        }

                        if out.contains("com.apple.security.files.user-selected.read-only</key><true/>") || out.contains("com.apple.security.files.user-selected.read-write</key><true/>"){
                                print("[-] Binary may have access to files the user has selected in an open or save dialog (has com.apple.security.files.user-selected.read-only or com.apple.security.files.user-selected.read-write entitlement): \(bin_path)")
                        }

                        if out.contains("com.apple.private.security.clear-library-validation</key><true/>"){
                                print("[-] Binary can load third party plugins signed by non Apple developers (has com.apple.private.security.clear-library-validation entitlement): \(bin_path)")
                        }

                        if out.contains("com.apple.private.tcc.allow</key>"){
                                print("[-] Binary may have TCC access to some protected portions of the OS (has com.apple.private.tcc.allow entitlement): \(bin_path)")
                        }

                        if out.contains("kTCCServiceSystemPolicyDocumentsFolder"){
                                print("[-] Binary may have TCC access to ~/Documents (has kTCCServiceSystemPolicyDocumentsFolder access): \(bin_path)")
                        }

                        if out.contains("kTCCServiceSystemPolicyDownloadsFolder"){
                                print("[-] Binary may have TCC access to ~/Downloads (has kTCCServiceSystemPolicyDownloadsFolder access): \(bin_path)")
                        }

                        if out.contains("kTCCServiceSystemPolicyDesktopFolder"){
                                print("[-] Binary may have TCC access to ~/Desktop (has kTCCServiceSystemPolicyDesktopFolder access): \(bin_path)")
                        }

                        if out.contains("kTCCServiceSystemPolicyAllFiles"){
                                print("[-] Binary may have FDA access (has kTCCServiceSystemPolicyAllFiles access): \(bin_path)")
                        }

                } catch {

                }
        }
    }
    catch {

    }
    print("")

}

print("===> Checking entitlements in common app/bin directories...")
AppDirCheck()
UtiltiesDirCheck()
LocalBinCheck()
sbinDirCheck()
binDirCheck()

print("[+] DONE!")
