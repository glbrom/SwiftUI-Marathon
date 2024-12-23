//
//  ContentView.swift
//  Instafilter
//
//  Created by Roman Golub on 13.10.2024.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterScale = 0.5
    @State private var filterRadius = 0.5
    @State private var showingImagePicker = false
    @State private var showingFilterSheet = false
    @State private var showingSaveButton = false

    @State private var inputImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    
    @State private var processedImage: UIImage?
    
    let context = CIContext()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
//                    PhotosPicker(selection: $selectedItem) {
//                        if let processedImage {
//                            processedImage
//                                .resizable()
//                                .scaledToFit()
//                        } else {
//                            ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
//                        }
//                    }
//                    .buttonStyle(.plain)
//                    .onChange(of: selectedItem, loadImage)
//                    ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    Rectangle()
                        .cornerRadius(30)
//                        .fill(.gray)

                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                        .scaleEffect(x: showingSaveButton ? 0 : 1, y: showingSaveButton ? 0 : 1)

                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                .onChange(of: image) { newValue in
                    guard let _ = newValue else {
                        return
                    }
                    
                    showingSaveButton = true
                }

                HStack {
                    Text("Intensity")
                        .frame(width: 70, alignment: .leading)
                    
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { _ in
                                applyProcessing()
                            }
                }
                
                HStack {
                    Text("Scale")
                        .frame(width: 70, alignment: .leading)
                    
                    Slider(value: $filterScale)
                        .onChange(of: filterScale) { _ in
                                applyProcessing()
                            }
                }
                
                HStack {
                    Text("Radius")
                        .frame(width: 70, alignment: .leading)
                    
                    Slider(value: $filterRadius)
                        .onChange(of: filterRadius) { _ in
                                applyProcessing()
                            }
                }

                HStack {
                    Button("Change Filter") {
                        showingFilterSheet = true
                    }

                    Spacer()

                    Button("Save", action: save)
                        .disabled(!showingSaveButton)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Group {
                    Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                    Button("Edges") { setFilter(CIFilter.edges()) }
                    Button("Edge Work") { setFilter(CIFilter.edgeWork()) }
                    Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                    Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                    Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                    Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                    Button("Vignette") { setFilter(CIFilter.vignette()) }
                    Button("Bloom") { setFilter(CIFilter.bloom()) }
                    Button("Gloom") { setFilter(CIFilter.gloom()) }
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    // MARK - Extra Funcs
    func save() {
        guard let processedImage = processedImage else { return }

        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success!")
        }

        imageSaver.errorHandler = {
            print("Oops: \($0.localizedDescription)")
        }

        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey) }

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

#Preview {
    ContentView()
}
