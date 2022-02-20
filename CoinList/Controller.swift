//
//  Controller.swift
//  CoinList
//
//  Created by ColdBio on 20/02/2022.
//

import Foundation

class APICall {
    func getAPI(completion: @escaping ([Main]) -> ()) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false" ) else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, _) in

            do {
                let returnedData = try JSONDecoder().decode([Main].self, from: data!)
                
                print(returnedData[0].currentPrice ?? 0)
                print(returnedData[0].athDate ?? "")

                DispatchQueue.main.async {
                    completion(returnedData)
                }
            } catch {
                print(String(describing: error))
            }
        }
            .resume()
    }
}
