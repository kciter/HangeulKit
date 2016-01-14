
import Foundation

public class HangeulKit {
    
    private static let chosung: [Character] = [
        "ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ",
        "ㅅ", "ㅆ", "ㅇ" , "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
    ]
    
    private static let jungsung: [Character] = [
        "ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ",
        "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ",
        "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ",
        "ㅡ", "ㅢ", "ㅣ"
    ]
    
    private static let jongsung: [Character] = [
        " ", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ",
        "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ",
        "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ",
        "ㅋ", "ㅌ", "ㅍ", "ㅎ"
    ]
    
    private static let chosungToQwerty: [Character:String] = [
        "ㄱ": "r", "ㄲ": "rr", "ㄴ": "s", "ㄷ": "e", "ㄸ": "ee", "ㄹ": "f", "ㅁ": "a", "ㅂ": "q", "ㅃ": "qq",
        "ㅅ": "t", "ㅆ": "tt", "ㅇ": "d" , "ㅈ": "w", "ㅉ": "ww", "ㅊ": "c", "ㅋ": "z", "ㅌ": "x", "ㅍ": "v", "ㅎ": "g"
    ]
    
    private static let jungsungToQwerty: [Character:String] = [
        "ㅏ": "k", "ㅐ": "o", "ㅑ": "i", "ㅒ": "O", "ㅓ": "j", "ㅔ": "p",
        "ㅕ": "u", "ㅖ": "P", "ㅗ": "h", "ㅘ": "hk", "ㅙ": "ho", "ㅚ": "hl",
        "ㅛ": "y", "ㅜ": "n", "ㅝ": "nj", "ㅞ": "np", "ㅟ": "nl", "ㅠ": "b",
        "ㅡ": "m", "ㅢ": "ml", "ㅣ": "l"
    ]
    
    private static let jongsungToQwerty: [Character:String] = [
        "ㄱ": "r", "ㄲ": "rr", "ㄳ": "rt", "ㄴ": "s", "ㄵ": "sw", "ㄶ": "sg", "ㄷ": "e",
        "ㄹ": "f", "ㄺ": "fr", "ㄻ": "fa", "ㄼ": "fq", "ㄽ": "ft", "ㄾ": "fx", "ㄿ": "fv", "ㅀ": "fg",
        "ㅁ": "a", "ㅂ": "q", "ㅄ": "qt", "ㅅ": "t", "ㅆ": "tt", "ㅇ":" d", "ㅈ": "w", "ㅊ": "c",
        "ㅋ": "z", "ㅌ": "x", "ㅍ": "v", "ㅎ": "g"
    ]
    
    private static let qwertyToHangeul: [UnicodeScalar:Character] = [
        "q": "ㅂ", "w": "ㅈ", "e": "ㄷ", "r": "ㄱ", "t": "ㅅ",
        "y": "ㅛ", "u": "ㅕ", "i": "ㅑ", "o": "ㅐ", "p": "ㅔ",
        "a": "ㅁ", "s": "ㄴ", "d": "ㅇ", "f": "ㄹ", "g": "ㅎ",
        "h": "ㅗ", "j": "ㅓ", "k": "ㅏ", "l": "ㅣ", "z": "ㅋ",
        "x": "ㅌ", "c": "ㅊ", "v": "ㅍ", "b": "ㅠ", "n": "ㅜ",
        "m": "ㅡ", "Q": "ㅃ", "W": "ㅉ", "E": "ㄸ", "R": "ㄲ",
        "T": "ㅆ", "O": "ㅒ", "P": "ㅖ"
    ]
    
    public class func devide(text: String) -> String {
        var jasoText = ""
        for unicodeScalar in text.unicodeScalars {
            let value = Int(unicodeScalar.value)
            if isSyllable(unicodeScalar) == false {
                jasoText.append(unicodeScalar)
                continue
            }
            let hangeulValue = value - 0xAC00
            let jongsungIndex = hangeulValue % 28
            let jungsungIndex = ((hangeulValue - jongsungIndex)/28)%21
            let chosungIndex = (((hangeulValue - jongsungIndex)/28)-jungsungIndex)/21
            
            jasoText.append(chosung[chosungIndex])
            jasoText.append(jungsung[jungsungIndex])
            if jongsungIndex != 0 {
                jasoText.append(jongsung[jongsungIndex])
            }
        }
        
        return jasoText
    }
    
