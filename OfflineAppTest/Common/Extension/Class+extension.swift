//
//  Class+extension.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 23/09/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

public protocol ReflectedStringConvertible : CustomStringConvertible { }

extension ReflectedStringConvertible {
  public var description: String {
    let mirror = Mirror(reflecting: self)
    
    var str = "\(mirror.subjectType)("
    var first = true
    for (label, value) in mirror.children {
      if let label = label {
        if first {
          first = false
        } else {
          str += ", "
        }
        str += label
        str += ": "
        str += "\(value)"
      }
    }
    str += ")"
    
    return str
  }
}
