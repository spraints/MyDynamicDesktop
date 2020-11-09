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
    
    //    let props = CGImageSourceCopyProperties(source!, nil) as NSDictionary?
    //    for (key, value) in props! {
    //        print("[\(key)] \(value)")
    //    }
    
    let count = CGImageSourceGetCount(source!)
    for i in 0..<count {
        //        let indexProps = CGImageSourceCopyPropertiesAtIndex(source!, i, nil) as NSDictionary?
        //        for (key, value) in indexProps! {
        //            print("[\(i)] [\(key)] \(value)")
        //        }
        
        let indexMetadata = CGImageSourceCopyMetadataAtIndex(source!, i, nil)
        if indexMetadata != nil {
            let tags = CGImageMetadataCopyTags(indexMetadata!) as NSArray?
            if tags != nil {
                for o in tags! {
                    let tag = o as! CGImageMetadataTag
                    let name = CGImageMetadataTagCopyName(tag)
                    let namespace = CGImageMetadataTagCopyNamespace(tag)
                    let prefix = CGImageMetadataTagCopyPrefix(tag)
                    let qualifiers = CGImageMetadataTagCopyQualifiers(tag)
                    let value = CGImageMetadataTagCopyValue(tag)
                    let decodedValue = decodeValue(value, namespace: namespace, prefix: prefix, name: name)
                    // print("[\(i)] METADATA \(tag)")
                    print("[\(i)] METADATA namespace:\(namespace) prefix:\(prefix) name:\(name) qualifiers:\(qualifiers) value:\(decodedValue)")
                }
            }
        }
    }
}

func decodeValue(_ value: AnyObject?, namespace: CFString?, prefix: CFString?, name: CFString?) -> AnyObject? {
    if strEq(namespace, "http://ns.apple.com/namespace/1.0/") && strEq(prefix, "apple_desktop") && strEq(name, "solar") {
        return decodeSolarData(value)
    }
    return value
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
