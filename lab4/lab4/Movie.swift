//
//  Movie.swift
//  lab4
//
//  Created by Xiangzhi Cao on 10/17/18.
//  Copyright © 2018 Xiangzhi Cao. All rights reserved.
//

import Foundation

struct APIResults:Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int!
    let poster_path: String?
    let title: String
    let release_date: String
    let vote_average: Double
    let overview: String
    let vote_count: Int!
    // changes
//    let video: Bool
//    let popularity: Double
//    let original_language: String
//    let original_title: String
//    let genre_ids: [Int]
//    let backdrop_path: String
//    let adult: Bool
}
