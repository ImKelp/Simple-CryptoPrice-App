//
//  ExchangeModel.swift
//  CoinList
//
//  Created by ColdBio on 22/02/2022.
//

import Foundation

struct ExchangeModel: Codable, Hashable {
    let id: String?
    let name: String?
    let yearEstablished: Int?
    let country: String?
    let url: String?
    let image: String?
    let trustScore: Int?
    let trustScoreRank: Int?
    let tradeVolume24HBtc: Double?
    let tradeVolume24HBtcNormalized: Double?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case yearEstablished = "year_established"
        case country = "country"
        case url = "url"
        case image = "image"
        case trustScore = "trust_score"
        case trustScoreRank = "trust_score_rank"
        case tradeVolume24HBtc = "trade_volume_24h_btc"
        case tradeVolume24HBtcNormalized = "trade_volume_24h_btc_normalized"
    }
}
