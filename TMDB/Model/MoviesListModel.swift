//
//  MoviesListModel.swift
//  TMDB
//
//  Created by Anbusekar Murugesan on 20/02/2022.
//

import Foundation
import Alamofire


// MARK: - Welcome
struct TMDBMoviesList: Codable {
    let dates: Dates
    let page: Int
    let results: [Movies]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String
}

// MARK: - Result
struct Movies: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguage
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case ja = "ja"
}


protocol MoviesListModelProtocol {
    
    typealias SuccessBlock = (_ withResponse: TMDBMoviesList, _ successStatus: Bool?) -> Void
    typealias FailureBlock = (_ withResponse: AFError?, _ failureStatus: Bool?) -> Void
    
    
    func MoviesList(successBlock: @escaping MoviesListModelProtocol.SuccessBlock, failureBlock: @escaping FailureBlock)
    
}

class MoviesListModel: NSObject, MoviesListModelProtocol  {
    
    func MoviesList(successBlock: @escaping MoviesListModelProtocol.SuccessBlock, failureBlock: @escaping FailureBlock) {
        _ = TMDBAlamofire.getRequest(url: URL(string: pathForGetNowPlayingList)!, parameters: nil, successBlock: { withResponse, status in
            if let response = withResponse?.data {
                do {
                    let settings = try JSONDecoder().decode(TMDBMoviesList.self, from: response)
                    successBlock(settings, status)
                }
                catch {
                    failureBlock(nil, status)
                }

            } else {
                failureBlock(nil, false)
            }
        }, failureBlock: { withError, cancelStatus in
            print(withError)
            failureBlock(withError, false)
        })
    }
    
}
