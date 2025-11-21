import UIKit

extension UILabel {
    func setSpacingInPixels(text: String?, spacingInPx: CGFloat) {
        guard let text = text, let font = self.font else { return }
        
        let spacingPt = spacingInPx / UIScreen.main.scale
        
        let fontBottomPadding = font.lineHeight - font.ascender
        
        let allLineSpacing = spacingPt - fontBottomPadding
        
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        
        
        paragraphStyle.lineSpacing = allLineSpacing
        
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        
        attributedString.addAttribute(.font, value: font, range: NSMakeRange(0, attributedString.length))

        self.attributedText = attributedString
    }
}
