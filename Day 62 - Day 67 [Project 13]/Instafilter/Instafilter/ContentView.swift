//
//  ContentView.swift
//  Instafilter
//
//  Created by Pascal Sauer on 01.02.24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingFilters = false
    
    @AppStorage("filterCount2") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
                
                Section {
                    HStack {
                        Text("Intensity")
                            .frame(width: 72, alignment: .leading)
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity, applyProcessing)
                    }
                    .disabled(hasFilterValue(kCIInputIntensityKey) == false)
                    
                    HStack {
                        Text("Radius")
                            .frame(width: 72, alignment: .leading)
                        Slider(value: $filterRadius)
                            .onChange(of: filterRadius, applyProcessing)
                    }
                    .disabled(hasFilterValue(kCIInputRadiusKey) == false)
                    
                    HStack {
                        Text("Scale")
                            .frame(width: 72, alignment: .leading)
                        Slider(value: $filterScale)
                            .onChange(of: filterScale, applyProcessing)
                    }
                    .disabled(hasFilterValue(kCIInputScaleKey) == false)
                    
                    HStack {
                        Button("Change Filter", action: changeFilter)
                        
                        Spacer()
                        
                        if let processedImage {
                            ShareLink(item: processedImage, preview: SharePreview("InstaFilter image", image: processedImage))
                        }
                    }
                }
                .disabled(processedImage == nil)
                
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("InstaFilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    func changeFilter() {
        showingFilters = true
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    
    func applyProcessing() {
        let inputkeys = currentFilter.inputKeys

        if inputkeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }

        if inputkeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputkeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey)
        }

        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        
        filterCount += 1
        if filterCount >= 20 {
            requestReview()
        }
    }
    
    func hasFilterValue(_ filterValue: String) -> Bool {
        currentFilter.inputKeys.contains(filterValue)
    }
}

#Preview {
    ContentView()
}
