import UIKit

extension UIImage {

    class func downloadImage(from url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else {
                completion(nil)
                return
            }

            completion(UIImage(data: data))
        }
    }
}

extension UIImageView {
    func setImage(from url: URL) {
        UIImage.downloadImage(from: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
