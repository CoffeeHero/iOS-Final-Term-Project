//
//  MusicAppTestApp.swift
//  MusicAppTest
//
//  Created by Ming on 2021/6/18.
//

import SwiftUI
import Firebase


@main
struct MusicAppTestApp: App {
    let data = OurData()
    init(){
        FirebaseApp.configure()
        data.loadAlbums()
    }
    var body: some Scene {
        WindowGroup {
            ContentView(data:data)
        }
    }
}
