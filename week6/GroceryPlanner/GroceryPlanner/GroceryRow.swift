import SwiftUI

struct GroceryRow: View {
    @Binding var item: GroceryItem
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: item.bought ? "checkmark.circle.fill" : "circle")
                .foregroundColor(item.bought ? .green : .gray)
                .imageScale(.large)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(item.name)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.primary)  
            }
        }
        .padding(.vertical, 4)
    }
}

