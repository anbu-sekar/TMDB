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

let moviePostBaseUrl = "https://image.tmdb.org/t/p/w342/"
let backdropBaseUrl = "https://image.tmdb.org/t/p/original"


// URL Paths

let pathForGetNowPlayingList = "\(baseUrl)now_playing?api_key=\(apiKey)"



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

//
//protocol TMDBModelProtocol {
//    typealias SuccessBlock = (_ withResponse: DataResponse<Any>?, _ successStatus: Bool?) -> Void
//    typealias FailureBlock = (_ withResponse: DataResponse<Any>?, _ successStatus: Bool?) -> Void
//}
//
//
//class TMDBsession: NSObject, TMDBModelProtocol {
//
//    @discardableResult class func request(url: URL, httpMethod: HTTPMethod, parameters: [String: Any]?, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders?, successBlock: @escaping SuccessBlock, failureBlock: @escaping FailureBlock) -> DataRequest? {
//        return AF.request(url, method: httpMethod, parameters: parameters, encoding: encoding, headers: headers).validate().responseJSON { (response) in
//            if response.error == nil {
//                successBlock(response, true)
//            } else {
//                let error = response.error?.underlyingError
//                let afError = error?.asAFError
//                if let error = afError {
//                    switch error {
//                    case .requestRetryFailed(_, _):
//                        failureBlock(response, false)
//                        break
//                    case .explicitlyCancelled:
//                        failureBlock(response, true)
//                        break
//                    default:
//                        failureBlock(response, false)
//                        break
//                    }
//                } else {
//                    failureBlock(response, false)
//                }
//            }
//
//        }
//    }
//
//    class func requestFromServer(url: URL, httpMethod: HTTPMethod, parameters: [String: Any]?, encoding: ParameterEncoding, headers: HTTPHeaders?, successBlock: @escaping (_ withResponse: DataResponse<Any>?, _ status: Bool?) -> Void, failureBlock: @escaping (_ withError: AFError?, _ cancelStatus: Bool?) -> Void) -> Request {
//
//    }
//
//    @discardableResult class func decodableRequest<T: Decodable>(url: URL, httpMethod: HTTPMethod, parameters: [String: Any]?, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders?, successBlock: @escaping ((AFDataResponse<T>?, Bool?) -> Void), failureBlock: @escaping ((AFDataResponse<T>?, AFError?, Bool) -> Void)) -> DataRequest? {
//        return AF.request(url, method: httpMethod, parameters: parameters, encoding: encoding, headers: headers).validate().responseDecodable { (response: AFDataResponse<T>) in
//            if response.error == nil {
//                successBlock(response, true)
//            } else {
//                let error = response.error?.underlyingError
//                let afError = error?.asAFError
//                if let error = afError {
//                    switch error {
//                    case .requestRetryFailed(_, _):
//                        failureBlock(response, nil, false)
//                        break
//                    case .explicitlyCancelled:
//                        failureBlock(response, nil, true)
//                         break
//                    default:
//                        failureBlock(response, nil, false)
//                        break
//                    }
//                } else {
//                        failureBlock(response, nil, false)
//                }
//            }
//        }
//    }
//
//
//
//    // MARK:- Decodable response request methods
//
//    @discardableResult class func getRequest<T: Decodable>(url: URL, parameters: [String: Any]? = nil, successBlock: @escaping ((AFDataResponse<T>?, Bool?) -> Void), failureBlock: @escaping ((AFDataResponse<T>?, AFError?, Bool) -> Void)) -> DataRequest? {
//        return decodableRequest(url: url, httpMethod: .get, parameters: parameters, headers: nil, successBlock: successBlock, failureBlock: failureBlock)
//    }
//
//
//    // MARK: - JSON response request methods
//
//    @discardableResult class func getRequest(url: URL, parameters: [String: Any]? = nil, successBlock: @escaping SuccessBlock, failureBlock: @escaping FailureBlock) -> DataRequest? {
//        return request(url: url, httpMethod: .get, parameters: parameters, headers: nil, successBlock: successBlock, failureBlock: failureBlock)
//    }
//
//
//
//}
//
//
