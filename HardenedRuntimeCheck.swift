import Foundation
import Cocoa

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

                        let args : [String] = ["-d", "--verbose", "\(path2)"]

                        proc.arguments = args
                        let pipe = Pipe()

                        proc.standardError = pipe
                        proc.launch()

                        let results = pipe.fileHandleForReading.readDataToEndOfFile()
                        let out = String(data: results, encoding: String.Encoding.utf8)!


                        if out.contains("flags") && out.contains("runtime"){
                                print("\(green)[-] Hardened runtime enabled in: \(path2)\(colorend)")
                        }
                        else if out.contains("flags") && !(out.contains("runtime")){
                                print("\(yellow)[-] Hardened runtime NOT enabled in: \(path2)\(colorend)")
                        }
                        else {

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
    print("===========================/System/Applications/Utilities/ Directory Check=================================")
    for dir in appdir{
        if dir.hasSuffix(".app"){
            let app_path = "/System/Applications/Utilities/\(dir)/Contents/MacOS"

            do {
                let contents = try fileMan.contentsOfDirectory(atPath: app_path)

                for item in contents {
                    let path2 = "\(app_path)/\(item)"

                    let proc = Process()
                    proc.launchPath = "/usr/bin/codesign"
                    let args : [String] = ["-d", "--verbose", "\(path2)"]
                    proc.arguments = args
                    let pipe = Pipe()

                    proc.standardError = pipe
                    proc.launch()

                    let results = pipe.fileHandleForReading.readDataToEndOfFile()
                    let out = String(data: results, encoding: String.Encoding.utf8)!

                    if out.contains("flags") && out.contains("runtime"){
                            print("\(green)[-] Hardened runtime enabled in: \(path2)\(colorend)")
                    }
                    else if out.contains("flags") && !(out.contains("runtime")){
                            print("\(yellow)[-] Hardened runtime NOT enabled in: \(path2)\(colorend)")
                    }
                    else {

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
                        let args : [String] = ["-d", "--verbose", "\(bin_path)"]
                        proc.arguments = args
                        let pipe = Pipe()

                        proc.standardError = pipe
                        proc.launch()

                        let results = pipe.fileHandleForReading.readDataToEndOfFile()
                        let out = String(data: results, encoding: String.Encoding.utf8)!

                        if out.contains("flags") && out.contains("runtime"){
                                print("\(green)[-] Hardened runtime enabled in: \(bin_path)\(colorend)")
                        }
                        else if out.contains("flags") && !(out.contains("runtime")){
                                print("\(yellow)[-] Hardened runtime NOT enabled in: \(bin_path)\(colorend)")
                        }
                        else {

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
                        let args : [String] = ["-d", "--verbose", "\(bin_path)"]
                        proc.arguments = args
                        let pipe = Pipe()

                        proc.standardError = pipe
                        proc.launch()

                        let results = pipe.fileHandleForReading.readDataToEndOfFile()
                        let out = String(data: results, encoding: String.Encoding.utf8)!

                        if out.contains("flags") && out.contains("runtime"){
                                print("\(green)[-] Hardened runtime enabled in: \(bin_path)\(colorend)")
                        }
                        else if out.contains("flags") && !(out.contains("runtime")){
                                print("\(yellow)[-] Hardened runtime NOT enabled in: \(bin_path)\(colorend)")
                        }
                        else {

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
                        let args : [String] = ["-d", "--verbose", "\(bin_path)"]
                        proc.arguments = args
                        let pipe = Pipe()

                        proc.standardError = pipe
                        proc.launch()

                        let results = pipe.fileHandleForReading.readDataToEndOfFile()
                        let out = String(data: results, encoding: String.Encoding.utf8)!

                        if out.contains("flags") && out.contains("runtime"){
                                print("\(green)[-] Hardened runtime enabled in: \(bin_path)\(colorend)")
                        }
                        else if out.contains("flags") && !(out.contains("runtime")){
                                print("\(yellow)[-] Hardened runtime NOT enabled in: \(bin_path)\(colorend)")
                        }
                        else {

                        }

                } catch {

                }
        }
    }
    catch {

    }
    print("")

}

print("===> Checking common app/bin locations for hardened runtime...")
AppDirCheck()
UtiltiesDirCheck()
LocalBinCheck()
sbinDirCheck()
binDirCheck()

print("[+] DONE!")
