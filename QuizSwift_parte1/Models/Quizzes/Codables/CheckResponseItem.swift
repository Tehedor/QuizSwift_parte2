//
//  CheckResponseItem.swift
//  QuizSwift_parte1
//
//  Created by c142 DIT UPM on 11/12/23.
//

import Foundation

struct CkeckResponseItem: Codable{
    
    let quizId: Int
    let answer: String
    let result: Bool

}
