//
//  QuizItemRowView.swift
//  QuizSwift_parte1
//
//  Created by c142 DIT UPM on 22/11/23.
//

import SwiftUI

struct QuizItemRowView: View {
    var quizItem: QuizItem
        var body: some View {
            //Image(quizItem.favourite ? "star_yellow" : "star_gray")
            //Image(quizItem.favourite ? "star_yellow" : "star_gray")
            // Imagen quiz

            //HStack( spacing: 20) {
            // HStack(alignment: .center, spacing: 20) {



                // AsyncImage(url: ( quizItem.attachment?.url))
                //     .frame(width: 200, height: 80)
                //     .clipped()
                //     .border(Color.black, width: 3)
                //     .clipShape(Circle())

            
                HStack (alignment: .center) {
               
                    
                    ZStack{
                        
                        EasyAsyncImage(url: quizItem.attachment?.url)
                            .frame(width: 70, height: 70)
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/))
                            .shadow(color: .black, radius: 5, x: 0.0, y: 0.0)
                            //.resizable()
                            .scaledToFit()
                            .padding()
                            //.scaleEffect(2.0)
                        
                        EasyAsyncImage(url: quizItem.author?.photo?.url)
                            .frame(width: 30, height: 30)
                            .scaledToFill()
                            .clipShape(Circle())
                            //.resizable()
                            .overlay{
                                Circle()
                                    .stroke(Color.white, lineWidth: 0.5)
                            }
                            .shadow(color: .gray, radius: 4.5, x: 2, y: 0.0)
                            .frame(width: 90, height: 90, alignment: .bottomTrailing )
                        
                    }
                    Text(quizItem.question)
                        .lineLimit(3) //puede que este mal
                        .font( .system(size: 18))
                        .fontWeight(.bold)
                    
                    Spacer()
                        
                    Image(quizItem.favourite ? "star_yellow" : "estrella_blanca")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding()
                    
                }
                

                


            }
            //.background(Color.cPrincipal)
            //.preferredColorScheme(UIColor(named: "CSec"))
            
        }
//}

#Preview {
    var model: QuizzesModel = {
            let m = QuizzesModel()
            m.load()
            return m
        } ()
    return QuizItemRowView(quizItem: model.quizzes[0])
        // return NavigationStack {
        //     QuizItemPlayView(quizItem: model.quizzes[0])
        // }
        // return QuizzItemPlayView(quizItem: model.quizzes[0])
}
