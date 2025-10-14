import SwiftUI

struct MemoryDetailView: View {
    let entry: MemoryEntry

    var body: some View {
        VStack(spacing: 20) {
            if let image = StorageManager.shared.loadImage(from: entry.imagePath) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding()
            }

            Text(entry.placeName ?? "Lat: \(entry.latitude), Lon: \(entry.longitude)")
                .font(.headline)

            Text(entry.timestamp, style: .date)
                .font(.subheadline)
                .foregroundColor(.gray)

            Spacer()
        }
        .navigationTitle("Memory")
        .padding()
    }
}

