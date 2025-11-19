import Foundation

enum DayTranslator {
    private static let daysNames: [String: String] = [
        "Mon" : "월",
        "Tue" : "화",
        "Wed" : "수",
        "Thu" : "목",
        "Fri" : "금",
        "Sat" : "토",
        "Sun" : "일"
    ]
    
    static func getKoreanName(for englishName: String) -> String {
        
        return daysNames[englishName] ?? englishName
    }
}

/* 사용 예시
 let daysNames = "Mon"
 let koreanName = BaseBallNameTranslator.getKoreanName(for: daysNames)
 print("\(daysNames)의 한국어 이름: \(koreanName)")
 */
