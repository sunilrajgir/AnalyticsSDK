//
//  TTest1.swift
//  Analytics
//
//  Created by Sunil Kumar29 on 19/02/21.
//

import Foundation


enum TTEventNames {
    static let screen1 = "abc"
    static let screen2 = "xyz"
}



enum FeatureOne {
    
}

class Test11 {
    init() {
        TTAnalyticsManager.shared.track(event: TTEvent(name: "abc", params: [:]))
    }
}

class Test22 {
    init() {
        TTAnalyticsManager.shared.track(event: TTEvent(name: "xyz", params: [:]))
    }
}

struct TTEvent: TTEventProtocol{
    var name: String
    var params: [String : Any]
}

protocol TTEventProtocol {
    var name:String{get set}
    var params:[String:Any]{get set}
}

protocol TTAnalyticsProtocol {
    func track(event:TTEventProtocol)
}

final class TTAnalyticsManager: TTAnalyticsProtocol {
    static let shared = TTAnalyticsManager()
    var loggers = [TTLoggerProtocol]()
    private init() {
        loggers.append(TTFirebase())
        loggers.append(TTFacebook())
    }

    func track(event: TTEventProtocol) {
        for logger in loggers{
            logger.track(event: event)
        }
    }
}

protocol TTLoggerProtocol {
    func track(event:TTEventProtocol)
}

class TTFirebase: TTLoggerProtocol {
    func track(event: TTEventProtocol) {
        
    }
}

class TTFacebook:  TTLoggerProtocol{
    func track(event: TTEventProtocol) {
        
    }
}
