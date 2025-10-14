import SwiftUI

struct MemoryListView: View {
    @StateObject private var viewModel = MemoryListViewModel()
    @State private var showingAddMemory = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.entries) { entry in
                    NavigationLink(
                        destination: MemoryDetailView(entry: entry)
                    ) {
                        HStack {
                            if let image = StorageManager.shared.loadImage(from: entry.imagePath) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipped()
                                    .cornerRadius(8)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(entry.placeName ?? "Lat: \(entry.latitude), Lon: \(entry.longitude)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                Text(entry.timestamp, style: .date)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteEntry)
            }
            .navigationTitle("Memories")
            .toolbar {
                Button(action: { showingAddMemory = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddMemory) {
                AddMemoryView(viewModel: AddMemoryViewModel(listViewModel: viewModel))
            }
        }
    }
}

