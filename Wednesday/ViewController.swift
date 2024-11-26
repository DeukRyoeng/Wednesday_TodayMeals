//
//  ViewController.swift
//  Wednesday
//
//  Created by 이득령 on 11/14/24.
//

import UIKit
import RxSwift
import SnapKit

class ViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let TestButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Click Me", for: .normal) // 버튼 텍스트 설정
        button.setTitleColor(.white, for: .normal) // 텍스트 색상 설정
        button.backgroundColor = .systemBlue // 배경 색상 설정
        button.layer.cornerRadius = 10 // 버튼 모서리 둥글게
        
        return button
    }()
    let searchVM = Sch_SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        view.backgroundColor = .white
        print("called ViewController - run App")
        
        view.addSubview(TestButton)
        TestButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
        
        TestButton.addTarget(self, action: #selector(buttontapped), for: .touchUpInside)
    }
    
    @objc private func buttontapped() {
        bindViewModel()
    }
    
    private func bindViewModel() {
        searchVM.fetchSchool_search(schoolNM: "대중예술")
        searchVM.school_Info
            .subscribe(onNext: { rows in
                for row in rows {
                    print("학교이름\(row.schulNm), 교육청코드\(row.atptOfcdcScCode), 행정코드\(row.sdSchulCode)")
                }
                
            })
            .disposed(by: disposeBag)
    }
    
}

