//
//  Developer.swift
//  GithubDevelopers
//
//  Created by Muhammed Elşami on 24.08.2024.
//

import Foundation

struct Developer: Identifiable, Decodable {
    let id: Int
    let login: String
    let avatar_url: String
}
