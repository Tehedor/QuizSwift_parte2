//
//  QuizItemPlayView.swift
//  QuizSwift_parte1
//
//  Created by c142 DIT UPM on 22/11/23.
//

import SwiftUI

struct QuizItemPlayView: View {
    @Environment(QuizzesModel.self) var quizzesModel
    
    // @Environment (./verticalSizeClase') var verticalSizeClase
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment (ScoresModel.self) var scoresModel
    // @Environment (ScoresModel.self) var scoresModel
    // @EnvironmentObject (ScoresModel.self) var scoresModel

    
    var quizItem: QuizItem

    @State var answer: String = ""

    @State var showCheckAlert = false
    
    @State var errorMsg = "" {
        didSet{ //no se si es didlet
            showErrorMsgAlert = true
        }
    }

    @State var showErrorMsgAlert = false

    @State var chekingResponse = false
            
    @State var answerIsOk = false

    var body: some View {

            //Image(quizItem.favourite ? "star_yellow" : "star_gray")
            // Imagen quiz


        VStack {
            titulo
            if  verticalSizeClass == .compact {
                HStack(spacing:10) {
                    adjunto
                    VStack{
                        Spacer()
                        pregunta
                        Spacer()
                        HStack{

                            puntos
                            Spacer()
                            autor
                        }
                    }
                }
            }else {
                VStack {
                    Spacer()
                    pregunta
                    Spacer()
                    adjunto
                    Spacer()
                    HStack {
                        puntos
                        Spacer()
                        autor
                    }
                }
                .alert("Resultado", isPresented: $showCheckAlert){
                }message: {
                    Text("Buena")
                }
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline) // da error pero con el error queda huapo
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack{
                    Spacer()
                    Text("Play Quiz")
                        //.font(.headline)
                        .foregroundStyle(.black)
                        //.fontWidth(.expanded)
                        .font(.system(size: 40))
                        .bold()
                        //.frame(width: 200, height: 50, alignment: .center)
                    Spacer()
                }
                
            }
        }        .background(Color.cPrincipal)
    }


    private var puntos: some View {
        Text("Score: \(scoresModel.acertadas.count)")
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(Color.gray)
    }


    private var pregunta: some View {

           VStack {
               TextField("Introduce tu respuesta", text: $answer)
                   .textFieldStyle(.roundedBorder)
                   .onSubmit {
                       Task {
                           await checkResponse()
                       }
                       //showCheckAlert = true
                   }
               if chekingResponse {
                   ProgressView()
               }else {
                   Button("Comprobar"){
                       //await checkResponse()
                       // checkResponse()
                   }
               }
           }
           .alert("Resultado" ,isPresented: $showCheckAlert) {
               // Si no pones un botton te pone uno por defecto con ok dentro
           } message: {
               // Text(answer == quizItem.answer ? "Correcto" : "Ere un pelele")
               Text(answerIsOk ? "Correcto" : "Ere un pelele")
           }
       }

       private var titulo: some View {
           HStack  {
               Text(quizItem.question)
                   .font(.title)
                   .fontWeight(.bold)
               Spacer()
               Button{
                   Task{ // Al poner una funcion asincrona
                       do {
                           try await  quizzesModel.toggleFavourite(quizItem: quizItem)
                        } catch {
                            errorMsg = error.localizedDescription
                        }

                    }
               }label: {
                   Image(quizItem.favourite ? "star_yellow" : "estrella_blanca")
                       .resizable()
                       .frame(width: 20, height: 20)
               }
               
           }

       }
    
    @State var scale = 1.0
    
    private var adjunto: some View{
           GeometryReader { g in
               EasyAsyncImage(url: quizItem.attachment?.url)
                   .saturation(showCheckAlert ? 0 : 1)
                   
                   .rotationEffect(Angle(degrees:
                       showCheckAlert ? 180 : 0))
                   .animation(.easeInOut, value: showCheckAlert)
                   .scaledToFill()
                   .frame(width: g.size.width, height: g.size.height) //mirar orden si distorsiona
                   .clipShape(RoundedRectangle(cornerRadius: 10))
                   // .clippedShape(RoundedRectangle(cornerRadius: 10))
                   // .frame(width: g.size.width, height: g.size.height)
                   .contentShape(RoundedRectangle(cornerRadius: 10)) // Para que se pueda en el boton y no se solape la imagen
                   .overlay{
                       RoundedRectangle(cornerRadius: 10)
                           .stroke(Color.cPrincipal, lineWidth: 2)
                   }
                   .shadow(color: .black, radius: 5, x: 0.0, y: 0.0)
                   .scaleEffect(scale)
                   .onTapGesture {
                       let ac = "logrado"
                       
                       answer = ac
                       
                       withAnimation {
                           scale = 1.5 - scale
                       } completion: {
                           scale = 1.5 - scale
                       }
                   }
           }
       }
    private var autor: some View {
        HStack {
        //HStack (alignment: .trailing) {
            Spacer()
            Text(quizItem.author?.username ??
                 quizItem.author?.profileName ??
                 "Anónimo" )
            EasyAsyncImage(url: quizItem.author?.photo?.url)
                .frame(width: 30, height: 30)
                .scaledToFill()
                .clipShape(Circle())
                .overlay{
                    Circle()
                        .stroke(Color.gray, lineWidth: 2)
                    }
                .shadow(color: .black, radius: 5, x: 0.0, y: 0.0)
                   // Poner la imagen a la derecha
                .contextMenu (menuItems:{
                    Button{
                        answer = ""
                    } label: {
                        Label("Limpiar", systemImage: "x.circle")
                    }
                    Button{
                        answer = "pepe" //Aqui tendremos que poner la solución
                    } label: {
                        Label("Solución", systemImage: "figura.kickboxing")
                    }
                })
                Text("Autor: \(quizItem.author?.username ?? "Anónimo")")
           }
       }
    func checkResponse() async  {
                
        do{
            chekingResponse = true
                
            //answerIsOk = try await quizzesModel.check(quizItem: quizItem, answer: answer)
            
            answerIsOk =  try await quizzesModel.check(quizItem: quizItem, answer: answer)
            
            showCheckAlert = true

            if answerIsOk {
                scoresModel.add(quizItem: quizItem)
            }
                    
            chekingResponse = false

        } catch {
                errorMsg = error.localizedDescription
        }
    //return ok
    }
    
    

   }
/*
 #Preview {
      let qm =  QuizzesModel()
           // var m = QuizzesModel()
       qm.download()
       let sm = ScoresModel()


       // return QuizzItemPlayView(quizItem: model.quizzes[0])
       return NavigationStack {
           QuizItemPlayView(quizItem: qm.quizzes[4])
               .environment(sm)
       }
       // return QuizzItemPlayView(quizItem: model.quizzes[0])
}*/





#Preview {
    @State var qm =  QuizzesModel()
        // var m = QuizzesModel()
    @State var em = "kkkS"

    Task {
        do {
            try? await qm.download()
        } catch {
            em = error.localizedDescription
        }

    }
    
    //qm.download()
    @State var sm = ScoresModel()


    // return QuizzItemPlayView(quizItem: model.quizzes[0])
    return NavigationStack {
        QuizItemPlayView(quizItem: qm.quizzes[4])
            .environment(sm)
    }
    // return QuizzItemPlayView(quizItem: model.quizzes[0])
}
