//TODO 16: Create an extension that adds functionality to an existing type

// Extending strings type -> to reverse the order of words in a sentence

extension String {
    func wordsReversed() -> String {
        return String(self.reversed())
           
    }
}

let phrase = "Hello Anukriti"
print(phrase.wordsReversed())


