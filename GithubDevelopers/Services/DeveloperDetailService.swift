//
//  DeveloperDetailService.swift
//  GithubDevelopers
//
//  Created by Muhammed Elşami on 24.08.2024.
//

import Foundation

class DeveloperDetailService {
    func fetchDeveloperDetail(for username: String, completion: @escaping (DeveloperDetail?) -> Void) {
        let urlString = "https://api.github.com/users/\(username)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let detail = try? JSONDecoder().decode(DeveloperDetail.self, from: data)
                DispatchQueue.main.async {
                    completion(detail)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
