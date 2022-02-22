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


class NewsAPICall {
    func getAPI(completion: @escaping (NewsModel) -> ()) {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=crypto&apiKey=4674f381cf3043189a309dadb8aaabd6" ) else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, _) in

            do {
                let returnedData = try JSONDecoder().decode(NewsModel.self, from: data!)
            

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

class ExchangeAPICall {
    func getAPI(completion: @escaping ([ExchangeModel]) -> ()) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/exchanges" ) else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, _) in

            do {
                let returnedData = try JSONDecoder().decode([ExchangeModel].self, from: data!)
                
                    


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
