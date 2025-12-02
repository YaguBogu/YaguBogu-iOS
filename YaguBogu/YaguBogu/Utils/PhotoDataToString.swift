import UIKit

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func loadImageCoreData(fileName: String) -> UIImage? {
    let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
    if let data = try? Data(contentsOf: fileURL) {
        return UIImage(data: data)
    }
    return nil
}

func saveImageCoreData(image: UIImage) -> String? {
    guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
    let fileName = UUID().uuidString + ".jpg"
    let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
    do {
        try data.write(to: fileURL)
        print("이미지 파일 저장 성공 \(fileName)")
        return fileName
    } catch {
        print("이미지 파일 저장 실패 \(error)")
        return nil
    }
}
