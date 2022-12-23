//
//  ApplicationMenu.swift
//  MyFirstApp
//
//  Created by Parag Katoch on 23/12/22.
//

import Foundation
import SwiftUI

class ApplicationMenu: NSObject {
    let menu = NSMenu()
    
    func createMenu() -> NSMenu {
        let jokeView = JokeView()
        let topView = NSHostingController(rootView: jokeView)
        topView.view.frame.size = CGSize(width: 225, height: 225)
        
        let customMenuItem = NSMenuItem()
        customMenuItem.view = topView.view
        
        menu.addItem(customMenuItem)
        menu.addItem(NSMenuItem.separator())
        
//        About Menu Item
        let aboutMenuItem = NSMenuItem(title: "About MyFirstApp", action: #selector(about), keyEquivalent: "")
        aboutMenuItem.target = self
        menu.addItem(aboutMenuItem)
        
//        Website Menu Item
        let webLinkMenuItem = NSMenuItem(title: "Open paragkatoch", action: #selector(openLink), keyEquivalent: "")
        webLinkMenuItem.target = self
        webLinkMenuItem.representedObject = "https://paragkatoch.me"
        menu.addItem(webLinkMenuItem)
        
//        Website Menu Item
        let quitMenuItem = NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: "q")
        quitMenuItem.target = self
        menu.addItem(quitMenuItem)
        
        return menu
    }
    
    @objc func about(sender: NSMenuItem) {
        NSApp.orderFrontStandardAboutPanel()
    }
    
    @objc func openLink(sender: NSMenuItem) {
        let link = sender.representedObject as! String
        guard let url = URL(string: link) else { return }
        NSWorkspace.shared.open(url)
    }
    
    @objc func quit(sender: NSMenuItem) {
        NSApp.terminate(self)
    }
}
