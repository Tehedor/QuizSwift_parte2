//
//  ScoresModel.swift
//  QuizSwift_parte1
//
//  Created by c142 DIT UPM on 22/11/23.
//

import Foundation

@Observable class ScoresModel {

    var acertadas: Set<Int> = []

    func check(quizItem: QuizItem, answer: String) {

        if answer =+-= quizItem.answer  {
        // if answer == quizItem.answer  {
            acertadas.insert(quizItem.id)
        }
        // return acertadas
    }

// Añadir label para poner un icono al lado de los puntos en QuizItemPlay
// tambien puedo añadir un context menu para que al pulsar se abra un menu con opciones .contextMenu
}


// extension String: LocalizedError {
//     public var errorDescription: String? {
//         return self
//     }
// }
