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
    
    init(Movies: TMDBMoviesListModel) {
        self.model = TMDBMoviesListModel()
    }
    
    func fetchMovies(successBlock: @escaping TMDBMoviesListModelProtocol.SuccessBlock, failureBlock: @escaping TMDBMoviesListModelProtocol.FailureBlock) {
        model.MoviesList { withResponse, successStatus in
            successBlock(withResponse, successStatus)
        } failureBlock: { withResponse, failureStatus in
            failureBlock(withResponse, failureStatus)
        }
    }

}
