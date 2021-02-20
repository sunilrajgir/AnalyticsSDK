//
//  Test.swift
//  Analytics
//
//  Created by Sunil Kumar29 on 19/02/21.
//

import Foundation

enum EventName {
    static let screenVisit = "Screen Visit"
    static let clickEvent = "Click Event"
}

enum ParameterName {
    static let screen = "screen_name"
    static let click = "click_target"
}


protocol EventProtocol {
    var name: String { get set }
    var params: [String: Any] { get set }
}

@propertyWrapper
struct Event: EventProtocol {
    var name: String
    var params: [String: Any] = [:]

    var wrappedValue: Event {
        return Event(name: name,
                     params: params)
    }
}
// Helper init methods
extension Event {
    init(screenValue: String) {
        self.init(name: EventName.screenVisit,
                  params: [ParameterName.screen: screenValue])
    }

    init(clickValue: String) {
        self.init(name: EventName.clickEvent,
                  params: [ParameterName.click: clickValue])
    }
}


// FeatureOne
enum FeatureOneEvents {
    @Event(screenValue: "featureOne")
    static var screen: Event

    @Event(clickValue: "tappedFeatureOneButton")
    static var buttonClick: Event
}

// FeatureTwo
enum FeatureTwoEvents {
    @Event(screenValue: "featureTwo")
    static var screen: Event

    @Event(clickValue: "tappedFeatureTwoButton")
    static var buttonClick: Event
}


struct UserProfileModel {
    
}

protocol AnalyticsEventsLoggerProtocol {
  func setUserProperties(user: UserProfileModel)
  func trackEvent(event: EventProtocol)
}

// Firebase
class FirebaseEventLogger: AnalyticsEventsLoggerProtocol {
    func setUserProperties(user: UserProfileModel) {
        // set user properties
    }

    func trackEvent(event: EventProtocol) {
        // add implementation of tracking events
    }
}

// Mixpanel
class MixpanelEventLogger: AnalyticsEventsLoggerProtocol {
    func setUserProperties(user: UserProfileModel) {
        // set user properties
    }

    func trackEvent(event: EventProtocol) {
        // add implementation of tracking events
    }
}



protocol AnalyticsManagerProtocol {
   func setUp()
   func trackEvent(_ event: EventProtocol, params: [String: Any])
}

class AnalyticsManager: AnalyticsManagerProtocol {
    static let shared = AnalyticsManager()
    var loggers: [AnalyticsEventsLoggerProtocol] = []

    func setUp() {
     // Setup all the Analytics SDK
    }
    
    func trackEvent(_ event: EventProtocol,
                    params: [String: Any] = [:]) {
        // add extra params to event
        // hit event from all tracking SDK's
        loggers.forEach({ logger in
            logger.trackEvent(event: event)
        })
    }
}


class Test1 {
    init() {
        AnalyticsManager.shared.trackEvent(FeatureOneEvents.screen)
    }
}

class Test2 {
    init() {
        AnalyticsManager.shared.trackEvent(FeatureTwoEvents.screen)
    }
}
