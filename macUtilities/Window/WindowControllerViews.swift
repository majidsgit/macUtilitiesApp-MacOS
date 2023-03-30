//
//  WindowControllerViews.swift
//  macUtilities
//
//  Created by Majid on 29/03/2023.
//

import Cocoa

extension WindowController {
    
    func createFontSelector() -> NSPopUpButton {
        let button = NSPopUpButton(frame: .zero)
        
        button.bezelColor = .clear
        button.contentTintColor = .clear
        
        button.addItems(withTitles: fontNames)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    func createTimeLabel() -> NSTextField {
        let label = NSTextField(frame: .zero)
        
        label.stringValue = "--"
        label.isEditable = false
        label.isSelectable = false
        label.isBordered = false
        label.backgroundColor = .clear
        label.font = NSFont(name: selectedFontName , size: 68)
        label.textColor = NSColor.textColor
        label.alignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 100),
            label.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        return label
    }
    
    func createDotLabel() -> NSTextField {
        let label = NSTextField(frame: .zero)
        
        label.stringValue = ":"
        label.isEditable = false
        label.isSelectable = false
        label.isBordered = false
        label.backgroundColor = .clear
        label.font = NSFont(name: selectedFontName , size: 58)
        label.textColor = NSColor.textColor
        label.alignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    func createAMPMLabel() -> NSTextField {
        let label = NSTextField(frame: .zero)
        
        label.stringValue = "--"
        label.isEditable = false
        label.isSelectable = false
        label.isBordered = false
        label.backgroundColor = .clear
        label.font = NSFont.poppinsSemiBold
        label.textColor = NSColor.textColor
        label.alphaValue = 0.5
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 40),
            label.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        return label
    }
    
    func createDateLabel() -> NSTextField {
        let label = NSTextField(frame: .zero)
        
        label.stringValue = "----, ---, -, ----"
        label.isEditable = false
        label.isSelectable = false
        label.isBordered = false
        label.backgroundColor = .clear
        label.font = NSFont.poppinsThin
        label.textColor = NSColor.textColor
        label.alphaValue = 0.6
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    func createTitleLabel() -> NSTextField {
        
        let label = NSTextField(frame: .zero)
        
        label.stringValue = "..."
        label.isEditable = false
        label.isSelectable = false
        label.isBordered = false
        label.backgroundColor = .clear
//        label.font = NSFont.systemFont(ofSize: 28, weight: .thin)
//        label.font = NSFont.systemFont(ofSize: 18, weight: .regular)
        label.font = NSFont.poppinsSemiBold
        label.textColor = NSColor.textColor
        label.alphaValue = 0.8
        label.alignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    func createDateFormatButton() -> NSSegmentedControl {
        let button = NSSegmentedControl(frame: .zero)
        
        button.segmentCount = 2
        button.segmentStyle = .capsule
        button.segmentDistribution = .fillEqually
        button.selectedSegment = 0
        button.selectedSegmentBezelColor = .clear
        
        let full = NSImage(systemSymbolName: "timer.circle.fill", accessibilityDescription: nil)
        let regular = NSImage(systemSymbolName: "timer.circle", accessibilityDescription: nil)
        button.setImage(full, forSegment: 0)
        button.setImage(regular, forSegment: 1)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    func createTimeFormatButton() -> NSSegmentedControl {
        let button = NSSegmentedControl(frame: .zero)
        
        button.segmentCount = 2
        button.segmentStyle = .capsule
        button.segmentDistribution = .fillEqually
        button.selectedSegment = 1
        button.selectedSegmentBezelColor = .clear
        
        let twentyFour = NSImage(systemSymbolName: "24.square.fill", accessibilityDescription: nil)
        let twelve = NSImage(systemSymbolName: "12.square", accessibilityDescription: nil)
        button.setImage(twentyFour, forSegment: 0)
        button.setImage(twelve, forSegment: 1)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    func createLockSegmentedButton() -> NSSegmentedControl {
        let button = NSSegmentedControl(frame: .zero)
        
        button.segmentCount = 2
        button.segmentStyle = .capsule
        button.segmentDistribution = .fillEqually
        button.selectedSegment = 1
        button.selectedSegmentBezelColor = .clear
        
        let lock = NSImage(systemSymbolName: "lock.fill", accessibilityDescription: nil)
        let unlock = NSImage(systemSymbolName: "lock.open", accessibilityDescription: nil)
        button.setImage(lock, forSegment: 0)
        button.setImage(unlock, forSegment: 1)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
}
