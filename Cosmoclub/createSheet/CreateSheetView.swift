//
//  CreateSheetView.swift
//  Cosmoclub
//
//  Created by Pattanan Naosaran on 27/4/2568 BE.
//

import SwiftUI
import PhotosUI

struct CreateSheetView: View {
    
    @State var threadsContent: String = ""
    @State var threadsImage: PhotosPickerItem? = nil
    @State var selectedImage: UIImage? = nil
    
//    @Binding var sendThreads: [Thread]
    
    var body: some View {
        VStack(alignment: .center) {
            VStack() {
                HStack() {
                    Button(action: {
                        print("n")
                    }, label: {
                        Image(systemName: "person.circle.fill")
                    })
                    .font(.system(size: 50))
                    .foregroundStyle(.secondary)
                    .frame(width: 40, height: 40)
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    Text("CosmoClub")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    
                    Spacer()
                    
                    Button(action: {
                        print("n")
                    }, label: {
                        Image(systemName: "magnifyingglass")
                    })
                    .font(.title)
                    .padding(.horizontal, 20)
                    
                }
                .padding(.bottom, 20)
            }
            .background(.ultraThinMaterial)
            
            
            HStack() {
                Button {
                    print("Swift is so cool")
                } label: {
                    Image(systemName: "arrow.left")
                }
                .font(.title)
                .padding(.leading, 20)
                Spacer()
                Text("What's on your mind?")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.vertical, 20)

            ScrollView(.vertical) {
                HStack(alignment: .top) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding(.horizontal, 10)
                        
                    TextEditor(text: $threadsContent)
                        .border(Color.gray)
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .padding(.trailing, 20)
                }
                Spacer()
                VStack{
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 200)
                            .clipped()
                            .padding()
                            .border(.black)
                            .transition(.scale.combined(with: .blurReplace))
                        
                        Button("Unselect Picture") {
                            withAnimation {
                                threadsImage = nil
                                selectedImage = nil
                            }
                        }
                            .buttonStyle(.bordered)
                                      
                    }
                }
            }
            
            VStack() {
                HStack() {
//                    Button(action: {
//                        print("n")
//                    }, label: {
//                        Image(systemName: "person.circle.fill")
//                    })
//                    .font(.system(size: 55))
//                    .foregroundStyle(.secondary)
//                    .frame(width: 40, height: 40)
//                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    PhotosPicker(selection: $threadsImage, matching: .images) {
                        Image(systemName: "photo.badge.arrow.down")
                            .font(.system(size: 55))
                            .foregroundStyle(.black)
                            .padding(.trailing, 40)
                    }

                    
//                    Spacer()
                    
                    Button(action: {
                        let newThreads = Thread(content: threadsContent, image: selectedImage)
//                        sendThreads.append(newThreads)
                        
                        
                    }, label: {
                        Image(systemName: "arrow.right.circle")
                    })
                    .font(.system(size: 55))
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 30)
                    
                }
                .padding(.top, 20)
                
            }
            .background(.ultraThinMaterial)
            
        }
        .onChange(of: threadsImage) { _, newValue in
            Task {
                if let data = try? await newValue?.loadTransferable(type: Data.self),
                        let uiImage = UIImage(data: data) {
                        selectedImage = uiImage
                }
            }
        }
        .onAppear(perform: {
            requestPhotoLibraryAccess()
        })
    }
    
    private func requestPhotoLibraryAccess() {
        let status = PHPhotoLibrary.authorizationStatus()
    
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized {
                    print("Access granted.")
                } else {
                    print("Access denied.")
                }
            }
        case .restricted, .denied:
            print("Access denied or restricted.")
        case .authorized:
            print("Access already granted.")
        case .limited:
            print("Access limited.")
            @unknown default:
            print("Unknown authorization status.")
        }
    }
}

#Preview {
    CreateSheetView(/*sendThreads: .constant(Thread(content: "Hi"))*/)
}

//import SwiftUI
//import PhotosUI//นำเข้า photoKit
//
//struct ContentView: View {
//    @State private var selectedItem: PhotosPickerItem? = nil
//    
//    @State private var selectedImage: UIImage? = nil //ภาพที่userอัพโหลด ถ้ามีีมากกว่า 1 ต้องสร้างเพิ่ม
//    
//    var body: some View {
//        VStack {
//            if let image = selectedImage {
//                //กรณีมีรูป
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 300, height: 200)
//                    .clipped()
//                
//                Button("Reset Picture") {
//                    selectedItem = nil
//                    selectedImage = nil
//                }
//                .buttonStyle(.bordered)
//                
//            } else {
//                //กรณีไม่มีรูป
//                PhotosPicker(selection: $selectedItem, matching: .images) {
//                    ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to select a photo from Photo Library"))
//                    // contentUnavaiableView เป็น syntax ที่ apple ออกแบบไว้ให้
//                }
//                .buttonStyle(.plain)
//            }
//        }
//        .onChange(of: selectedItem) { _, newValue in
//            Task {
//                if let data = try? await newValue?.loadTransferable(type: Data.self),
//                   let uiImage = UIImage(data: data) {
//                    selectedImage = uiImage
//                }
//            }
//        } // onChange จะทำงานเมื่อค่าที่กำหนดเปลี่ยนแปลง(selectedItem)
//        .onAppear(perform: {
//            requestPhotoLibraryAccess()
//        }) // onAppear จะทำงานทุกครั้งเมื่อถูกเปิดหน้า
//    }
//    
//    private func requestPhotoLibraryAccess() {
//        let status = PHPhotoLibrary.authorizationStatus()
//        
//        switch status {
//        case .notDetermined:
//            PHPhotoLibrary.requestAuthorization { newStatus in
//                if newStatus == .authorized {
//                    print("Access granted.")
//                } else {
//                    print("Access denied.")
//                }
//            }
//        case .restricted, .denied:
//            print("Access denied or restricted.")
//        case .authorized:
//            print("Access already granted.")
//        case .limited:
//            print("Access limited.")
//        @unknown default:
//            print("Unknown authorization status.")
//        }
//    }// ฟังก์ชันขอสิทธ์เข้าถึง photoLibrary
//}
//
//#Preview {
//    ContentView()
//}


//.toolbar {
//    ToolbarItemGroup(placement: .bottomBar) {
//        Spacer()
//        Text("\(notes.count) Notes")
//            .font(.footnote)
//        Spacer()
//        Button("Create note", systemImage: "square.and.pencil") {
//            isShowCreateNote.toggle()
//        }
//        
//    }
//    
//    ToolbarItemGroup(placement: .topBarTrailing) {
//        Menu("Sort Menu", systemImage: "arrow.up.arrow.down") {
//            Picker("Sort picker", selection: $sort) {
//                Text("Title")
//                    .tag(SortDescriptor(\Note.title))
//                Text("Last Updated")
//                    .tag(SortDescriptor(\Note.lastUpdated, order: .reverse))
//            }
//        }
//    }
//}
