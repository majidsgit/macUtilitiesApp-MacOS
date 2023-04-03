//
//  AppDelegate.swift
//  macUtilities
//
//  Created by Majid on 29/03/2023.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem = NSStatusItem()
    let fonts = ["Varsity", "Sketch3D", "SketchCollege", "FineCollege"]
    
    @AppStorage("selectedFontName") var selectedFontName = "Varsity"
    @AppStorage("isShowingInDock") var isShowingInDock: Bool = false
    
    func setupStatusItem() {
        let menu = NSMenu()
        let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        statusItem.menu = menu
        self.statusItem = statusItem
    }
    
    func setupStatusItemView() {
        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else { return }
        let statusItem = appDelegate.statusItem
        if let image = NSImage(named: "StatusItemIcon") {
            let imageView = NSImageView(image: image)
            imageView.frame = statusItem.button?.frame ?? .zero
            statusItem.button?.addSubview(imageView)
        }
    }
    
    func createMenuItem(title: String, systemSymbolName: String?, action: Selector?) -> NSMenuItem {
        let menuItem = NSMenuItem(title: title, action: action, keyEquivalent: "")
        if let systemSymbolName {
            menuItem.image = NSImage(systemSymbolName: systemSymbolName, accessibilityDescription: nil)
        }
        return menuItem
    }
    
    func createMenuItems() {
        guard let menu = statusItem.menu else { return }
        let menuHeader = createMenuItem(title: "Fonts", systemSymbolName: nil, action: nil)
        let menuHeaderImage = NSImage(systemSymbolName: "textformat.abc.dottedunderline", accessibilityDescription: nil)
        menuHeader.onStateImage = menuHeaderImage
        menuHeader.offStateImage = menuHeaderImage
        menu.addItem(menuHeader)
        
        for font in fonts {
            let item = createMenuItem(title: font, systemSymbolName: nil, action: #selector(menuItemFontDidSelect))
            item.onStateImage = NSImage(systemSymbolName: "checkmark", accessibilityDescription: nil)
            item.offStateImage = NSImage()
            item.state = selectedFontName == font ? .on : .off
            menu.addItem(item)
        }
        
        menu.addItem(.separator())
        
        let showDock = createMenuItem(title: "\(isShowingInDock ? "show in" : "hide from") dock", systemSymbolName: nil, action: #selector(menuItemDockVisibilityDidChange))
        let showDockImage = NSImage(systemSymbolName: "dock.rectangle", accessibilityDescription: nil)
        showDock.onStateImage = showDockImage
        showDock.offStateImage = showDockImage
        menu.addItem(showDock)
    }
    
    @objc func menuItemDockVisibilityDidChange() {
        isShowingInDock = !isShowingInDock
        NSApplication.shared.setActivationPolicy(isShowingInDock ? .accessory : .regular)
        guard let menu = statusItem.menu else { return }
        if let showDockMenuItem = menu.items.last {
            showDockMenuItem.title = "\(isShowingInDock ? "show in" : "hide from") dock"
        }
    }
    
    @objc func menuItemFontDidSelect(_ item: NSMenuItem) {
        guard let menu = statusItem.menu else { return }
        if let newSelectedFont = menu.items.first(where: { $0.title == item.title }) {
            newSelectedFont.state = .on
        }
        if let oldSelectedFont = menu.items.first(where: { $0.title == selectedFontName }),
           selectedFontName != item.title {
            oldSelectedFont.state = .off
            oldSelectedFont.image = NSImage()
        }
        if selectedFontName != item.title {
            selectedFontName = item.title
            NotificationCenter.default.post(Notification(name: .FontDidChanged, object: item.title))
        }
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        setupStatusItem()
        setupStatusItemView()
        createMenuItems()
        menuItemDockVisibilityDidChange()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

