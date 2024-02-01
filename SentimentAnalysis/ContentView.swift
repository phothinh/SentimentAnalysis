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
}

extension Sentiment {
    func getColor() -> Color {
        switch (self) {
        case .positive:
            return .green
        case .negative:
            return .red
        case .mixed:
            return .purple
        case .neutral:
            return .gray
        }
    }
    
    func getEmoji() -> String {
        switch (self) {
        case .positive:
            return "😀"
        case .negative:
            return "👹"
        case .mixed:
            return "🥴"
        case .neutral:
            return "🫥"
        }
    }
}

struct ContentView: View {
    @State var modelInput: String = ""
    @State var modelOutput: String = ""
    @State var outputSentiment: Sentiment? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Entrez votre phrase, l'IA s'occupe du reste")
                        .fontWeight(.bold)
                        .fontDesign(.monospaced)
                        .foregroundStyle(.white)
                    
                    TextEditor(text: $modelInput).onChange(of: modelInput, {
                        oldValue, newValue in outputSentiment = nil
                    }).frame(height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Button(action: {
                        classify()
                    }, label: {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("Deviner le sentiment")
                        }.padding()
                    })
                    .buttonStyle(BorderedProminentButtonStyle())
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    
                }.padding()
                    .background(Color.purple.gradient.opacity(0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                
                VStack {
                    Text(outputSentiment?.getEmoji() ?? "")
                    Text(outputSentiment?.rawValue ?? "")
                }.frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(outputSentiment?.getColor().gradient ?? Color.blue.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 18.0))
                    .opacity(outputSentiment == nil ? 0 : 1.0)
                    .scaleEffect(outputSentiment == nil ? 0.3 : 1.0)
                    .animation(.bouncy, value: outputSentiment)
                Spacer()
            }
            .navigationTitle("🧠 IA du football")
            .padding()
        }
    }
    
    func classify() {
        do {
            // MyModel est une classe générée automatiquement par Xcode
            let model = try SentimentAnalysis_1(configuration: .init())
            let prediction = try model.prediction(text: modelInput)
            modelOutput = prediction.label
            outputSentiment = Sentiment(rawValue: modelOutput)
        } catch {
            modelOutput = "Something went wrong"
        }
    }
}

#Preview {
    ContentView()
}
