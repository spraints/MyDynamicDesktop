//
//  info.swift
//  MyDynamicDesktop
//
//  Created by Matt Burke on 11/8/20.
//

import Foundation

func showDynamicDesktopImageInfo(file: String) {
    let url = NSURL(fileURLWithPath:file)
    let source = CGImageSourceCreateWithURL(url, nil)
    if source == nil {
        print("\(file): Not an image")
        exit(1)
    }

    print("type: \(CGImageSourceGetType(source!))")

    let status = CGImageSourceGetStatus(source!)
    print("status: \(status.rawValue)")

    let count = CGImageSourceGetCount(source!)
    for i in 0..<count {
        let indexStatus = CGImageSourceGetStatusAtIndex(source!, i)
        print("[\(i)] \(indexStatus.rawValue)")
    }
}
