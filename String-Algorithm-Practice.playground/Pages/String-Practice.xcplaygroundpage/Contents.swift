//: How to repeat a string
import Foundation
import UIKit


/* 
 overview    : How to repeat a string
 description : swift strings have a built-in initializer that lets you create string by repeating a string a certainnumber of times. To use it, just provide the string to repeat and a count as its two parameters 
*/

let str01 = String(repeating: "a", count: 5)

/*
 overview    : How to capitalize words in a string 
 description : Swift offers several ways of adjusting the letter case of string, but if you're looking for title case - that is, Text where the first letter of each string is uppercased.
 version : Swift 2.0 - capitalized, Swift 3.0 - uppercased() / lowercased()
 */

let str02 = "sunday, monday, happy days"
print(str02.uppercased())

/*
 overview : How to convert a string to lowercase letters
 */

let str03 = "Sunday, Monday, Happy Days"
print(str03.lowercased())

/*
 overview: How to reverse a string using reversed()
 */
let str04 = "Hello, world!"
let reversed = String(str04.characters.reversed())
print(reversed)

/* 
 overview: How to specify floating-point precision in a string
 description: swift's string interpolation
 */

let angle = 45.6789
let raw = "Angle: \(angle)" // %f format string means "a floating point number".
let formatted = String(format: "Angle: %.2f", angle) // a floating point number with two digits after decimal point.

/*
 overview : How to loop through letters in a string
 description : loop through every character in a string by using its characters property, which is an array containing each individual character inside a string.
 */

let str05 = "sunday, monday, happy days"
for char in str05.characters {
    print("Found Character: \(char)")
}

/*
 overview : How to split a string into an an array: components(seperatedBy:)
 description : split a string up by a comman and space by converting a string to an array.
 Bug: It's a bug on the swift playgrounds, iPad. On the mac, it's ok. 
 

 let str06 = "Andrew, Ben, John, Paul, Peter, Laura"
 let name = str06.components(seperatedBy: ", ") 
 */

/*
 overview: How to trim whitespace in a string
 description: Use trimmingCharacters(in: ) method by providing a list of the characters you want to trim. If you're just using whitespace (tabs, spaces, and new lines), you can use the predefined whitespacesAndNewLines list of characters. 
 */

let str07 = " Jinho Seo "
let trimmed = str07.trimmingCharacters(in: .whitespacesAndNewlines)

/*
 overview: Replace text in a string
 */

let str08 = "Swift 3.0 is Taylor Swift"
let replaced = str08.replacingOccurrences(of: "is", with: "isn't")
print(replaced)

/*
 overview : check a character
 description : pattern-match multiple values of strings or characters and to respond accordingly. 
 */

let someCharacter: Character = "e"

switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel.")
default:
    print("\(someCharacter) is not a vowel.")
}

/*
 overview    : how to check or find a special character using contains() 
 description : Indicates whether or not the substring was found. It didn't check duplication and specific characters. 
 */

let greeting = "Hi Yoonjin, my name is Jinho."
if greeting.contains("my name is") {
    print("Making an introduction")
}




/* 
 overview: 
 description:
 */
/*
if let path = Bundle.main.path(forResource: "example", ofType: "txt") {
    do {
        let contents = try String(contentsOfFile: path)
        let lines = contents.components(seperatedBy: "\n")
        for line in lines {
            print(line)
        }
        
    } catch {
        print("content could not be loaded.")
    }
} else {
    print("example.txt is not found.")
 }
 */

/*
 overview: How to load a string from a website URL
 description : It takes just a few lines of Swift code to load the contents of a website URl, but there are three things you need to be careful with.
 1. Creating a URL might fall if you pass a bad site, so you need to unwrap its optional return value.
 2. Loading a URL's contains might fail because the site might be down, so it might throw an error. This means you need to wrap the call into a do/catch block.
 3. Accessing network data is slow, so you really want to do this on a background thread.
 */

if let url = URL(string: "https://www.hackingwithswift.com") {
    do {
        let contents = try String(contentsOf: url)
        print(contents)
    } catch {
        print("contents could not be loaded.")
    }
} else {
    print("the URL was bad!")
}


/*
 overview : How to show specific letters in a string
 version : substringWithRange() -> substring(with: )
 */
let s = "hello, world"
let b = (s as NSString).substring(with: NSRange(location:2, length:5))

let options = NSLinguisticTagger.Options.omitWhitespace.rawValue | NSLinguisticTagger.Options.joinNames.rawValue
let tagger = NSLinguisticTagger(tagSchemes: NSLinguisticTagger.availableTagSchemes(forLanguage: "en"), options: Int(options))

/*
 overview    : How to parse a sentence using NSLinguisticTagger
 description : It automatically recognizes English workds and tells you what kind of word it is. This class distiguishes between verbs, nouns, adjectives and so on. ex) do I (verb) this (noun)?
 */

let inputString = "This is a very long sentence for you to try"
tagger.string = inputString

// When you loop through the matches found by an NSLinguisticTagger, you get back an NSRange describing where in the string each item was found.
let range = NSRange(location: 0, length: inputString.utf16.count)
tagger.enumerateTags(in: range, scheme: NSLinguisticTagSchemeNameTypeOrLexicalClass, options: NSLinguisticTagger.Options(rawValue: options)) { tag, tokenRange, sentenceRange, stop in 
    // swift is to use string indexes, so cast the Swift to an NSString.
    let token = (inputString as NSString).substring(with: tokenRange)
    print("\(tag): \(token)")
}

 





