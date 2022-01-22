//
//  Repository.swift
//  NYTimes
//
//  Created by Admin on 06/09/2021.
//

import Foundation
import Combine



protocol RepositoryService {
    func fetchNews<T:Decodable>(modelType:T.Type)-> AnyPublisher<T, ServiceError>
}


class RepositoryServiceImpl: RepositoryService {
    
    let service:NewsService
    
    init(newsService:NewsService = NewsServiceImp()) {
        self.service = newsService
    }
    
    
    func fetchNews<T:Decodable>(modelType:T.Type)-> AnyPublisher<T, ServiceError> {
        
        guard let request = URLRequest.getRequest(url:ServiceEndPoint.baseUrl, path: APIPath.topStories) else {
            return Fail(error:  ServiceError.errorWith(message: "Something went wrong")).eraseToAnyPublisher()
        }
        
        return  service.get(urlRequest: request)
            .decode(type:T.self , decoder: JSONDecoder())
            .tryMap { result in
                return result
            }.mapError{ _ in
                ServiceError.errorWith(message: "Something went wrong")}
            .eraseToAnyPublisher()

    }
}


extension URLRequest {
    static func getRequest(url:String , path:String) -> Self? {
        guard var urlComponents = URLComponents(string: url.appending(path))else {
            return nil
        }
        
        
        urlComponents.queryItems = [URLQueryItem(name:"api-key", value:ServiceEndPoint.key)]
        guard let url = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        return request
    }
}
