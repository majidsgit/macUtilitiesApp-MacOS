//
//  WindowControllerFunctions.swift
//  macUtilities
//
//  Created by Majid on 29/03/2023.
//

import Cocoa

extension WindowController {
    
    @objc func onFontChanged() {
        selectedFontName = fontSelector.selectedItem?.title ?? ""
        // update respected labels' font
        hourLabel.font = NSFont(name: selectedFontName, size: 68)
        firstDotLabel.font = NSFont(name: selectedFontName, size: 58)
        minuteLabel.font = NSFont(name: selectedFontName, size: 68)
        secondDotLabel.font = NSFont(name: selectedFontName, size: 58)
        secondLabel.font = NSFont(name: selectedFontName, size: 68)
    }
    
    @objc func updateTime() {
        
        DispatchQueue.main.async { [weak self] in
            guard let timeStyle = self?.timeStyle, let ampmStyle = self?.ampmStyle, let dateStyle = self?.dateStyle else { return }
            
            self?.ampmStyle = timeStyle == .twelve ? .visible : .none
            self?.ampmLabel.isHidden = ampmStyle == .none
            self?.ampmLabel.stringValue = Date.now.getAMPM(by: ampmStyle)
            
            self?.hourLabel.stringValue = Date.now.getTimeHour(by: timeStyle)
            self?.minuteLabel.stringValue = Date.now.getTimeMinute()
            self?.secondLabel.stringValue = Date.now.getTimeSecond()
            
            self?.dateLabel.stringValue = Date.now.getDate(by: dateStyle)
            if dateStyle == .regular {
                self?.titleLabel.stringValue = Date.now.getDay()
            } else if let titleContent = self?.getTitleContent(for: Date.now) {
                self?.titleLabel.stringValue = titleContent
            }
        }
    }
    
    @objc func onTimeFormatDidChange() {
        
        timeStyle = timeSegmentedButton.selectedSegment == 0 ? .twentyFour : .twelve
    }
    
    @objc func onDateFormatDidChange() {
        
        dateStyle = dateSegmentedButton.selectedSegment == 0 ? .full : .regular
    }
    
    @objc func onLockViewStateDidChange() {
        let isLock = lockSegmentedButton.selectedSegment == 0
        mainWindow.isMovable = lockSegmentedButton.selectedSegment != 0
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 1.0
            self.fontSelector.animator().alphaValue = isLock ? 0.0 : 1.0
            self.timeSegmentedButton.animator().alphaValue = isLock ? 0.0 : 1.0
            self.dateSegmentedButton.animator().alphaValue = isLock ? 0.0 : 1.0
        } completionHandler: { [weak self] in
            self?.fontSelector.isHidden = isLock
            self?.timeSegmentedButton.isHidden = isLock
            self?.dateSegmentedButton.isHidden = isLock
        }
    }
    
    
    func getTitleContent(for date: Date) -> String {
        // get from user daily schedule
        let timeMinutes = date.getClockTime().getMinutesNumber()
        let current = dailyJSON.first { item in
            guard let startTime = (item["start"])?.getMinutesNumber() else { return false }
            guard let endTime = (item["end"])?.getMinutesNumber() else { return false }
            
            return timeMinutes >= startTime && timeMinutes < endTime
        }
        return current?["title"] ?? Date.now.getDay()
    }
}
