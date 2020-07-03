//
//  LeaderboardController.swift
//  Quizzoo
//
//  Created by Adrijan Omicevic on 21/06/2020.
//  Copyright © 2020 OmiApp. All rights reserved.
//

import UIKit

class LeaderboardController: UIViewController {
    
    
    var tableView = UITableView()
    
    var results : [Results] = []
    var closeButton : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewDelegates()
        buildViews()
        createConstraints()
        view.backgroundColor = .white
        
        
        // Do any additional setup after loading the view.
    }
    
    func buildViews() {
        closeButton = UIButton()
        closeButton.setTitle("CLOSE", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.addTarget(self, action: #selector(closeLeaderBoard), for: .touchUpInside)
        view.addSubview(closeButton)
        
        
        
        view.addSubview(tableView)
        tableView.rowHeight = 80
        tableView.register(LeaderboardCell.self, forCellReuseIdentifier: "LeaderboardCell")
    }
    
    func createConstraints() {
        closeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        closeButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
        
        
        tableView.autoPinEdge(.top, to: .bottom, of: closeButton, withOffset: 10)
        tableView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        tableView.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        tableView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func closeLeaderBoard() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension LeaderboardController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(results.count)
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell", for: indexPath) as! LeaderboardCell
        let result = results[indexPath.row]
        cell.setup(result: result, rank: indexPath.row)
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = LeaderboardHeaderView()
        return view
    }
}
