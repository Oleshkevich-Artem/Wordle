//
//  LeadersViewController.swift
//  Wordle
//
//  Created by Oleshkevich Artem on 16.05.22.
//

import UIKit

class LeadersboardViewController: UIViewController {

    @IBOutlet weak var leaderboardTableView: UITableView!
    private var gameResults = [GameResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLeaderboardTableView()
        updateGameResults()
    }
    
    private func setUpLeaderboardTableView() {
        leaderboardTableView.delegate = self
        leaderboardTableView.dataSource = self
        
        leaderboardTableView.register(UINib(nibName: "LeaderboardTableViewCell",
                                            bundle: nil),
                                      forCellReuseIdentifier: LeaderboardTableViewCell.id)
    }
    
    private func updateGameResults() {
        self.gameResults = UserDefaultsService.shared.getGameResults().sorted(by: { $0.attemptsNumber < $1.attemptsNumber })
        
        leaderboardTableView.reloadData()
    }

}

extension LeadersboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
}

extension LeadersboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeaderboardTableViewCell.id,
                                                       for: indexPath) as? LeaderboardTableViewCell else {
            return UITableViewCell()
        }
        
        let gameResult = gameResults[indexPath.row]
        cell.updateData(gameResult: gameResult)
        
        return cell
    }
}
