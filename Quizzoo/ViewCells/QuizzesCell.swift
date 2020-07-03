//
//  QuizzesCell.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 01/06/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import UIKit
import PureLayout
import Kingfisher

class QuizzesCell: UITableViewCell {
    
    
    var quizImage = UIImageView()
    var quizTitle = UILabel()
    var quizDescription = UILabel()
    var levelImage1 = UIImageView()
    var levelImage2 = UIImageView()
    var levelImage3 = UIImageView()
    
    let levelImage = "☠️".textToImage()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViews()
        createConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("greska")
    }
    
    func setup(withQuizzes quiz: Quiz) {
        quizTitle.text = quiz.title!
        quizDescription.text = quiz.quizDescription
        
        if
            let urlString = quiz.image,
            let url = URL(string: urlString) {
            quizImage.kf.setImage(with: url)
        }
        switch quiz.level {
        case 1:
            levelImage1.isHidden = true
            levelImage2.isHidden = true
        case 2:
            levelImage1.isHidden = true
        default:
            print("3 level")
        }
    }
    
    
    
    func buildViews() {
        quizImage.layer.cornerRadius = 10
        quizImage.clipsToBounds = true
        addSubview(quizImage)
        
        quizTitle.numberOfLines = 1
        quizTitle.textAlignment = .left
        quizTitle.font = UIFont.boldSystemFont(ofSize: 12)
        addSubview(quizTitle)
        
        quizDescription.numberOfLines = 0
        quizDescription.font = quizDescription.font.withSize(10)
        quizDescription.textAlignment = .left
        addSubview(quizDescription)
        
        levelImage1.image = levelImage
        addSubview(levelImage1)
        
        levelImage2.image = levelImage
        addSubview(levelImage2)
        
        levelImage3.image = levelImage
        addSubview(levelImage3)
    }
    
    func createConstraints() {
        quizImage.translatesAutoresizingMaskIntoConstraints = false
        quizImage.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        quizImage.autoPinEdge(toSuperviewEdge: .leading, withInset: 12)
        quizImage.autoPinEdge(toSuperviewEdge: .bottom, withInset: 12)
        quizImage.autoSetDimensions(to: CGSize(width: 120, height: 67))
        
        quizTitle.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        quizTitle.autoPinEdge(.leading, to: .trailing, of: quizImage, withOffset: 10)
        
        levelImage1.autoAlignAxis(.horizontal, toSameAxisOf: quizTitle)
        levelImage1.autoPinEdge(.leading, to: .trailing, of: quizTitle, withOffset: 5)
        
        levelImage2.autoAlignAxis(.horizontal, toSameAxisOf: levelImage1)
        levelImage2.autoPinEdge(.leading, to: .trailing, of: levelImage1, withOffset: 5)
        
        levelImage3.autoAlignAxis(.horizontal, toSameAxisOf: levelImage2)
        levelImage3.autoPinEdge(.leading, to: .trailing, of: levelImage2, withOffset: 5)
        levelImage3.autoPinEdge(toSuperviewEdge: .trailing, withInset: 15)
        
        quizDescription.autoPinEdge(.top, to: .bottom, of: quizTitle, withOffset: 13)
        quizDescription.autoPinEdge(.leading, to: .trailing, of: quizImage, withOffset: 10)
        quizDescription.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
        quizDescription.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
    }
    
}

extension String {
    func textToImage() -> UIImage? {
        let nsString = (self as NSString)
        let font = UIFont.systemFont(ofSize: 10) // you can change your font size here
        let stringAttributes = [NSAttributedString.Key.font: font]
        let imageSize = nsString.size(withAttributes: stringAttributes)
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0) //  begin image context
        UIColor.clear.set() // clear background
        UIRectFill(CGRect(origin: CGPoint(), size: imageSize)) // set rect size
        nsString.draw(at: CGPoint.zero, withAttributes: stringAttributes) // draw text within rect
        let image = UIGraphicsGetImageFromCurrentImageContext() // create image from context
        UIGraphicsEndImageContext() //  end image context
        
        return image ?? UIImage()
    }
}
