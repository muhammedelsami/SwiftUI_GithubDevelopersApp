//
//  DeveloperDetailView.swift
//  GithubDevelopers
//
//  Created by Muhammed Elşami on 19.08.2024.
//

import SwiftUI

struct DeveloperDetailView: View {
    @StateObject private var viewModel: DeveloperDetailViewModel

    init(username: String) {
        _viewModel = StateObject(wrappedValue: DeveloperDetailViewModel(username: username))
    }

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            VStack {
                
                if let developerDetail = viewModel.developerDetail {
                    AsyncImage(url: URL(string: developerDetail.avatar_url)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding()
                    
                    Text(developerDetail.name ?? "No Name")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                    
                    Text("Location: \(developerDetail.location ?? "Unknown")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("Company: \(developerDetail.company ?? "No Company")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("Bio: \(developerDetail.bio ?? "No Bio")")
                        .font(.body)
                        .foregroundColor(.white)
                        .padding()
                    
                    HStack(spacing: 20) {
                        VStack {
                            Text("Repositories")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Text("\(developerDetail.public_repos)")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8.0)
                                .fill(Color.white.opacity(0.3))
                        )
                        
                        VStack {
                            Text("Gists")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Text("\(developerDetail.public_gists)")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8.0)
                                .fill(Color.white.opacity(0.3))
                        )
                        
                        VStack {
                            Text("Followers")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Text("\(developerDetail.followers)")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8.0)
                                .fill(Color.white.opacity(0.3))
                        )
                    }
                    .padding(.top, 10)
                    
                    if let blog = developerDetail.blog, !blog.isEmpty {
                        let formattedBlogURL = viewModel.formatURL(blog)
                        Link("Visit Blog", destination: URL(string: formattedBlogURL)!)
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 5.0)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            .padding(.top, 10)
                    }
                    
                    Text("Created at: \(viewModel.formatDate(developerDetail.created_at))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                    
                    Text("Updated at: \(viewModel.formatDate(developerDetail.updated_at))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                    
                    HStack {
                        Link("GitHub Profile", destination: URL(string: developerDetail.html_url)!)
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    
                    Spacer()
                } else if viewModel.isLoading {
                    ProgressView("Loading...")
                }
            }
            .onAppear {
                viewModel.fetchDeveloperDetail()
            }
            .padding()
        }
    }
}

#Preview {
    DeveloperDetailView(username: "muhammedelsami")
}
