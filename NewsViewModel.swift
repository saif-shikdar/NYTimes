//
//  NewsViewModel.swift
//  NYTimes
//
//  Created by Admin on 06/09/2021.
//

import Foundation
import Combine


protocol NewsViewModelType {
    
    var numberofItems:Int { get }
    var newsBinding:Published<News?>.Publisher { get }
    func getNews()
    func getNewsDetails(for index:Int)-> NewsDetails?
}

struct NewsDetails  {
    let title: String
    let byline: String
    let updatedDate: String
}

class NewsViewModel {
    
    var numberofItems:Int {
        return news?.results.count ?? 0
    }
    var subscriptions:Set<AnyCancellable> = []
    let repository:RepositoryService
    
    @Published private var news:News?
    
    var newsBinding:Published<News?>.Publisher { $news }
    
    init(repository:RepositoryService = RepositoryServiceImpl()) {
        self.repository = repository
    }
    
    
}

extension NewsViewModel: NewsViewModelType {
    func getNews() {
        
        repository.fetchNews(modelType: News.self)
            .receive(on: DispatchQueue.main).sink{ [weak self] completion in
                
              
            }
                receiveValue: { [weak self ] response in
                
                    self?.news = response
                      
                }.store(in: &subscriptions)

    }
    
    
    func getNewsDetails(for index:Int)-> NewsDetails? {
        if let newsResult = news?.results,  index >= 0 , index < newsResult.count {
            let newsDetails =  newsResult[index]
            return NewsDetails(title: newsDetails.title, byline: newsDetails.byline, updatedDate: newsDetails.updatedDate)
        }
        return nil
    }
}
