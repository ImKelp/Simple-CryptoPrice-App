//
//  ExchangesView.swift
//  CoinList
//
//  Created by ColdBio on 22/02/2022.
//

import SwiftUI
import SafariServices

struct ExchangesView: View {
    @State var data: [ExchangeModel]?

    let tmp = ExchangeModel.init(id: "", name: "", yearEstablished: 0, country: "", url: "", image: "", trustScore: 0, trustScoreRank: 0, tradeVolume24HBtc: 0, tradeVolume24HBtcNormalized: 0.0)
    var body: some View {
        NavigationView {
            List {
                ForEach(data ?? [tmp], id: \.self) { item in
                    HStack {
                        Text("\(item.trustScoreRank ?? 0)")
                        AsyncImage(url: URL(string: "\(item.image ?? "")")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                            .frame(width: 20, height: 20)
                        VStack(alignment: .leading) {
                            Text("\(item.name ?? "")")
                                .font(.headline)
                            HStack {
                                Text("\(item.country ?? "Country Unkown")")
                                    .font(.footnote)
                                let yourIntValue = item.yearEstablished ?? 0
                                Text(String(yourIntValue))
                                    .font(.footnote)
                            }
                        }
                        Spacer()
                        VStack {
                            Text("₿\(item.tradeVolume24HBtcNormalized ?? 0, specifier: "%.0f")")
                        }
                    }
                }
            }
                .navigationBarTitle("Top 100 Exchanges")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                Button(action: {

                    print("Reload")

                    ExchangeAPICall().getAPI { (data) in
                        self.data = data
                    }
                }) {
                    Text("Reload")
                }
            }
        }
            .onAppear() {
            ExchangeAPICall().getAPI { (data) in
                self.data = data
            }
        }
    }
}

struct ExchangesView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangesView()
    }
}
