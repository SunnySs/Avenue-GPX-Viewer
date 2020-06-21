//
//  WindowController.swift
//  Avenue
//
//  Created by Vincent on 8/7/19.
//  Copyright © 2019 Vincent. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    
    @IBOutlet weak var barTitle: NSTextField!
    @IBOutlet weak var barDistance: NSTextField!
    
    
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.titleVisibility = .hidden
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        barTitle.stringValue = "Avenue"
        barTitle.isHidden = true
        
        if #available(OSX 10.12, *) {
            window?.tabbingMode = .preferred
        }
        window?.minSize = NSSize(width: 510, height: 280)
    }
    
}
