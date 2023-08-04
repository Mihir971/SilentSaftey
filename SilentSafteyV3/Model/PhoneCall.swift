//
//  PhoneCall.swift
//  SilentSafteyV3
//
//  Created by Mihir Thakur on 8/6/23.
//

import UIKit
import Foundation
import CallKit
import AVFAudio

class PhoneCall: NSObject, CXProviderDelegate, AVSpeechSynthesizerDelegate, CXCallObserverDelegate {
    
    var callObserver: CXCallObserver?
    var backgroundTaskID: UIBackgroundTaskIdentifier?
    var provider = CXProvider(configuration: CXProviderConfiguration())
    let callController = CXCallController()
    let locMan = LocationManager()
    var currentCallUUID: UUID?
    var messageQueue: [String] = []
    var synthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()
    var updateTimer: Timer?
    
    override init() {
        //add lower volume
        super.init()
        let _ = try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: .duckOthers)
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print("Unable to activate audio session: \(error.localizedDescription)")
        }
        synthesizer.mixToTelephonyUplink = true
        synthesizer.delegate = self
        
        provider.setDelegate(self, queue: nil)
        let config = CXProviderConfiguration()
        config.supportsVideo = false
        provider = CXProvider(configuration: config)
    }
    
    func generateFirstMessage(type: CallType) -> String{
        let message: String
        
        var name: String = ""
        var race: String = ""
        var gender: String = ""
        var weight: String = ""
        var year: String = ""
        var month: String = ""
        var day: String = ""
        var feet: String = ""
        var inches: String = ""
        var additional: String = "no additional info"
        
        if let n = UserDefaults.standard.object(forKey: "name") as? String{
            name = n
        }
        if let r = UserDefaults.standard.object(forKey: "race") as? String{
            race = r
        }
        if let g = UserDefaults.standard.object(forKey: "gender") as? String{
            gender = g
        }
        if let w = UserDefaults.standard.object(forKey: "weight") as? String{
            weight = w
        }
        if let y = UserDefaults.standard.object(forKey: "year") as? String{
            year = y
        }
        if let m = UserDefaults.standard.object(forKey: "month") as? String{
            month = m
        }
        if let d = UserDefaults.standard.object(forKey: "day") as? String{
            day = d
        }
        if let f = UserDefaults.standard.object(forKey: "feet") as? String{
            feet = f
        }
        if let i = UserDefaults.standard.object(forKey: "inches") as? String{
            inches = i
        }
        if let a = UserDefaults.standard.object(forKey: "additional") as? String{
            additional = a
        }
        switch type{
        case .police:
            message = "Hello, this is Silent Safety calling on behalf of \(name) spelled as \(addSpacesBetweenCharactersForname(name)) who requires urgent police presence. \(name) is a \(race) \(gender), with a height of \(feet) foot \(inches) and a weight of \(weight) pounds. \(name)'s was born on the \(day) of \(month) \(year). \(name) has also provided the following \(additional)."
        case .fireDepartment:
            message = "Hello, this is Silent Safety Calling on behalf of \(name) spelled as \(addSpacesBetweenCharactersForname(name)) who requires urgent fire fighter presence. \(name) is a \(race) \(gender), with a height of \(feet) foot \(inches) and a weight of \(weight) pounds. \(name)'s was born on the \(day) of \(month) \(year). \(name) has also provided the following \(additional)."
        case .health:
            message = "Hello, this is Silent Safety Calling on behalf of \(name) spelled as \(addSpacesBetweenCharactersForname(name)) who requires urgent medical help. \(name) is a \(race) \(gender), with a height of \(feet) foot \(inches) and a weight of \(weight) pounds. \(name)'s was born on the \(day) of \(month) \(year). \(name) has also provided the following \(additional)."
        case .personal:
            message = "Hello, this is Silent Safety Calling on behalf of \(name) spelled as \(addSpacesBetweenCharactersForname(name)). \(name) is a \(race) \(gender), with a height of \(feet) foot \(inches) and a weight of \(weight) pounds. \(name)'s was born on the \(day) of \(month) \(year). \(name) has also provided the following \(additional)."
        }
//        return message
        return "testing"
    }
    
    func addSpacesBetweenCharactersForname(_ input: String) -> String {
        return input.map { String($0) }.joined(separator: " ")
    }
    
    func setUpObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: Notification.Name("MyNotification"), object: nil)
    }
    
    @objc func handleNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            // Extract data from userInfo dictionary
            if let value = userInfo["key"] as? String {
                speakMessage(message: "\(value)")
            }
        }
    }
    
    func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
        if call.hasEnded == true {
            callEnded()
        } else if call.isOutgoing == true && call.hasConnected == false {
            callDialed()
        } else if call.hasConnected == true && call.hasEnded == false {
            callConnected()
        }
    }
    
    func callDialed() {
        startBackGroundTask()
//        setUpObservers()
    }
    
    func callConnected() {
        setUpObservers()
        startUpdateTimer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            speakMessage(message: generateFirstMessage(type: .police))
        }
    }
    
    func callEnded() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("MyNotification"), object: nil)
        callObserver = nil
        stopUpdateTimer()
        self.synthesizer.stopSpeaking(at: .immediate) // Stop speaking after done
        endBackGroundTask()
    }
    
    func startUpdateTimer() {
        updateTimer = Timer.scheduledTimer(withTimeInterval: 45, repeats: true) { [weak self] _ in
            self?.updateFunction()
        }
    }
    
    func stopUpdateTimer() {
        updateTimer?.invalidate()
        updateTimer = nil
    }
    
    func updateFunction() {
        getLocationString { locationString in
            NotificationCenter.default.post(name: Notification.Name("MyNotification"), object: nil, userInfo: ["key": "\(locationString)"])
        }
    }
    
    func getLocationString(completion: @escaping (String) -> Void) {
        var locationString = ""
        locMan.fetchUserLocation { streetAddress, location in
            if let streetAddress = streetAddress {
                locationString = "the street address of the user is \(streetAddress)"
                print("Street Address: \(streetAddress)")
            } else {
                print("Failed to get street address.")
            }
            if let location = location {
                locationString.append(" and the latitude and longitude coordinates of the user are latitude \(location.coordinate.latitude) and longitude \(location.coordinate.longitude)")
                print("Latitude: \(location.coordinate.latitude)")
                print("Longitude: \(location.coordinate.longitude)")
            } else {
                print("Failed to get latitude and longitude.")
            }
            completion(locationString) // Call the completion handler with the updated locationString
        }
    }
    
    func startBackGroundTask() {
        self.backgroundTaskID = UIApplication.shared.beginBackgroundTask(withName: "CallObserver") {
            self.endBackGroundTask()
        }
    }
    
    func endBackGroundTask() {
        if self.backgroundTaskID != nil {
            UIApplication.shared.endBackgroundTask(self.backgroundTaskID!)
            self.backgroundTaskID = .invalid
        }
    }

    func makeCall(withPhoneNumber phoneNumber: String) {
        callObserver = CXCallObserver()
        callObserver?.setDelegate(self, queue: nil)
        if let url = URL(string: ("tel:" + phoneNumber)) {
            UIApplication.shared.open(url)
        }
    }
    
    private func speakMessage(message: String) {
        let speechUtterance = AVSpeechUtterance(string: message)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechUtterance.rate = 0.4
        
        self.synthesizer.speak(speechUtterance)
    }

    // MARK: CXProviderDelegate

    func providerDidReset(_ provider: CXProvider) {
        print("Provider did reset")
    }

    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        print("Call answered")
        action.fulfill()
    }

    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        print("Call ended")
        action.fulfill()
    }
}

enum CallType: String{
    case police = "Police"
    case fireDepartment = "Fire"
    case health = "health"
    case personal = "custom"
}
