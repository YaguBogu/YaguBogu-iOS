
import Foundation

struct JsonLoader{
    
    func load<T: Decodable>(_ fileName: String) -> T?{
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else{
            return nil
        }
        guard let data = try? Data(contentsOf: fileURL) else {
            return nil
        }
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            return nil
        }
    }
}
