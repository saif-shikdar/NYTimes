//
//  News.swift
//  NYTimes
//
//  Created by Admin on 06/09/2021.
//

import Foundation

struct News: Decodable {
    let results:[Result]
}


struct Result: Decodable {
    let title: String
    let byline: String
    let updatedDate: String
    
    enum CodingKeys:String, CodingKey {
        case title = "title"
        case byline = "byline"
        case updatedDate = "updated_date"
    }
}
