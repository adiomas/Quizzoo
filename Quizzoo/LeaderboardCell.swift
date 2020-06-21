//
//  LeaderboardCell.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 21/06/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import UIKit

class LeaderboardCell: UITableViewCell {
    
    
    var rankLabel = UILabel()
    var nameLabel = UILabel()
    var scoreLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViews()
        createConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("greska")
    }
    
    func setup(result: Results, rank: Int) {
        if(result.username == "36483352") {
            nameLabel.text = "KRALJ"
        } else {
            nameLabel.text = result.username
        }
        guard let score = result.score else { return }
        guard let d = Double(score) else {return}
        scoreLabel.text = String(format: "%.0f", d)
        rankLabel.text = String(rank+1)
    }
    
    func buildViews() {
        rankLabel.textAlignment = .center
        addSubview(rankLabel)
        
        nameLabel.textAlignment = .center
        addSubview(nameLabel)
        
        addSubview(scoreLabel)
    }
    
    func createConstraints() {
        rankLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        rankLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        rankLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        rankLabel.autoSetDimensions(to: CGSize(width: "RANK".stringWidth + 10, height: 80))
        
        nameLabel.autoPinEdge(.leading, to: .trailing, of: rankLabel, withOffset: 5)
        nameLabel.autoAlignAxis(.horizontal, toSameAxisOf: rankLabel)
        
        scoreLabel.autoPinEdge(.leading, to: .trailing, of: nameLabel, withOffset: 50)
        scoreLabel.autoAlignAxis(.horizontal, toSameAxisOf: nameLabel)
        scoreLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
    }
}

extension String {
    var stringWidth: CGFloat {
        let constraintRect = CGSize(width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude)
        let boundingBox = self.trimmingCharacters(in: .whitespacesAndNewlines).boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
        return boundingBox.width
    }
}
