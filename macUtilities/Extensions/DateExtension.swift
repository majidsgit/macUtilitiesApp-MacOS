//
//  DateExtension.swift
//  macUtilities
//
//  Created by Majid on 29/03/2023.
//

import Foundation

extension Date {
    
    enum AMPMStyle: String {
        case visible = "a"
        case none = ""
    }
    func getAMPM(by style: AMPMStyle) -> String {
        
        guard style != .none else { return "" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = style.rawValue
        
        return formatter.string(from: self)
        
    }
    
    enum TimeStyle: String {
        case twentyFour = "HH"
        case twelve = "hh"
    }
    func getTimeHour(by style: TimeStyle) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = style.rawValue
        
        return formatter.string(from: self)
    }
    
    func getTimeMinute() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        
        return formatter.string(from: self)
    }
    func getTimeSecond() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "ss"
        
        return formatter.string(from: self)
    }
    
    enum DateStyle: String {
        case full = "EEEE, MMM d, yyyy"
        case regular = "d MMMM yyyy"
    }
    
    func getDate(by style: DateStyle) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = style.rawValue
        
        return formatter.string(from: self)
    }
    
    func getDay() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        
        return formatter.string(from: self)
    }
    
    func getClockTime() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return formatter.string(from: self)
    }
    
}
