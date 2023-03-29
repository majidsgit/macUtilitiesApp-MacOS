//
//  WindowController.swift
//  macUtilities
//
//  Created by Majid on 29/03/2023.
//

import Cocoa

class WindowController: NSWindowController {

    @IBOutlet weak var mainWindow: NSWindow!
    
    var selectedFontName = "Varsity"
    var fontNames = ["FineCollege", "Sketch3D", "SketchCollege", "Varsity"]
    
    var mainView: NSVisualEffectView?
    
    var fontSelector = NSPopUpButton(frame: .zero)
    
    var titleLabel = NSTextField(frame: .zero)
    var lockSegmentedButton = NSSegmentedControl(frame: .zero)
    
    var timeStyle = Date.TimeStyle.twelve
    var timeSegmentedButton = NSSegmentedControl(frame: .zero)
    var secondLabel = NSTextField(frame: .zero)
    var secondDotLabel = NSTextField(frame: .zero)
    var minuteLabel = NSTextField(frame: .zero)
    var firstDotLabel = NSTextField(frame: .zero)
    var hourLabel = NSTextField(frame: .zero)
    
    var ampmStyle = Date.AMPMStyle.visible
    var ampmLabel = NSTextField(frame: .zero)
    
    var dateStyle = Date.DateStyle.full
    var dateSegmentedButton = NSSegmentedControl(frame: .zero)
    var dateLabel = NSTextField(frame: .zero)
    
    var timer: Timer?
    var screenVisibilityTimer: Timer?
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        let windowFrame = mainWindow.frame
        
        let effect = NSVisualEffectView(frame: NSRect(x: 0, y: 0, width: windowFrame.width, height: windowFrame.height))
        effect.blendingMode = .behindWindow
        effect.state = .active
        effect.wantsLayer = true
        effect.layer?.cornerRadius = 11.0
        mainWindow.contentView = effect
        mainWindow.titlebarAppearsTransparent = true
        mainWindow.titleVisibility = .hidden
        mainWindow.isOpaque = false
        mainWindow.backgroundColor = .clear
        
        self.mainView = effect
        
        setupHover()
        
        setupTopAndBottomViews()
        setupMainViews()
        setupButtons()
        
        setupTimer()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    func setupHover() {
        NSEvent.addLocalMonitorForEvents(matching: .mouseEntered, handler: mouseDidEnter(by:))
        NSEvent.addLocalMonitorForEvents(matching: .mouseExited, handler: mouseDidExit(by:))
    }
    
    func mouseDidEnter(by event: NSEvent) -> NSEvent {
        
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 1.0
            self.lockSegmentedButton.animator().alphaValue = 1.0
            if self.lockSegmentedButton.selectedSegment != 0 {
                self.fontSelector.animator().alphaValue = 1.0
                self.timeSegmentedButton.animator().alphaValue = 1.0
                self.dateSegmentedButton.animator().alphaValue = 1.0
            }
        }
        return event
    }
    
    func mouseDidExit(by event: NSEvent) -> NSEvent {
        
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 1.0
            self.lockSegmentedButton.animator().alphaValue = 0.0
            if self.lockSegmentedButton.selectedSegment != 0 {
                self.fontSelector.animator().alphaValue = 0.0
                self.timeSegmentedButton.animator().alphaValue = 0.0
                self.dateSegmentedButton.animator().alphaValue = 0.0
            }
        }
        return event
    }
    
    func setupButtons() {
        guard let mainView else { return }
        
        fontSelector = createFontSelector()
        fontSelector.action = #selector(onFontChanged)
        selectedFontName = fontNames.first!
        
        lockSegmentedButton = createLockSegmentedButton()
        lockSegmentedButton.action = #selector(onLockViewStateDidChange)
        
        timeSegmentedButton = createTimeFormatButton()
        timeSegmentedButton.action = #selector(onTimeFormatDidChange)
        timeSegmentedButton.selectedSegment = 0
        onTimeFormatDidChange()
        
        dateSegmentedButton = createDateFormatButton()
        dateSegmentedButton.action = #selector(onDateFormatDidChange)
        
        mainView.addSubview(fontSelector)
        mainView.addSubview(lockSegmentedButton)
        mainView.addSubview(timeSegmentedButton)
        mainView.addSubview(dateSegmentedButton)
        
        NSLayoutConstraint.activate([
            fontSelector.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            fontSelector.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            lockSegmentedButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            lockSegmentedButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20),
            
            timeSegmentedButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            timeSegmentedButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            dateSegmentedButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            dateSegmentedButton.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor)
        ])
        
    }
    
    func setupTopAndBottomViews() {
        
        guard let mainView else { return }
        
        titleLabel = createTitleLabel()
        
        dateLabel = createDateLabel()
        
        mainView.addSubview(titleLabel)
        mainView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 18),
            titleLabel.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.63),
            dateLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20)
        ])
        
    }
    
    func setupMainViews() {
        
        guard let mainView else { return }
        
        let stack = NSStackView(frame: .zero)
        stack.alignment = .centerX
        stack.orientation = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 0
        
        hourLabel = createTimeLabel()
        firstDotLabel = createDotLabel()
        minuteLabel = createTimeLabel()
        secondDotLabel = createDotLabel()
        secondLabel = createTimeLabel()
        
        ampmLabel = createAMPMLabel()
        
        stack.addArrangedSubview(hourLabel)
        stack.addArrangedSubview(firstDotLabel)
        stack.addArrangedSubview(minuteLabel)
        stack.addArrangedSubview(secondDotLabel)
        stack.addArrangedSubview(secondLabel)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(stack)
        
        mainView.addSubview(ampmLabel)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            ampmLabel.centerYAnchor.constraint(equalTo: stack.centerYAnchor),
            ampmLabel.leadingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 4)
        ])
    }
    
    func setupTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(0.1), target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        self.timer?.fire()
    }
}