    public class func fetchChosungs(text: String) -> String {
        var chosungText = ""
        for unicodeScalar in text.unicodeScalars {
            if isChosung(unicodeScalar) {
                chosungText.append(unicodeScalar)
            } else if isSyllable(unicodeScalar) {
                let value = Int(unicodeScalar.value)
                let hangeulValue = value - 0xAC00
                let jongsungIndex = hangeulValue % 28
                let jungsungIndex = ((hangeulValue - jongsungIndex)/28)%21
                let chosungIndex = (((hangeulValue - jongsungIndex)/28)-jungsungIndex)/21
                chosungText.append(chosung[chosungIndex])
            }
        }
        
        return chosungText
    }
    
    public class func fetchJungsungs(text: String) -> String {
        var jungsungText = ""
        for unicodeScalar in text.unicodeScalars {
            if isJungsung(unicodeScalar) {
                jungsungText.append(unicodeScalar)
            } else if isSyllable(unicodeScalar) {
                let value = Int(unicodeScalar.value)
                let hangeulValue = value - 0xAC00
                let jongsungIndex = hangeulValue % 28
                let jungsungIndex = ((hangeulValue - jongsungIndex)/28)%21
                jungsungText.append(jungsung[jungsungIndex])
            }
        }
        
        return jungsungText
    }
    
    public class func fetchJongsungs(text: String) -> String {
        var jongsungText = ""
        for unicodeScalar in text.unicodeScalars {
            if isJongsung(unicodeScalar) == true {
                jongsungText.append(unicodeScalar)
            } else if isSyllable(unicodeScalar) {
                let value = Int(unicodeScalar.value)
                let hangeulValue = value - 0xAC00
                let jongsungIndex = hangeulValue % 28
                if jongsungIndex != 0 {
                    jongsungText.append(jongsung[jongsungIndex])
                }
            }
        }
        
        return jongsungText
    }
    
    public class func fetchSyllable(text: String) -> String {
        var hangeulText = ""
        for unicodeScalar in text.unicodeScalars {
            if isSyllable(unicodeScalar) == true {
                hangeulText.append(unicodeScalar)
            }
        }
        
        return hangeulText
    }
    
    public class func fetchHangeul(text: String) -> String {
        var hangeulText = ""
        for unicodeScalar in text.unicodeScalars {
            if isSyllable(unicodeScalar) || isChosung(unicodeScalar) || isJungsung(unicodeScalar) || isJongsung(unicodeScalar) {
                hangeulText.append(unicodeScalar)
            }
        }
        
        return hangeulText
    }
    
    public class func isComplete(text: String) -> Bool {
        let removeSpaceText = text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).stringByReplacingOccurrencesOfString(" ", withString: "")
        for character in removeSpaceText.unicodeScalars {
            let value = Int(character.value)
            if (0x1100 < value && value < 0x11FF) || (0x3130 < value && value < 0x318F) || (0xA960 < value && value < 0xA97F) || (0xD7B0 < value && value < 0xD7FF) {
                return false
            }
        }
        
