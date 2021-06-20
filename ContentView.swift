//
//  ContentView.swift
//  MusicAppTest
//
//  Created by Ming on 2021/6/18.
//

import SwiftUI
import Firebase

struct Album : Hashable{ 
    var id = UUID()
    var name : String
    var image : String
    var songs : [Song]
}

struct Song : Hashable{
    var id = UUID()
    var time : String
    var name : String
    var file : String
}




struct ContentView: View {
    
//    var albums = [Album(name : "Album 1",image : "music.note.list" , songs :[Song(time : "2:36", name :"Song 1"),Song(time : "2:36", name :"Song 1")
//    ]),
//    Album(name : "Album 2",image : "music.note.list" , songs :[Song(time : "2:36", name :"Song 3"),Song(time : "2:36", name :"Song 4")
//    ]),
//    Album(name : "Album 3",image : "music.note.list" , songs :[Song(time : "2:36", name :"Song 5"),Song(time : "2:36", name :"Song 6")
//    ])]
    
    @ObservedObject var data : OurData
    var body: some View {
        NavigationView{
            LazyVStack(spacing: 50){
                NavigationLink(
                    destination: MusicList_temp(data: data),
                    label: {
                        Text("Music Modifier")
                            .font(.system(size: 30, weight: .heavy ,design: .serif))
                    }).buttonStyle(PlainButtonStyle())
                NavigationLink(
                    destination: MusicList(data: data),
                    label: {
                        Text("Music Player")
                            .font(.system(size: 30, weight: .heavy ,design: .serif))
                    }).buttonStyle(PlainButtonStyle())
            }
            VStack{
                Text("iBand").font(.system(size: 90, weight: .heavy ,design: .serif))
//                    .italic()
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("by 鮑伽呈, 黃關明, 陳申")
                    .font(.system(size: 30, weight: .light, design: .serif))
                    .italic()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
        }
    }
}

struct MusicList : View{
    @ObservedObject var data : OurData
    @State var currentAlbum : Album?
    @State var show = false
    @State var alert = false
    @State var newAlbumName = ""
    var db = Firestore.firestore()
    var body: some View {
        ScrollView{
            ScrollView(.horizontal,showsIndicators: false, content:{
                LazyHStack{
                    ForEach(self.data.albums, id:\.self,content:{
                    album in AlbumArt(album: album,isWithText: true).onTapGesture{
                        self.currentAlbum = album
                    }
                })
                VStack{
                    TextField("Album Name", text: $newAlbumName)
                    Button(action: {
                        db.collection("albums").document(newAlbumName).setData([
                            "name": newAlbumName,
                            "image": "1"
                        ])
                           }) {
                               Text("add new album")
                                   .font(.system(size: 20))
                                   .background(Color.white)
                                   .foregroundColor(.black)
                        }
                }
                    
                }
            })
            LazyVStack{
                if (self.data.albums.first == nil){
                    EmptyView()
                }else{
                ForEach((self.currentAlbum?.songs ?? self.data.albums.first?.songs) ?? [Song(time: "", name: "", file: "")], id: \.self,content:{
                    song in SongCell(album: currentAlbum ?? self.data.albums.first!,song : song)
                })}
            }
            Button(action: {
                self.show.toggle()
                   }) {
                       Text("upload music")
                           .font(.system(size: 20))
                           .background(Color.white)
                           .foregroundColor(.black)
            }.sheet(isPresented: $show){
                DocumentPicker(alert: self.$alert, album: currentAlbum ?? self.data.albums.first!)
            }.alert(isPresented: $alert){
                Alert(title: Text("Message"), message: Text("Upload Successfully!!!"), dismissButton: .default(Text("OK")))
            }
            
        }
    }
}

//struct UploadSong : View{
//    @State private var path = ""
//    var body: some View{
//        VStack{
//            Text("Enter song path")
//                .font(.system(size: 30, weight: .heavy ,design: .serif))
//            TextField("file path in your device", text: $path)
//            Button(action: {
//                print (path)
//                   }) {
//                       Text("Submit")
//                           .font(.system(size: 40))
//                           .background(Color.white)
//                           .foregroundColor(.black)
//                   }
//        }
//    }
//}



struct AlbumArt : View{
    var album : Album
    var isWithText : Bool
    var body: some View{
        ZStack(alignment: .bottom, content: {
        
            Image(album.image).resizable().frame(width:200,height :200,alignment: .center)
            if  isWithText == true {
            ZStack {
                Blur(style: .dark)
                Text(album.name).foregroundColor(.white).frame(height:60,alignment:.center)
            }}
        }).frame(width:200,height:200, alignment:.center).clipped().cornerRadius(20).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ ).padding(20)
    }
}

