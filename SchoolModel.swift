//
//  SchoolModel.swift
//  Wednesday
//
//  Created by 이득령 on 11/14/24.
//

import Foundation

// MARK: - SchInfo
struct SchInfo: Codable {
    let schoolInfo: [SchoolInfo]
}

// MARK: - SchoolInfo
struct SchoolInfo: Codable {
    let head: [Head]?
    let row: [Row]?
}

// MARK: - Head
struct Head: Codable {
    let listTotalCount: Int?
    let result: Result?

    enum CodingKeys: String, CodingKey {
        case listTotalCount = "list_total_count"
        case result = "RESULT"
    }
}

// MARK: - Result
struct Result: Codable {
    let code, message: String

    enum CodingKeys: String, CodingKey {
        case code = "CODE"
        case message = "MESSAGE"
    }
}

// MARK: - Row
struct Row: Codable {
    /// 교육청 코드
    let atptOfcdcScCode: String
    /// 행정코드
    let sdSchulCode: String
    /// 학교이름
    let schulNm: String


    enum CodingKeys: String, CodingKey {
        case atptOfcdcScCode = "ATPT_OFCDC_SC_CODE"
        case sdSchulCode = "SD_SCHUL_CODE"
        case schulNm = "SCHUL_NM"
    }
}
