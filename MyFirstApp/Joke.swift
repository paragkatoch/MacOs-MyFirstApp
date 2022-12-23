//
//  Joke.swift
//  MyFirstApp
//
//  Created by Parag Katoch on 23/12/22.
//

import Foundation

struct Joke: Codable {
    let status: Int
    let response: String
    let joke: String
    let type: String
}
