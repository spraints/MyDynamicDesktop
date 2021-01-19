//
//  info.swift
//  MyDynamicDesktop
//
//  Created by Matt Burke on 11/8/20.
//

import Foundation

func showDynamicDesktopImageInfo(file: String) {
    let url = NSURL(fileURLWithPath: file)
    let source = CGImageSourceCreateWithURL(url, nil)
    if source == nil {
        print("\(file): Not an image")
        exit(1)
    }
    
    print("\(file):")
    
    let metadata = CGImageSourceCopyMetadataAtIndex(source!, 0, nil)
    
    if metadata == nil {
        print("no metadata")
        return
    }
    
    let tags = CGImageMetadataCopyTags(metadata!) as NSArray?
    if tags == nil {
        print("no tags in metadata")
        return
    }
    
    var foundSolar = false
    for o in tags! {
        let tag = o as! CGImageMetadataTag
        if isSolar(tag) {
            print("found solar data!")
            // TODO - format this more better, using human names rather than "ap", "d", "l", "si", etc.
            print(decodeSolarData(CGImageMetadataTagCopyValue(tag)))
            foundSolar = true
        }
    }
    if !foundSolar {
        print("no solar info")
    }
}

func isSolar(_ tag: CGImageMetadataTag) -> Bool {
    if !strEq(CGImageMetadataTagCopyNamespace(tag), "http://ns.apple.com/namespace/1.0/") {
        return false
    }
    if !strEq(CGImageMetadataTagCopyPrefix(tag), "apple_desktop") {
        return false
    }
    if !strEq(CGImageMetadataTagCopyName(tag), "solar") {
        return false
    }
    return true
}

func decodeSolarData(_ value: AnyObject?) -> NSDictionary {
    let decoded = NSData(base64Encoded: value! as! String, options: NSData.Base64DecodingOptions(rawValue: 0)) as Data?
    return try! PropertyListSerialization.propertyList(from: decoded!, format: nil) as! NSDictionary
}

func strEq(_ str: CFString?, _ expected: String) -> Bool {
    if str == nil {
        return false
    }
    return str! as String == expected
}
