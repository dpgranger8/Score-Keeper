//
//  ListOfPlayers.swift
//  Score Keeper
//
//  Created by David Granger on 4/10/23.
//

import Foundation

struct Player: Equatable, Codable, Comparable {
    
    static func < (lhs: Player, rhs: Player) -> Bool {
        lhs.playerScore < rhs.playerScore
    }
    
    var id: UUID
    var playerName: String
    var playerScore: Int
    
    static func loadSamplePlayers() -> [Player] {
        return [Player(playerName: "jeff", playerScore: 5), Player(playerName: "kim", playerScore: 3), Player(playerName: "josh", playerScore: 6)]
    }
    
    static let documentsDirectory =
       FileManager.default.urls(for: .documentDirectory,
       in: .userDomainMask).first!
    static let archiveURL =
       documentsDirectory.appendingPathComponent("players")
       .appendingPathExtension("plist")
    
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(playerName: String, playerScore: Int) {
        self.id = UUID()
        self.playerName = playerName
        self.playerScore = playerScore
    }
    
    static func savePlayers(_ players: [Player]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedPlayers = try? propertyListEncoder.encode(players)
        try? codedPlayers?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadPlayers() -> [Player]? {
        guard let codedPlayers = try? Data(contentsOf: archiveURL) else
               {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<Player>.self,
           from: codedPlayers)
    }
    
}
