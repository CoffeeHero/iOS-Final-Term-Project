//
//  Data.swift
//  MusicAppTest
//
//  Created by Ming on 2021/6/19.
//

import Foundation
import SwiftUI
import Firebase

class OurData : ObservableObject{
    
    @Published public var albums = [Album]()
//    @Published public var albums = [Album(name : "Album 1",image : "music.note.list" , songs :[Song(time : "2:36", name :"Song 1"),Song(time : "2:36", name :"Song 1")
//    ]),
//    Album(name : "Album 2",image : "music.note.list" , songs :[Song(time : "2:36", name :"Song 3"),Song(time : "2:36", name :"Song 4")
//    ]),
//    Album(name : "Album 3",image : "music.note.list" , songs :[Song(time : "2:36", name :"Song 5"),Song(time : "2:36", name :"Song 6")
//    ])]
    
    
    
    
    func loadAlbums(){
        albums.removeAll()
        Firestore.firestore().collection("albums").getDocuments{ (snapshot,error) in
        if error == nil {
            for document in snapshot!.documents{
                let name = document.data()["name"] as? String ?? "error"
                let time = document.data()["time"] as? String ?? "error"
                let songs = document.data()["songs"] as? [String: [String:Any]]
                
                let image = document.data()["image"] as? String ?? "1"
                var songsArray = [Song]()
                print(songsArray)
                if let songs = songs {
                    for song in songs{
                        
                        let songName = song.value["name"] as? String ?? "error"
                        let songTime = song.value["time"] as? String ?? "error"
                        print(songName)
                        let songFile = song.value["file"] as? String ?? "error"
                        songsArray.append(Song(time : songTime, name : songName, file: songFile))
                    }
                }
                print(songsArray)
                self.albums.append(Album(name:name,image:image,songs:songsArray))
            }
            
        }else{
            print(error)
        }
            
        }
    }
}
