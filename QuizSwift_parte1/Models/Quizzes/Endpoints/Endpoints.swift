//
//  Endpoints.swift
//  QuizSwift_parte1
//
//  Created by c142 DIT UPM on 11/12/23.
//

import Foundation

let urlBase = "http://quiz.dit.upm.es"

let token = "3509f8010c0bfe8feed0"

struct Endpoints {

    static func random10() -> URL? {
        let path = "/api/quizzes/random10"
        let str = "\(urlBase)\(path)?token=\(token)"
        return URL(string: str)
    }

    static func checkAnswer(quizItem: QuizItem, answer: String) -> URL? {
        
        let path = "/api/quizzes/\(quizItem.id)/check" // \() interpolación de swift \()
        
        guard let escapedAnswer = answer.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed) else {return nil}

        let str = "\(urlBase)\(path)?answer=\(escapedAnswer)&token=\(token)"
        return URL(string: str)
    }

    static func toggleFav(quizItem:  QuizItem) -> URL? {
        
        let path = "/api/users/tokenOwner/favourites/\(quizItem.id)"
    
        let str = "\(urlBase)\(path)?\(token)"
        
        return URL(string: str)
    
    }

}
