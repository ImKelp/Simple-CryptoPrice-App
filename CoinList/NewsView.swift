//
//  NewsView.swift
//  CoinList
//
//  Created by ColdBio on 21/02/2022.
//

import SwiftUI

struct NewsView: View {
    @State var news: NewsModel?
    let test: Article = Article.init(title: "loading...", description: "loading...", url: "loading...", urlToImage: "loading...")
    var body: some View {
        NavigationView {
            List {
                ForEach((news?.articles) ?? [test], id: \.self) { item in
                    HStack {
                        VStack {
                            Text("\(item.title ?? "")")
                                .font(.headline)
                            AsyncImage(url: URL(string: "\(item.urlToImage ?? "")")) { image in
                                image.resizable()

                            } placeholder: {
                                ProgressView()
                            }
                                .cornerRadius(20)
                                .frame(width: 160, height: 100)
                        }
                        Text("\(item.description ?? "")")
                            .font(.subheadline)
                    }
                }
                    .onAppear() {
                    NewsAPICall().getAPI { (data) in
                        self.news = data
                    }
                }
            }
            .navigationBarTitle("Crypto News")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
