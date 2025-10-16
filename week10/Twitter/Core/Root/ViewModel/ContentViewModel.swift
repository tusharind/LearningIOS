import Combine
import FirebaseAuth
import Foundation

class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()

    init() {
        setUpSubscribers()
    }

    private func setUpSubscribers() {
        AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancellables)
    }

}
