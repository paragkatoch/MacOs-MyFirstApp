//
//  ContentView.swift
//  MyFirstApp
//
//  Created by Parag Katoch on 23/12/22.
//

import SwiftUI

struct JokeView: View {
    @State private var jokeString = "No Joke Available"
    @State private var fetching = false
    
    @AppStorage("jokeType") var jokeType: JokeType = .dadjoke
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image("StewartLynch")
                    .resizable()
                    .frame(width: 60, height: 60)
                
                VStack {
                    ForEach(JokeType.allCases, id: \.self) {
                        item in Button {
                            jokeType = item
                            Task {
                                await getJoke(type: jokeType.type)
                            }
                        } label: {
                            Text(item.rawValue)
                                .foregroundColor(item == jokeType ? .red : Color.primary)
                        }
                    }
                }
                .frame(height: 130)
            }
            
            if fetching {
                ProgressView()
            } else {
                Text(jokeString).minimumScaleFactor(0.5)
            }
            
            Spacer()
        }
        .padding()
        .task {
            await getJoke(type: jokeType.type)
        }
    }
    
    func getJoke(type: String) async {
        let url = "https://jokes.guyliangilsing.me/retrieveJokes.php?type=\(type)"
        let apiService = APIService(urlString: url)
        
        fetching.toggle()
        
        defer {
            fetching.toggle()
        }
        do {
            let joke: Joke = try await apiService.getJSON()
            jokeString = joke.joke
        } catch {
            print(error)
            jokeString = error.localizedDescription + "yes"
        }
    }
    
}

struct JokeView_Previews: PreviewProvider {
    static var previews: some View {
        JokeView().frame(width: 225, height: 225)
    }
}
