//
//  TTest1.swift
//  Analytics
//
//  Created by Sunil Kumar29 on 19/02/21.
//

import Foundation


enum TTEventName {
    static let screenView = "Screen Visit"
    static let clickEvent = "Click Event"
}

enum TTParamsName {
    static let screen = "screen_name"
    static let click = "click_name"
}



enum FeatureOne {
    
}


enum TTfeature1 {
    @TTEvent(screenName: "screen1")
    static var featureScreen1 : TTEvent
    
    @TTEvent(clickValue: "button1")
    static var featureButton1 : TTEvent
}

enum TTfeature2 {
    @TTEvent(screenName: "screen2")
    static var featureScreen2 : TTEvent
    
    @TTEvent(clickValue: "button2")
    static var featureButton2 : TTEvent
 }

class Test11 {
    init() {
        TTAnalyticsManager.shared.track(event: TTfeature1.featureScreen1)
    }
}

class Test22 {
    init() {
        TTAnalyticsManager.shared.track(event: TTfeature2.featureScreen2)
    }
}

@propertyWrapper
struct TTEvent: TTEventProtocol{
    var name: String
    var params: [String : Any]
    var wrappedValue : TTEvent {
        return TTEvent(name: name, params: params)
    }
}

extension TTEvent {
    init(screenName: String) {
        self.init(name: EventName.screenVisit, params: [TTParamsName.screen:screenName])
    }
    
    init(clickValue:String) {
        self.init(name: EventName.clickEvent, params: [TTParamsName.click:clickValue])
    }
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

class TTest1 {
    init() {
        Test11()
        Test22()
    }
}
