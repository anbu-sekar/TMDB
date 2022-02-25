//
//  MoviesListModel.swift
//  TMDB
//
//  Created by Anbusekar Murugesan on 20/02/2022.
//

import Foundation
import Alamofire


// MARK: - MoviesList
struct TMDBMoviesList: Codable {
    let dates: Dates
    var page: Int
    var results: [Movies]?
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

// MARK: - Movies
struct Movies: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String?
    let originalTitle: String
    let overview: String
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

struct TMDBErrorResponse: Codable {
    let statusMessage: String
    let success: Bool
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
        case success
        case statusCode = "status_code"
    }
}


protocol TMDBMoviesListModelProtocol {
    
    typealias TMDBMoviesListFailureBlock = (_ withResponse: AFError?, _ failureStatus: Bool?) -> Void
    typealias TMDBMoviesListSuccessBlock = (_ withResponse: TMDBMoviesList, _ successStatus: Bool?) -> Void
    
    func MoviesList(page:Int, successBlock: @escaping TMDBMoviesListModelProtocol.TMDBMoviesListSuccessBlock, failureBlock: @escaping TMDBMoviesListFailureBlock)
    
}

class TMDBMoviesListModel: NSObject, TMDBMoviesListModelProtocol  {
    
    func MoviesList(page: Int, successBlock: @escaping TMDBMoviesListModelProtocol.TMDBMoviesListSuccessBlock, failureBlock: @escaping TMDBMoviesListFailureBlock) {
        _ = TMDBAlamofire.getRequest(url: URL(string: "\(pathForGetNowPlayingList)\(page)")!, parameters: nil, successBlock: { withResponse, status in
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
            failureBlock(withError, false)
        })
    }
    
}
