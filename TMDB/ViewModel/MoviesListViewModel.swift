//
//  MoviesListViewModel.swift
//  TMDB
//
//  Created by Anbusekar Murugesan on 20/02/2022.
//

import Foundation
import Alamofire




class TMDBViewModel {
    
    var model: TMDBMoviesListModel
    var dataSource: TMDBMoviesList?
    
    var searchedmovies: [Movies]?
    
    var moviesList: [Movies] {
        return searchedmovies == nil ? (dataSource?.results ?? []) : (searchedmovies ?? [])
    }
    
    init(Movies: TMDBMoviesListModel) {
        self.model = TMDBMoviesListModel()
    }
    
    func fetchMovies(page: Int, successBlock: @escaping TMDBMoviesListModelProtocol.TMDBMoviesListSuccessBlock, failureBlock: @escaping TMDBMoviesListModelProtocol.TMDBMoviesListFailureBlock) {
        model.MoviesList(page: page) { withResponse, successStatus in
            successBlock(withResponse, successStatus)
        } failureBlock: { withResponse, failureStatus in
            failureBlock(withResponse, failureStatus)
        }
    }
    
}
