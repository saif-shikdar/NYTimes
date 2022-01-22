//
//  EndPoint.swift
//  NYTimes
//
//  Created by Admin on 06/09/2021.
//

// "sGecvmIXM2UIIH8QoGslprpSbAvWTqNi"
// https://api.nytimes.com/svc/topstories/v2/arts.json?api-key=sGecvmIXM2UIIH8QoGslprpSbAvWTqNi


import Foundation

enum ServiceEndPoint  {
    static let baseUrl = "https://api.nytimes.com"
    static let key = "sGecvmIXM2UIIH8QoGslprpSbAvWTqNi"
}


enum APIPath  {
    static let topStories = "/svc/topstories/v2/arts.json"
}
