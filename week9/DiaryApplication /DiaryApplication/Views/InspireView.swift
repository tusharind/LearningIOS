import SwiftUI

/// View that displays an inspirational quote of the day
struct InspireView: View {
    
    // MARK: - ViewModel
    @StateObject private var vm = InspireViewModel()
    
    // MARK: - Body
    var body: some View {
        ZStack {
            
            // MARK: - Background
            Color("Background")
                .ignoresSafeArea()
            
            // MARK: - Loading State
            if vm.isLoading && vm.quoteText.isEmpty {
                ProgressView()
                    .scaleEffect(1.5)
                    .tint(Color("AccentColor"))
                
            // MARK: - Error State
            } else if let error = vm.errorMessage, vm.quoteText.isEmpty {
                VStack(spacing: 12) {
                    Text("Error")
                        .font(.title)
                        .foregroundColor(Color("TextPrimary"))
                    
                    Text(error)
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(Color("TextSecondary"))
                    
                    Button("Try Again") {
                        vm.fetchQuote()
                    }
                    .padding(.top, 6)
                    .buttonStyle(.borderedProminent)
                    .tint(Color("AccentColor"))
                }
                .padding()
            
            // MARK: - Content State
            } else {
                ScrollView {
                    VStack(spacing: 30) {
                        
                        // Quote Text
                        Text("“\(vm.quoteText)”")
                            .font(.system(size: 48, weight: .bold))
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.5)
                            .padding()
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color.blue, Color.purple, Color.pink],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        
                        // Author (if available)
                        if !vm.author.isEmpty {
                            Text("— \(vm.author)")
                                .font(.title3)
                                .foregroundColor(Color("TextSecondary"))
                        }
                    }
                    .frame(maxWidth: .infinity,
                           minHeight: UIScreen.main.bounds.height * 0.7)
                    .padding()
                }
                // Allow refreshing by pull
                .refreshable { vm.fetchQuote() }
                // Tap gesture to refresh quote
                .onTapGesture { vm.fetchQuote() }
            }
        }
        // Fetch quote when the view appears if nothing is loaded
        .onAppear {
            if vm.quoteText.isEmpty && !vm.isLoading {
                vm.fetchQuote()
            }
        }
        // Navigation styling
        .navigationTitle("Inspire")
        .navigationBarTitleDisplayMode(.inline)
    }
}

