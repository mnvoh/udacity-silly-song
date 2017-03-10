//
//  ViewController.swift
//  Silly Song
//
//  Created by Milad Nozari on 3/9/17.
//  Copyright © 2017 Nozary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    // MARK: - Properties
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"
    ].joined(separator: "\n")
    let fullNamePlaceHolder = "<FULL_NAME>"
    let shortNamePlaceHolder = "<SHORT_NAME>"
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
    }

    // MARK: - Private Functions
    private func lyricsFor(fullName: String, template: String) -> String {
        let shortName = shortNameFrom(name: fullName)
        
        let lyrics = template
            .replacingOccurrences(of: fullNamePlaceHolder, with: fullName)
            .replacingOccurrences(of: shortNamePlaceHolder, with: shortName)
        
        return lyrics
    }

    private func shortNameFrom(name: String) -> String {
        let vowels = "aeiou".characters
        
        // making the name lowercased and then gettings its
        // characters, fixed the issue where names with first vowel
        // letter would be truncated.
        let characters = name.lowercased().characters
    
        var firstVowelIndex = -1
        for (index, char) in characters.enumerated() {
            if vowels.contains(char) {
                firstVowelIndex = index
                break
            }
        }
        
        if firstVowelIndex < 0 {
            // vowel not found
            return name.lowercased()
        }
        
        return name.substring(from: name.index(name.startIndex, offsetBy: firstVowelIndex)).lowercased()
    }
    
    fileprivate func displayLyrics() {
        guard let fullName = nameField.text, fullName.characters.count > 0 else {
            return
        }
        
        lyricsView.text = lyricsFor(fullName: fullName, template: bananaFanaTemplate)
    }
    
    fileprivate func reset() {
        nameField.text = ""
        lyricsView.text = ""
    }
}

// MARK: - UITExtFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        displayLyrics()
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        reset()
    }
}