        return true
    }
    
    public class func isOnlyHangeul(text: String) -> Bool {
        let removeSpaceText = text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).stringByReplacingOccurrencesOfString(" ", withString: "")
        for character in removeSpaceText.unicodeScalars {
            let value = Int(character.value)
            if (value < 0xAC00 || 0xD7AF < value) && (value < 0x1100 || 0x11FF < value) && (value < 0x3130 || 0x318F < value) && (value < 0xA960 || 0xA97F < value) && (value < 0xD7B0 || 0xD7FF < value) {
                return false
            }
        }
        
        return true
    }
    
    public class func toQwerty(text: String) -> String {
        let jasoText = self.devide(text)
        var qwertyText = ""
        
        for character in jasoText.characters {
            if let qwertyString = chosungToQwerty[character] {
                qwertyText.appendContentsOf(qwertyString)
            } else if let qwertyString = jungsungToQwerty[character] {
                qwertyText.appendContentsOf(qwertyString)
            } else if let qwertyString = jongsungToQwerty[character] {
                qwertyText.appendContentsOf(qwertyString)
            } else {
                qwertyText.append(character)
            }
        }
        
        return qwertyText
    }
    
    public class func toHangeul(text: String) -> String {
        var jasoText = ""
        
        for character in text.unicodeScalars {
            var value = Int(character.value)
            if value != 81 && value != 87 && value != 69 && value != 82 && value != 84 && 65 <= value && value <= 90 {
                value += 32
            }
            
            if let hangeul = qwertyToHangeul[UnicodeScalar.init(value)] {
                jasoText.append(hangeul)
            } else {
                jasoText.append(character)
            }
        }
        
        return jasoText
    }
    
    public class func combine(text: String) -> String {
        var combineText = ""
        for unicodeScalar in text.unicodeScalars {
//            let chosungIndex = (chosung.indexOf(character) != nil) ? chosung.indexOf(character)! : 0
//            let jungsungIndex = (jungsung.indexOf(character) != nil) ? jungsung.indexOf(character)! : 0
//            let jongsungIndex = (jongsung.indexOf(character) != nil) ? jongsung.indexOf(character)! : 0
//            combineText.append(UnicodeScalar.init(0xAC00 + (chosungIndex * 21 + jungsungIndex) * 28 + jongsungIndex))
        }
        
        return combineText
    }
    
    //TODO: Levenshtein Distance
    //1. 한글 먼저
    //2. 한글 -> 영문 변환 후
    //3. 둘의 평균값?
    
    private class func isChosung(unicodeScalar: UnicodeScalar) -> Bool {
        let value = unicodeScalar.value
        return (value >= 0x1100 && value <= 0x115F) || (value >= 0xA960 && value <= 0xA97C)
    }
    
    private class func isJungsung(unicodeScalar: UnicodeScalar) -> Bool {
        let value = unicodeScalar.value
        return (value >= 0x1160 && value <= 0x11A7) || (value >= 0xD7B0 && value <= 0xD7C6)
    }
    
    private class func isJongsung(unicodeScalar: UnicodeScalar) -> Bool {
        let value = unicodeScalar.value
        return (value >= 0x11A8 && value <= 0x11FF) || (value >= 0xD7CB && value <= 0xD7FB)
    }
    
    private class func isSyllable(unicodeScalar: UnicodeScalar) -> Bool {
        let value = unicodeScalar.value
        return (value >= 0xAC00 && value <= 0xD7AF)
    }
    
    private class func chosungCompress(left: UnicodeScalar, right: UnicodeScalar) -> UnicodeScalar? {
        if left == "ㄱ" && right == "ㄱ" {
            return "ㄲ"
        } else if left == "ㄷ" && right == "ㄷ" {
            return "ㄸ"
        } else if left == "ㅂ" && right == "ㅂ" {
            return "ㅃ"
        } else if left == "ㅅ" && right == "ㅅ" {
            return "ㅆ"
        } else if left == "ㅈ" && right == "ㅈ" {
            return "ㅉ"
        }
        
        return nil
    }
    
    private class func jungsungCompress(left: UnicodeScalar, right: UnicodeScalar) -> UnicodeScalar? {
//        "ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ",
//        "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ",
//        "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ",
//        "ㅡ", "ㅢ", "ㅣ"
        if left == "ㅗ" {
            if right == "ㅏ" {
                return "ㅘ"
            } else if right == "ㅐ" {
                return "ㅙ"
            } else if right == "ㅣ" {
                return "ㅚ"
            }
        } else if left == "ㅜ" {
            if right == "ㅓ" {
                return "ㅝ"
            } else if right == "ㅔ" {
                return "ㅞ"
            } else if right == "ㅣ" {
                return "ㅟ"
            }
        } else if right == "ㅣ" {
            if left == "ㅡ" {
                return "ㅢ"
            } else if left == "ㅏ" {
                return "ㅐ"
            } else if left == "ㅑ" {
                return "ㅒ"
            } else if left == "ㅓ" {
                return "ㅔ"
            } else if left == "ㅕ" {
                return "ㅖ"
            }
        }
        
        return nil
    }
    
    private class func jongsungCompress(left: UnicodeScalar, right: UnicodeScalar) -> UnicodeScalar? {
        if left == "ㄱ" {
            if right == "ㄱ" {
                return "ㄲ"
            } else if right == "ㅅ" {
                return "ㄳ"
            }
        } else if left == "ㄴ" {
            if right == "ㅈ" {
                return "ㄵ"
            } else if right == "ㅎ" {
                return "ㄶ"
            }
        } else if left == "ㄹ" {
            if right == "ㄱ" {
                return "ㄺ"
            } else if right == "ㅁ" {
                return "ㄻ"
            } else if right == "ㅂ" {
                return "ㄼ"
            } else if right == "ㅅ" {
                return "ㄽ"
            } else if right == "ㅌ" {
                return "ㄾ"
            } else if right == "ㅍ" {
                return "ㄿ"
            } else if right == "ㅎ" {
                return "ㅀ"
            }
        } else if left == "ㅂ" {
            if right == "ㅅ" {
                return "ㅄ"
            }
        } else if left == "ㅅ" {
            if right == "ㅅ" {
                return "ㅆ"
            }
        }
        
        return nil
    }
}

