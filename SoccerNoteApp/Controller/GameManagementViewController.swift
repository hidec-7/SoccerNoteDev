//
//  GameManagementViewController.swift
//  SoccerNoteApp
//
//  Created by hideto c. on 2020/11/07.
//

import UIKit
import Firebase

class GameManagementViewController: UIViewController {
    
    private let cellId = "cellId"
    
    @IBOutlet weak private var gameManagementTableView: UITableView!
    @IBOutlet weak private var gameAddButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerTitle()
        
        gameManagementTableView.delegate = self
        gameManagementTableView.dataSource = self
        
        gameManagementTableView.register(UINib(nibName: "GameManagementTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GameDataReadModel.getGameData {
            self.gameManagementTableView.reloadData()
        }
    }
    
    private func headerTitle() {
        title = "試合管理"
    }
    
}

extension GameManagementViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GameDataModel.gameDataListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = gameManagementTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! GameManagementTableViewCell
        let gameData = GameDataModel.gameDataListArray[indexPath.row]
        cell.dateLabel.text = gameData.gameDate
        cell.opponentTeamLabel.text = gameData.team
        cell.myScoreLabel.text = gameData.myScore
        cell.opponentScoreLabel.text = gameData.opponentScore
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "gameEdit", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //CRUDのDeleteを実装する際に追記
        }
    }
}
