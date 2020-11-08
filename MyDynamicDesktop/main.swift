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

switch CommandLine.argc {
case 0, 1:
    usage()
    exit(1)
case 2:
    showDynamicDesktopImageInfo(file: CommandLine.arguments[1])
default:
    print("todo: build dynamic desktop image info")
    //buildDynamicDesktopImageInfo(...)
}
