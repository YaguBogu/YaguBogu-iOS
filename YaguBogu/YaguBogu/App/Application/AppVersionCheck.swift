import Foundation
import UIKit

struct AppVersion{
    // 현재 버전 정보 : 타겟 -> 일반 -> 버전
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    // 내부 확인용 : 타겟 -> 일반 -> Build
    static let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    
    
    //앱 스토어 주소
    static let appStoreOpenURLString = "https://apps.apple.com/app/id\(AppIdentifier.appID)"
    
    //앱 스토어 최신 정보 확인
    static func latestVersion(completion: @escaping (String?) -> Void){
        let appleID = AppIdentifier.appID
        let urlString = "http://itunes.apple.com/lookup?id=\(appleID)&country=kr"
        guard let url = URL(string: urlString) else {
            print("URL이 정확하지 않음")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error{
                print("URLSession 작업 오류 \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("데이터 존재하지 않음")
                completion(nil)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                    if let results = json["results"] as? [[String: Any]],
                       let appStoreVersion = results.first?["version"] as? String{
                        print(appStoreVersion)
                        completion(appStoreVersion)
                    } else {
                        print("JSON 파싱 실패")
                        completion(nil)
                    }
                }
            } catch {
                print("JSONSerialization 오류")
                completion(nil)
            }
        }
        task.resume()
    }

    //현재 앱 스토어 버전과 빌드 버전 비교 함수
    static func isMinorVersionUpdated(currentVersion: String, appStoreVersion: String) -> Bool{
        let currentVersionComponents = currentVersion.split(separator: ".").map{Int($0) ?? 0}
        let appStoreVersionComponents = appStoreVersion.split(separator: ".").map{Int($0) ?? 0}
        
        guard currentVersionComponents.count >= 2, appStoreVersionComponents.count >= 2 else {
            return false
        }
        
        return appStoreVersionComponents[0] > currentVersionComponents[0] ||
        (appStoreVersionComponents[0] == currentVersionComponents[0] &&
         appStoreVersionComponents[1] > currentVersionComponents[1])
    }

    // 앱 스토어 연결
    static func openAppStore(){
        guard let url = URL(string: AppVersion.appStoreOpenURLString) else {return}
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        print(url)
    }
}

