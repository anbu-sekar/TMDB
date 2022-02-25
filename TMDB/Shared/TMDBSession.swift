//
//  TMDBSession.swift
//  TMDB
//
//  Created by Anbusekar Murugesan on 21/02/2022.
//

import UIKit
import Alamofire
import Foundation

// Api keys

let apiKey = "c46467fcbdc5bcb55af459ded44f215f"


// base URL

let baseUrl = "https://api.themoviedb.org/3/movie/"


// poster path url

let moviePostBaseUrl = "https://image.tmdb.org/t/p/w342"
let backdropBaseUrl = "https://image.tmdb.org/t/p/original"


// URL Paths

let pathForGetNowPlayingList = "\(baseUrl)now_playing?api_key=\(apiKey)&page="

let commorError = "Something Went Wrong, Please Try Again Later"

class TMDBAlamofire: NSObject {
    
    static let sharedInstance = TMDBAlamofire()
    
    static var httpHeaders: HTTPHeaders = [:]
    private var manager: Session = Alamofire.Session.default
    
    class func requestFromServer(url: URL, httpMethod: HTTPMethod, parameters: [String: Any]?, encoding: ParameterEncoding, headers: HTTPHeaders?, successBlock: @escaping (_ withResponse: AFDataResponse<Any>?, _ status: Bool?) -> Void, failureBlock: @escaping (_ withError: AFError?, _ cancelStatus: Bool?) -> Void) -> Request {
        func processResponse(_ dataResponse: AFDataResponse<Any>) {
            print(dataResponse)
            
            if dataResponse.error == nil {
                successBlock(dataResponse, true)
                
            } else {//Failure
                //To validate failureblock: pass response and a tuple constructed from            }
                failureBlock(dataResponse.error, false)
            }
        }
        
        return TMDBAlamofire.sharedInstance.manager.request(url, method: httpMethod, parameters: parameters, encoding: encoding, headers: headers).validate().responseJSON { (dataResponse) in
            processResponse(dataResponse)
        }
        
    }
    
    // MARK: - Request Methods

    class func getRequest(url: URL, parameters: [String: Any]?, successBlock: @escaping (_ withResponse: AFDataResponse<Any>?, _ status: Bool?) -> Void, failureBlock: @escaping (_ withError: AFError?, _ cancelStatus: Bool?) -> Void) -> Request {
        return requestFromServer(url: url, httpMethod: .get, parameters: parameters, encoding: JSONEncoding.default, headers: nil, successBlock: successBlock, failureBlock: failureBlock)
    }

}
