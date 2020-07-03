//
//  LeaderboardHeaderView.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 21/06/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import UIKit

class LeaderboardHeaderView: UIView {
    
    var rankLabel : UILabel!
    var nameLabel : UILabel!
    var scoreLabel : UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        buildViews()
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func buildViews() {
        rankLabel = UILabel()
        rankLabel.text = "RANK"
        rankLabel.textAlignment = .center
        rankLabel.font = UIFont.boldSystemFont(ofSize: 13.0)
        addSubview(rankLabel)
        
        nameLabel = UILabel()
        nameLabel.text = "USERNAME"
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 13.0)
        addSubview(nameLabel)
        
        scoreLabel = UILabel()
        scoreLabel.text = "SCORE"
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 13.0)
        addSubview(scoreLabel)
    }
    
    func createConstraints() {
        rankLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        rankLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        rankLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        rankLabel.autoSetDimensions(to: CGSize(width: "RANK".stringWidth + 10, height: 40))
        
        nameLabel.autoPinEdge(.leading, to: .trailing, of: rankLabel, withOffset: 5)
        nameLabel.autoAlignAxis(.horizontal, toSameAxisOf: rankLabel)
        
        scoreLabel.autoPinEdge(.leading, to: .trailing, of: nameLabel, withOffset: 50)
        scoreLabel.autoAlignAxis(.horizontal, toSameAxisOf: nameLabel)
        scoreLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
    }
}
