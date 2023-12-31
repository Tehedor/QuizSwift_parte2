//
//  QuizzesModel.swift
//  P4.1 Quiz
//
//  Created by Santiago Pavón Gómez on 11/9/23.
//

import Foundation

@Observable class QuizzesModel {
    
    // Los datos
    private(set) var quizzes = [QuizItem]()
    
    func download() async throws {
        do {
            // guard let jsonURL = Bundle.main.url(forResource: "quizzes", withExtension: "json") else {
            //throw "Internal error: No encuentro quizzes.json"
            guard let jsonURL = Endpoints.random10() else {
                throw "Fallos en la creacion de la api"
            }
            let (data, response) = try await URLSession.shared.data(from: jsonURL)
            
            //let (data, response) = try await URLSession.shared.data(from: url)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw "No bebes No quizzes"
            }
            
            //let data = try Data(contentsOf: jsonURL)
            
            // print("Quizzes ==>", String(data: data, encoding: String.Encoding.utf8) ?? "JSON incorrecto")
            
            guard let quizzes = try? JSONDecoder().decode([QuizItem].self, from: data)  else {
                        throw "Error: recibidos datos corruptos."
            }
            print(quizzes)
            self.quizzes = quizzes
            
            print("Quizzes cargados")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func check(quizItem: QuizItem, answer: String) async throws -> Bool {
           // Puedo poner todas  las guardas separadas por comas
           guard let url = Endpoints.checkAnswer(quizItem:quizItem, answer: answer) else {
               throw "No puedo comprobar la respuesta"
           }

           let (data, response) = try await URLSession.shared.data(from: url)

           guard (response as? HTTPURLResponse)?.statusCode == 200 else {
               throw "No bebes No quizzes"
           }

        
        print(data)
        
        guard let res = try? JSONDecoder().decode(CkeckResponseItem.self, from: data) else {
            throw "Error: recibidos datos corruptos."
        }

        return res.result
        
    }
    
    func toggleFavourite(quizItem: QuizItem) async throws {
        guard let url = Endpoints.toggleFav(quizItem: quizItem) else {
            throw "No puedo comprobar la respuesta"
        }

        var request = URLRequest(url: url)

        request.httpMethod = quizItem.favourite ? "DELETE" : "PUT"

        let (data, response) = try await URLSession.shared.data(for: request)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw "No bebes No quizzes"
        }

        guard let res = try? JSONDecoder().decode(FavoriteSatusItem.self, from: data)  else {
            throw "Error: recibidos datos corruptos."
        }
    
        
        guard let index = quizzes.firstIndex(where: {qi in qi.id == quizItem.id}) else {
            throw "ufffffffffffff"
        }
        
        quizzes[index].favourite = res.favourite

    }
    
    func showAnswer(quizItem: QuizItem) async throws -> String {
        guard let url = Endpoints.showAnswer(quizItem: quizItem) else {
            throw "No puedo comprobar la anserrrrrrrr"
        }
        
        var request = URLRequest(url: url)

        request.httpMethod = "GET"

        let (data, response) = try await URLSession.shared.data(for: request)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "No bebes No quizzes"
        }

        guard let res = try? JSONDecoder().decode(AnswerItem.self, from: data)  else {
            throw "Error: recibidos datos corruptos."
        }
        
        return res.answer
        
        
    }
}

extension String: Error{}


extension String: LocalizedError {
    public var errorDescription: String? {
        return self
    }
}
