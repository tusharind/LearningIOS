import SwiftUI

struct TwitterTabView: View {
    @State private var selectedTab = 0
    @State private var showCreatePostView = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            FeedView()
                .tabItem {
                    Image(systemName: "house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                    Text("Feed")
                }
                .tag(0)
            
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                        .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                    Text("Explore")
                }
                .tag(1)
            
            Text("")
                .tabItem {
                    Image(systemName: "plus")
                        .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
                    Text("Post")
                }
                .tag(2)
            
            CurrentUserProfileView()
                .tabItem {
                    Image(systemName: "person")
                        .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                    Text("Profile")
                }
                .tag(3)
        }
        .onChange(of: selectedTab) { newValue in
            showCreatePostView = (newValue == 2)
        }

        .sheet(
            isPresented: $showCreatePostView,
            onDismiss: { selectedTab = 0 }
        ) {
            CreatePostView()
        }

        .tint(.black)
    }
}

#Preview {
    TwitterTabView()
}

