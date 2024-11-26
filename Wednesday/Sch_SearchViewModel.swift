//
//  Sch_SearchView.swift
//  Wednesday
//
//  Created by 이득령 on 11/14/24.
//

import UIKit
import RxSwift

class Sch_SearchViewModel: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    let network = NetworkManager.shared
    let school_Info = BehaviorSubject<[Row]>(value: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        print("called Sch_SearchView")
        
    }
    func fetchSchool_search(schoolNM: String) {
        let endpoint = Endpoint(
            baseURL: "https://open.neis.go.kr",
            path: "/hub/schoolInfo",
            queryParameters: [
                "Type": "json",
                "pIndex": "1",
                "pSize": "100",
                "KEY": "52cd87c2167c4123973b0ef7b28fce02",
                "SCHUL_NM": "\(schoolNM)"
            ])
        network.fetch(endpoint: endpoint)
            .map { (response: SchInfo) -> [Row] in
                //필요한 Row만 추출
                let validRows = response.schoolInfo.compactMap { $0.row }.flatMap { $0 }
                return validRows
            }
            .subscribe(onSuccess: {[weak self] rows in
    
                self?.school_Info.onNext(rows)
                print("success")
            },onFailure: { error in
                print("failure \(error)")
            })
            .disposed(by: disposeBag)
    }
}
