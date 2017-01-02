//
//  ViewController.swift
//  Silly Song
//
//  Created by Ashley Donohoe on 1/1/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }

    @IBAction func displayLyrics(_ sender: Any) {
        let fullName = nameField.text
        let song = customizeTemplate(name: fullName!, template: bananaFanaTemplate)
        lyricsView.text = song
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

// Functions for generating short name and making template get filled in
func customizeTemplate(name:String, template:String) -> String {
    
    // Make shortened name
    let shortenedName = shortNameFromName(name: name)
    let customizedSong:String = template.replacingOccurrences(of: "<FULL_NAME>", with: name).replacingOccurrences(of: "<SHORT_NAME>", with: shortenedName)
    
    // Return the customized template
    return customizedSong
    
}

func shortNameFromName(name: String) -> String {
    
    // Make name all lowercased
    var shortenedName = name.lowercased().folding(options: .diacriticInsensitive, locale: .current)
    
    let vowels:[Character] = ["a", "e", "i", "o", "u"]
    
    if shortenedName.isEmpty {
        return ""
    }
    
    // Checks if name has a vowel, since otherwise the name should stay as-is
    var containsVowel:Bool = false
    
    for letter in shortenedName.characters {
        if vowels.contains(letter) {
            containsVowel = true
            break
        }
    }
    
    // If name has a consonant as first character, keep removing the first letter until the first vowel
    if containsVowel {
        while !vowels.contains(shortenedName.characters.first!) {
            shortenedName.remove(at: shortenedName.startIndex)
        }
    }
    
    // Return name original or updated, depending on above conditions
    return shortenedName
}