struct SongCell :View{
    var album : Album
    var song : Song
    var body : some View{
        NavigationLink(
            destination: PlayerView(album: album, song: song),
            label: {
                HStack{
                    ZStack{
                        Circle().frame(width:50,height:50,alignment: .center).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Circle().frame(width:20,height:20,alignment: .center).foregroundColor(.white)
                        
                    }
                    Text(song.name).bold()
                    Spacer()
                    Text(song.time)
                    
                }.padding(20)
            }).buttonStyle(PlainButtonStyle())
        
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        //ContentView(data:OurData())
//        //SongCell(song:Song(time:"2:36", name:"Song 1"))
//        //AlbumArt(album: Album(name: "Album 1",image:"music.note.list",songs:[Song(time : "2:36", name :"Song 1"),Song(time : "2:36", name :"Song 2")]))
//    }
//}
struct DocumentPicker : UIViewControllerRepresentable{
//    func makeUIViewController(content: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController{
//        let picker = UIDocumentPickerViewController(documentTypes: [], in: .open)
//        picker.allowsMultipleSelection = false
//        return picker
//    }
    var db = Firestore.firestore()
    @Binding var alert : Bool
    var album : Album
    
    func makeCoordinator() -> DocumentPicker.Coordinator {
        
        return DocumentPicker.Coordinator(parent1: self, album1: album)
    }
    
    
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.png, .mp3], asCopy: true)
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {
        
    }
    
    class Coordinator : NSObject, UIDocumentPickerDelegate{
        var parent : DocumentPicker
        var db = Firestore.firestore()
        var album : Album
        init(parent1 : DocumentPicker, album1 : Album){
            parent = parent1
            album = album1
        }
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            print(urls)
            let bucket = Storage.storage().reference()
            let songNameWithPath = String((urls.first?.deletingPathExtension().lastPathComponent)!)
            print(String("songs" + songNameWithPath))
//            bucket.child((urls.first?.deletingPathExtension().lastPathComponent)!).putFile(from: urls.first!, metadata: nil){
            bucket.child(String("songs/" + songNameWithPath + ".mp3")).putFile(from: urls.first!, metadata: nil){
                (_, err) in
                if err != nil{
                    print((err?.localizedDescription)!)
                    return
                }
                print ("success")
                self.parent.alert.toggle()
            }
            
//            let docRef = self.db.collection("albums").document("1")
            db.collection("albums").document(album.name).setData([ "songs": [songNameWithPath : ["name" : String(songNameWithPath), "file": String("gs://iband-43126.appspot.com/songs/" + songNameWithPath + ".mp3"), "time": "00:000"]] ], merge: true)
            

        }
    }
}

struct MusicList_temp : View{
    @ObservedObject var data : OurData
    @State var currentAlbum : Album?
    @State var show = false
    @State var alert = false
    var body: some View {
        ScrollView{
            ScrollView(.horizontal,showsIndicators: false, content:{
                LazyHStack{
                    ForEach(self.data.albums, id:\.self,content:{
                    album in AlbumArt(album: album,isWithText: true).onTapGesture{
                        self.currentAlbum = album
                    }
                })
                    
                }
            })
            LazyVStack{
                if (self.data.albums.first == nil){
                    EmptyView()
                }else{
                ForEach((self.currentAlbum?.songs ?? self.data.albums.first?.songs) ?? [Song(time: "", name: "", file: "")], id: \.self,content:{
                    song in SongCell(album: currentAlbum ?? self.data.albums.first!,song : song)
                })}
            }
            Button(action: {
                self.show.toggle()
                   }) {
                       Text("upload music")
                           .font(.system(size: 20))
                           .background(Color.white)
                           .foregroundColor(.black)
            }.sheet(isPresented: $show){
                DocumentPicker(alert: self.$alert, album: currentAlbum ?? self.data.albums.first!)
            }.alert(isPresented: $alert){
                Alert(title: Text("Message"), message: Text("Upload Successfully!!!"), dismissButton: .default(Text("OK")))
            }
            
        }
    }
}



struct AlbumArt_temp : View{
    var album : Album
    var isWithText : Bool
    var body: some View{
        ZStack(alignment: .bottom, content: {
        
            Image(album.image).resizable().frame(width:200,height :200,alignment: .center)
            if  isWithText == true {
            ZStack {
                Blur(style: .dark)
                Text(album.name).foregroundColor(.white).frame(height:60,alignment:.center)
            }}
        }).frame(width:200,height:200, alignment:.center).clipped().cornerRadius(20).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ ).padding(20)
    }
}

struct SongCell_temp :View{
    var album : Album
    var song : Song
    var body : some View{
        NavigationLink(
            destination: MixerView(album: album, song: song),
            label: {
                HStack{
                    ZStack{
                        Circle().frame(width:50,height:50,alignment: .center).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Circle().frame(width:20,height:20,alignment: .center).foregroundColor(.white)
                        
                    }
                    Text(song.name).bold()
                    Spacer()
                    Text(song.time)
                    
                }.padding(20)
            }).buttonStyle(PlainButtonStyle())
        
    }
}
