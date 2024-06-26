//
//  OptionViewController.swift
//  iSstp
//
//  Created by Zheng Shao on 8/15/15.
//  Copyright (c) 2015 axot. All rights reserved.
//

import Cocoa
import AppKit
import Foundation
fileprivate func < <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

class OptionViewController: NSViewController, NSTableViewDelegate {
    var account: Account?
    var superViewController: ViewController?

    @IBOutlet var commandsTextView: NSTextView!
    @IBOutlet weak var optionText: NSTextField!
    @IBOutlet weak var doesSkipCertWarn: NSButton!

    override func viewWillAppear() {
        preferredContentSize = self.view.frame.size
        optionText.stringValue = account!.option!
        if let commands = account?.commands {
            commandsTextView.string = commands
        }

        if (account?.doesSkipCertWarn?.count > 0) {
            doesSkipCertWarn.state = NSControl.StateValue.on
        } else {
            doesSkipCertWarn.state = NSControl.StateValue.off
        }
    }

    @IBAction func saveBtnPressed(_ sender: AnyObject) {
        account?.option = optionText.stringValue
        account?.commands = commandsTextView.textStorage?.string

        if (doesSkipCertWarn.state == NSControl.StateValue.off) {
            account?.doesSkipCertWarn = ""
        } else {
            account?.doesSkipCertWarn = account!.doesSkipCertWarnDefault
        }

        superViewController!.saveConfig(self)
        dismiss(self)
    }

    @IBAction func resetBtnPressed(_ sender: AnyObject) {
        optionText.stringValue = account!.defaultOption
        commandsTextView.string = ""
        doesSkipCertWarn.state = NSControl.StateValue.on
    }
}
