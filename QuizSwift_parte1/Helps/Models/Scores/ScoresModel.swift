//
//  ScoresModel.swift
//  QuizSwift_parte1
//
//  Created by c142 DIT UPM on 22/11/23.
//

import Foundation

@Observable class ScoresModel {

    var acertadas: Set<Int> = []
    var record: Set<Int> = []
    
    init() {
        let a = UserDefaults.standard.object(forKey: "record") as? [Int] ?? []
        
        record = Set(a)
        
    }
    
    
    // ya no se usa
    func check(quizItem: QuizItem, answer: String) {

        //if answer =+-= quizItem.answer  {
        //    acertadas.insert(quizItem.id)
        //}
    }
    
    func add(quizItem: QuizItem){
        acertadas.insert(quizItem.id)
        
        
        record.insert(quizItem.id)
        
        UserDefaults.standard.set(Array(record), forKey: "record")
        //UserDefaults.standard.sincronize()
        
        
    }
    
    func cleanup() {
        acertadas = []
    }
    
    func pendiente(_ quizItem: QuizItem) -> Bool {
        return !acertadas.contains(quizItem.id)
    }

// Añadir label para poner un icono al lado de los puntos en QuizItemPlay
// tambien puedo añadir un context menu para que al pulsar se abra un menu con opciones .contextMenu
}


// extension String: LocalizedError {
//     public var errorDescription: String? {
//         return self
//     }
// }
