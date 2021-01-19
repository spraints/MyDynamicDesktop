//
//  main.swift
//  MyDynamicDesktop
//
//  Created by Matt Burke on 11/7/20.
//

import Foundation
import CoreGraphics

func usage() {
    print("Usage: MyDynamicDesktop FILE")
    print("Usage: MyDynamicDesktop build --out OUT [--latitude LAT --longitude LONG] INPUT...")
}

struct Opts {
    var outFile = ""
    var latitude: Double? = nil
    var longitude: Double? = nil
}

enum NextArg {
    case anything
    case outFile
    case latitude
    case longitude
}

func parse(args: [String]) -> (Opts, [String]) {
    var opts = Opts()
    var resArgs: [String] = []
    var expected = NextArg.anything
    for arg in args {
        switch expected {
        case NextArg.anything:
            switch arg {
            case "--out", "-out":
                expected = NextArg.outFile
            case "--latitude", "-latitude", "--lat", "-lat":
                expected = NextArg.latitude
            case "--longitude", "--long", "-longitude", "-long":
                expected = NextArg.longitude
            default:
                if arg.starts(with: "-") {
                    print("Unrecognized arg \(arg)")
                    usage()
                    exit(1)
                }
                resArgs.append(arg)
            }
        case NextArg.outFile:
            opts.outFile = arg
            expected = NextArg.anything
        case NextArg.latitude:
            opts.latitude = Double(arg)
            expected = NextArg.anything
        case NextArg.longitude:
            opts.longitude = Double(arg)
            expected = NextArg.anything
        }
    }
    if expected != NextArg.anything {
        print("Expected \(expected).")
        usage()
        exit(1)
    }
    return (opts, resArgs)
}

switch CommandLine.argc {
case 0, 1:
    usage()
    exit(1)
case 2:
    showDynamicDesktopImageInfo(file: CommandLine.arguments[1])
default:
    if CommandLine.arguments[1] != "build" {
        print("Unrecognized arg \(CommandLine.arguments[1])")
        usage()
        exit(1)
    }
    let (opts, args) = parse(args: Array(CommandLine.arguments[2...]))
    if opts.outFile == "" {
        print("When building, -out is required.")
        usage()
        exit(1)
    }
    let loc = getLocation(latitude: opts.latitude, longitude: opts.longitude)
    buildDynamicDesktopImage(outfile: opts.outFile, loc: loc, images: args)
}
