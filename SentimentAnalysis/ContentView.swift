//
//  ContentView.swift
//  SentimentAnalysis
//
//  Created by PHOTHINANTHA Henri on 10/01/2024.
//

import SwiftUI

enum Sentiment: String {
    case positive = "POSITIVE"
    case negative = "NEGATIVE"
    case mixed = "MIXED"
    case neutral = "NEUTRAL"
    
    func getColor() -> Color {
        switch(self) {
        case .positive:
            return Color.green
        case .negative:
            return Color.red
        case .mixed:
            return Color.purple
        case .neutral:
            return Color.gray
        }
    }
    
    func getEmoji() -> String {
        switch(self) {
        case .positive:
            return "emoji content"
        case .negative:
            return "emoji pas content"
        case .mixed:
            return "emoji réfléchissant"
        case .neutral:
            return "emoji neutre"
        }
    }
}



struct ContentView: View {
    @State var modelInput: String = ""
    @State var outputSentiment: Sentiment?
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Text("Entrez une phrase, l'IA va deviner votre sentiment")
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .foregroundStyle(.white)
                    
                    TextEditor(text: $modelInput)
                        .onChange(of: modelInput, { oldValue, newValue in
                            outputSentiment = nil
                        }).frame(height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    
                    Button {
                        
                    } label: {
                        Text("Deviner le sentiment")
                    }.padding()
                    
                }
                .padding()
                .background(Color.purple.gradient)
                
                
                
                VStack {
//                    Text(outputSentiment?.getEmoji() ?? "")
                    Text(outputSentiment?.rawValue ?? "")
                }.padding()
                .background(Color.blue.gradient)

                
            }
            .navigationTitle("IA du futur")
            
            
        }
        
    }
}



#Preview {
    ContentView()
}
