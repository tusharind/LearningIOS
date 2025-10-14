import Foundation
import UIKit
import CoreLocation
import Combine

class AddMemoryViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var location: CLLocation?
    @Published var placeName: String?
    @Published var isSaving = false
    
    private let locationManager = LocationManager()
    private let listViewModel: MemoryListViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(listViewModel: MemoryListViewModel) {
        self.listViewModel = listViewModel
        
        // Observe location updates from LocationManager
        locationManager.$currentLocation
            .sink { [weak self] loc in
                self?.location = loc
            }
            .store(in: &cancellables)
        
        locationManager.$placeName
            .sink { [weak self] name in
                self?.placeName = name
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Location
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    // MARK: - Save Memory
    func saveMemory() {
        guard let image = selectedImage else { return }
        
        // Use current location or fallback to 0.0
        let lat = location?.coordinate.latitude ?? 0.0
        let lon = location?.coordinate.longitude ?? 0.0
        
        isSaving = true
        
        listViewModel.addEntry(
            image: image,
            location: (lat, lon),
            placeName: placeName
        )
        
        isSaving = false
    }
    
    // MARK: - Reset
    func reset() {
        selectedImage = nil
        location = nil
        placeName = nil
    }
}

