//
//  ContentView.swift
//  CoinList
//
//  Created by ColdBio on 20/02/2022.
//

import SwiftUI


struct ContentView: View {
    private enum Tab: Hashable {
        case chart
        case test
    }
    @State private var selectedTab: Tab = .chart
    var body: some View {
        TabView(selection: $selectedTab) {
            MainView()
                .tag(0)
                .tabItem {
                Text("Top 100")
                Image(systemName: "bitcoinsign.circle")
            }
            NewsView()
                .tag(1)
                .tabItem {
                Text("News")
                Image(systemName: "newspaper")
            }
            ExchangesView()
                .tag(2)
                .tabItem {
                Text("Exchanges")
                Image(systemName: "bag.fill")
                }
            About()
                .tag(3)
                .tabItem {
                Text("About")
                Image(systemName: "questionmark.app")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MainView: View {
    @State var data = [Main]()
    var body: some View {
        NavigationView {
            VStack {
                List(data, id: \.self) { item in
                    NavigationLink(destination: CoinDetailedData(coin: item)) {
                        HStack {
                            Text("\(item.marketCapRank ?? 0)")
                                .font(.headline)
                            AsyncImage(url: URL(string: "\(item.image ?? "")")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                                .frame(width: 20, height: 20)
                            if item.marketCapRank ?? 0 == 1 {
                                Text("👑 \(item.name ?? "") 👑")
                                    .font(.headline)
                            } else {
                                Text("\(item.name ?? "")")
                                    .font(.headline)
                            }

                            Spacer()
                            Text("$\(item.currentPrice ?? 0, specifier: "%.2f")")
                        }
                    }
                }
                    .listStyle(.insetGrouped)

            }
                .navigationTitle("Top 100 by Market Cap")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)

                .toolbar {
                Button(action: {

                    APICall().getAPI { (data) in
                        self.data = data
                    }
                }) {
                    Text("Reload")
                }
            }
        }
            .onAppear() {
            APICall().getAPI { (data) in
                self.data = data
            }
        }
    }
}

struct CoinDetailedData: View {
    let coin: Main

    var body: some View {
        VStack {
            List {
                Section(header: Text("\(coin.name ?? "")")) {
                    HStack {
                        Text("Market Cap")
                        Spacer()
                        Text("$\(coin.marketCap ?? 0)")
                    }
                    HStack {
                        Text("Fully Diluted Valuation")
                        Spacer()
                        Text("$\(coin.fullyDilutedValuation ?? 0)")
                    }
                }
                Section(header: Text("24-hour Price Data")) {
                    HStack {
                        Text("24-Hour High")
                        Spacer()
                        Text("$\(coin.high24H ?? 0.0, specifier: "%.2f")")
                    }
                    HStack {
                        Text("24-Hour Low")
                        Spacer()
                        Text("$\(coin.low24H ?? 0.0, specifier: "%.2f")")
                    }
                    if coin.priceChange24H ?? 0 < 0.0 {
                        HStack {
                            Text("Price Change 24h")
                            Spacer()
                            Image(systemName: "arrow.down")
                                .foregroundColor(.red)
                            Text("$\(coin.priceChange24H ?? 0, specifier: "%.2f")")
                                .foregroundColor(.red)
                        }

                    } else if coin.priceChange24H ?? 0 > 0.0 {
                        HStack {
                            Text("Price Change 24h")
                            Spacer()
                            Image(systemName: "arrow.up")
                                .foregroundColor(.green)
                            Text("$\(coin.priceChange24H ?? 0, specifier: "%.2f")")
                                .foregroundColor(.green)
                        }
                    }

                    if coin.priceChangePercentage24H ?? 0 < 0.0 {
                        HStack {
                            Text("Price Change % 24h")
                            Spacer()
                            Image(systemName: "arrow.down")
                                .foregroundColor(.red)
                            Text("\(coin.priceChangePercentage24H ?? 0, specifier: "%.2f")%")
                                .foregroundColor(.red)
                        }
                    } else if coin.priceChangePercentage24H ?? 0 > 0.0 {
                        HStack {
                            Text("Price Change % 24h")
                            Spacer()
                            Image(systemName: "arrow.up")
                                .foregroundColor(.green)
                            Text("\(coin.priceChangePercentage24H ?? 0, specifier: "%.2f")%")
                                .foregroundColor(.green)
                        }
                    }
                }
                Section(header: Text("Historical Data")) {
                    HStack {
                        Text("All Time Price")
                        Spacer()
                        Text("$\(coin.ath ?? 0.0, specifier: "%.2f")")
                    }
                    if coin.priceChangePercentage24H ?? 0 < 0.0 {
                        HStack {
                            Text("All Time high % Change:")
                            Spacer()
                            Text("\(coin.athChangePercentage ?? 0.0, specifier: "%.2f")%")
                                .foregroundColor(.red)
                        }
                    } else if coin.priceChangePercentage24H ?? 0 < 0.0 {
                        HStack {
                            Text("All Time high % Change:")
                            Spacer()
                            Text("\(coin.athChangePercentage ?? 0.0, specifier: "%.2f")%")
                                .foregroundColor(.red)
                        }
                    }
                }

                Section(header: Text("Supply Data")) {
                    HStack {
                        Text("Circulating Supply")
                        Spacer()
                        Text("\(coin.circulatingSupply ?? 0, specifier: "%.0f")")
                    }
                    HStack {
                        Text("Total Supply")
                        Spacer()
                        Text("\(coin.totalSupply ?? 0, specifier: "%.0f")")
                    }
                }
                
            }
        }
    }
}


struct About: View {
    var body: some View {
        VStack {
            List {
                Section(header: Text("About Author")) {
                    HStack {
                        Text("Author")
                        Spacer()
                        Text("ColdBio")
                    }
                    HStack {
                        Text("Github")
                        Spacer()
                        Text("www.github.com/ColdBio")
                    }
                }

                Section(header: Text("License")) {
                    HStack {
                        Text("License")
                        Spacer()
                        Text("MIT License")
                    }
                }
            }
        }
    }
}
