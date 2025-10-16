import SwiftUI

struct UserContentListView: View {
    @StateObject var viewModel: UserContentListViewModel
    @State private var selectedFilter: ProfileTweetFilter = .tweets
    @Namespace var animation

    init(user: User) {
        self._viewModel = StateObject(
            wrappedValue: UserContentListViewModel(user: user)
        )
    }
    var body: some View {
        //user content list view
        VStack {
            HStack {
                ForEach(ProfileTweetFilter.allCases) { filter in
                    VStack {
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(
                                selectedFilter == filter ? .semibold : .regular
                            )

                        if selectedFilter == filter {
                            Rectangle()
                                .foregroundColor(.black)
                                .frame(width: 180, height: 1)
                                .matchedGeometryEffect(
                                    id: "item",
                                    in: animation
                                )
                        } else {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 180, height: 1)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedFilter = filter
                        }
                    }
                }
            }
            LazyVStack {
                ForEach(viewModel.tweets) { tweet in
                    ThreadCell(tweet: tweet)
                }
            }
        }
        .padding(.vertical, 8)
    }
}
