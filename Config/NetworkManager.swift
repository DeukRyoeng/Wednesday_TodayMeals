//
//  NetworkManager.swift
//  Wednesday
//
//  Created by 이득령 on 11/14/24.
//

import Foundation
import RxSwift
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    //MARK: - Alamofire 사용
    func fetch<T: Decodable>(endpoint: Endpoint) -> Single<T> {
        return Single.create {observer in
            AF.request(endpoint.createURL()!, parameters: endpoint.queryParameters)
                .validate() //응답을 검증함
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let data):
                        observer(.success(data))
                        print("디코딩 성공")
//                        if let json = response.value {
//                            print("응답받은 데이터\(json)")
//                        }
                    case .failure(let error):
                        observer(.failure(error))
                        print("디코딩 실패")
                    }
                }
            return Disposables.create()
        }
    }
}

