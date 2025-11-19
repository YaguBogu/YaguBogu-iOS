import Foundation

enum BaseBallNameTranslator {
    private static let koreanNames: [String: String] = [
        "Doosan Bears" : "두산",
        "Hanwha Eagles" : "한화",
        "KIA Tigers" : "KIA",
        "Kiwoom Heroes" : "키움",
        "KT Wiz Suwon" : "KT",
        "LG Twins" : "LG",
        "Lotte Giants" : "롯데",
        "NC Dinos" : "NC",
        "Samsung Lions" : "삼성",
        "SSG Landers": "SSG"
    ]
    
    static func getKoreanName(for englishName: String) -> String {
        
        return koreanNames[englishName] ?? englishName
    }
}

/* 사용 예시
 let teamName = "Doosan Bears"
 let koreanName = BaseBallNameTranslator.getKoreanName(for: teamName)
 print("\(teamName)의 한국어 이름: \(koreanName)")
 */
