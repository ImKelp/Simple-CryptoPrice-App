//
//  NewsView.swift
//  CoinList
//
//  Created by ColdBio on 21/02/2022.
//

import SwiftUI
import SafariServices


struct NewsView: View {
    @State var news: NewsModel?

    let test: Article = Article.init(title: "loading...", description: "loading...", url: "loading...", urlToImage: "loading...")
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach((news?.articles) ?? [test], id: \.self) { item in
                    HStack {
                        VStack {
                            AsyncImage(url: URL(string: "\(item.urlToImage ?? "")")) { image in
                                image.resizable()

                            } placeholder: {
                                ProgressView()
                            }
                                .cornerRadius(20)
                                .frame(width: 400, height: 300)
                            Spacer()
                            HStack {
                                Text("\(item.title ?? "")")
                                    .font(.headline)
                                .frame(alignment: .leading)
                                Link(destination: URL(string: "\(item.url ?? "")")!) {
                                    Text("Visit Site")
                                }
                            }
                            Text("\(item.description ?? "")")
                                .font(.subheadline)
                            Divider()
                        }

                            .onTapGesture {
                            print("Hello World")
                        }
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
                .toolbar {
                Button(action: {

                    print("Reload")

                    NewsAPICall().getAPI { (data) in
                        self.news = data
                    }
                }) {
                    Text("Reload")
                }
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
