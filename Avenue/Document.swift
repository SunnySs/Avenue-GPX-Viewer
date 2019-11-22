//
//  Document.swift
//  Avenue
//
//  Created by Vincent on 7/7/19.
//  Copyright © 2019 Vincent. All rights reserved.
//

import Cocoa
import CoreGPX

class Document: NSDocument {
    
    var gpx = GPXRoot()

    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    override class var autosavesInPlace: Bool {
        return true
    }

    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("Document Window Controller")) as! WindowController
        
        if let fileName = self.fileURL?.lastPathComponent {
            let systemRegular = [ NSAttributedString.Key.font: NSFont.systemFont(ofSize: 15, weight: .light) ]
            let systemSemibold = [ NSAttributedString.Key.font: NSFont.systemFont(ofSize: 18, weight: .semibold) ]
            let title = NSMutableAttributedString(string: fileName/*"Avenue: \(fileName)"*/, attributes: systemRegular)
            //title.addAttributes(systemSemibold, range: NSMakeRange(0, 7))
            
            //windowController.barTitle.stringValue = "Avenue - \(title)"
            windowController.barTitle.attributedStringValue = title
        }
        windowController.barTitle.isHidden = false
        self.addWindowController(windowController)
        
        let viewController = windowController.contentViewController as! ViewController
        viewController.mapView.loadedGPXFile(gpx)
    }

    override func data(ofType typeName: String) throws -> Data {
        // Insert code here to write your document to data of the specified type, throwing an error in case of failure.
        // Alternatively, you could remove this method and override fileWrapper(ofType:), write(to:ofType:), or write(to:ofType:for:originalContentsURL:) instead.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

    override func read(from data: Data, ofType typeName: String) throws {
        // Insert code here to read your document from the given data of the specified type, throwing an error in case of failure.
        // Alternatively, you could remove this method and override read(from:ofType:) instead.
        // If you do, you should also override isEntireFileLoaded to return false if the contents are lazily loaded.
        let fileGPX = GPXParser(withData: data).parsedData()
        
        
        if fileGPX.tracks.count != 0 || fileGPX.waypoints.count != 0 {
            self.gpx = fileGPX
        }
        else {
            throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        }
        
    }


}

