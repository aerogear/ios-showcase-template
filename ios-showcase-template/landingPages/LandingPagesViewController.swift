//
//  LandingPagesViewController.swift
//  ios-showcase-template

import UIKit
import WebKit

class LandingPagesViewController: UIViewController {
    
    @IBOutlet weak var headerTextView: UITextView!
    
    @IBOutlet weak var contentView: UITextView!
    
    @IBOutlet weak var footerText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadText(header: String?, contentList: [String]?, footer: String?) {
        if let headerTextView = self.headerTextView, let headerText = header {
            headerTextView.text = headerText
            headerTextView.layoutIfNeeded()
        }
        if let contentTextView = self.contentView, let contentTextList = contentList {
            let systemFont = contentTextView.font
            let fullAttributedString = createBulletListView(font: systemFont!, contentList: contentTextList)
            contentTextView.attributedText = fullAttributedString
            contentTextView.layoutIfNeeded()
        }
        if let footerTextView = self.footerText, let footerText = footer {
            footerTextView.text = footerText
            footerTextView.layoutIfNeeded()
        }
    }
    
    func createBulletListView(font: UIFont, contentList: [String]) -> NSAttributedString {
        let fullAttributedString = NSMutableAttributedString(string: "", attributes: [NSAttributedStringKey.font: font])
        
        for string: String in contentList
        {
            let bulletPoint: String = "\u{2022}"
            let formattedString: String = "\(bulletPoint) \(string)\n"
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString, attributes: [NSAttributedStringKey.font: font])
            
            let paragraphStyle = createParagraphAttribute()
            attributedString.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            fullAttributedString.append(attributedString)
        }
        return fullAttributedString
    }
    
    func createParagraphAttribute() -> NSParagraphStyle {
        var paragraphStyle: NSMutableParagraphStyle
        paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: [:])]
        paragraphStyle.defaultTabInterval = 15
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 10
        paragraphStyle.paragraphSpacing = 5
        
        return paragraphStyle
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
