import SwiftUI

struct AddMemoryView: View {
    @ObservedObject var viewModel: AddMemoryViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showingImagePicker = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                // Show selected image
                if let image = viewModel.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .cornerRadius(12)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 300)
                        .cornerRadius(12)
                        .overlay(
                            Text("Tap to select photo")
                                .foregroundColor(.gray)
                        )
                        .onTapGesture { showingImagePicker = true }
                }
                
                // Location info
                if let place = viewModel.placeName {
                    Text("Location: \(place)")
                } else {
                    Text("Fetching location...")
                }
                
                Spacer()
                
                // Save button
                Button(action: {
                    viewModel.saveMemory()
                    viewModel.reset()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save Memory")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.selectedImage != nil ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(viewModel.selectedImage == nil)
                
            }
            .padding()
            .navigationTitle("Add Memory")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        viewModel.reset()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                    }
                }
            }
            .onAppear {
                viewModel.requestLocation()
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $viewModel.selectedImage)
            }
        }
    }
}
