import SwiftUI
import Kingfisher

struct ArticleDetailView: View {
    
    @ObservedObject var viewModel: NewsViewModel
    let article: Article
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Article image with a nice rounded style (Kingfisher)
                if let urlStr = article.urlToImage,
                   let url = URL(string: urlStr) {
                    KFImage(url)
                        .placeholder {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 220)
                                ProgressView()
                            }
                        }
                        .cancelOnDisappear(true)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 220)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(16)
                        .shadow(radius: 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray.opacity(0.1), lineWidth: 0.5)
                        )
                }
                
                // Article content section
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Title
                    Text(article.title.trimmingCharacters(in: .whitespacesAndNewlines))
                        .font(.title)
                        .fontWeight(.semibold)
                        .lineSpacing(4)
                    
                    // Description if available
                    if let desc = article.description,
                       !desc.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Text(desc.trimmingCharacters(in: .whitespacesAndNewlines))
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineSpacing(3)
                    }
                    
                    // Action buttons
                    HStack(spacing: 16) {
                        
                        // Bookmark toggle
                        Button {
                            viewModel.toggleBookmark(article)
                        } label: {
                            Label(
                                viewModel.isBookmarked(article) ? "Bookmarked" : "Bookmark",
                                systemImage: viewModel.isBookmarked(article) ? "bookmark.fill" : "bookmark"
                            )
                            .font(.callout.bold())
                            .padding(.vertical, 10)
                            .padding(.horizontal, 18)
                            .background(viewModel.isBookmarked(article) ? Color.green : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 2)
                        }
                        
                        Spacer()
                        
                        // External link
                        if let url = URL(string: article.url) {
                            Link(destination: url) {
                                Label("Read More", systemImage: "arrow.up.right.square")
                                    .font(.callout.bold())
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 18)
                                    .background(Color.orange.opacity(0.9))
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                    .shadow(radius: 2)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .navigationTitle("Article")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
}
