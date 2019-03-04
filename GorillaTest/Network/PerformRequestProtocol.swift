//
//  PerformRequestProtocol.swift
//  GorillaTest
//
//  Created by Ernesto Gonzalez on 3/3/19.
//  Copyright © 2019 Molekule. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

protocol PerformRequestProtocol {
    func performRequest<T: Decodable>(route: APIConfiguration, completion: @escaping (_ data: T?, _ error: Error?) -> Void)
    func getProductImage(url: URL, completion: @escaping (Data?) -> Void)
}

extension PerformRequestProtocol {

    func performRequest<T>(route: APIConfiguration, completion: @escaping (T?, Error?) -> Void) where T : Decodable {
        Alamofire.request(route).validate(statusCode: 200..<300).validate().responseJSON { response in
            switch response.result {
            case .success:
                do {
                    if let data = response.data {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completion(decodedData, nil)
                    }
                } catch let error {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    func getProductImage(url: URL, completion: @escaping (Data?) -> Void) {
        Alamofire.request(url.absoluteString).responseImage { response in
            completion(response.result.value?.pngData())
        }
    }
}
