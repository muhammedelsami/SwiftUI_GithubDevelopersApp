//
//  ListingViewModel.swift
//  GithubDevelopers
//
//  Created by Muhammed Elşami on 24.08.2024.
//

import Foundation
import SwiftUI

class ListingViewModel: ObservableObject {
    @Published var developers: [Developer] = []
    @Published var isGridView: Bool = false
    @Published var isLoading: Bool = false
    @Published var totalDevelopers: Int = 0

    var currentPage = 1
    private let city: String
    private let count = 20

    init(city: String) {
        self.city = city
        fetchDevelopers(page: currentPage)
    }

    func fetchDevelopers(page: Int) {
        let urlString = "https://api.github.com/search/users?q=location:\(city)&page=\(page)&per_page=\(count)"
        guard let url = URL(string: urlString) else { return }

        isLoading = true
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            if let data = data {
                if let response = try? JSONDecoder().decode(GitHubResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.developers.append(contentsOf: response.items)
                        self.totalDevelopers = response.total_count
                    }
                }
            }
        }.resume()
    }

    func loadMoreDevelopers() {
        currentPage += 1
        fetchDevelopers(page: currentPage)
    }

    func toggleViewMode() {
        isGridView.toggle()
    }
}

