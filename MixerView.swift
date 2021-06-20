//
//  EdwardView.swift
//  MusicAppTest
//
//  Created by  iLab on 2021/6/19.
//

import Foundation
import SwiftUI
//import SwiftAudioPlayer
import AVKit
import AVFoundation
import Firebase

struct MixerView: View {
    @State  var album : Album
    @State  var song : Song
    @State var player = AVPlayer()
    @State var isPlaying : Bool = false
    
    @State private var leftVolSlider:Float=0
    @State private var rightVolSlider:Float=0
    @State private var funcView:Int=1 //HotCue,Loop,Sampler View
    @State private var HotCueView = false
    @State private var LoopView = true
    @State private var SamplerView = true
    @State var angle: Double = 0.0
    @State var isAnimating = false
        
        
    var body: some View {
        let funcTitle:[String]=["nil","HotCue","Sampler","Loop"]
        VStack {
            // top part
            HStack{
                
                Button(action: {
                    if funcView != 1{
                        funcView -= 1
                    }
                }, label: {
                    Image(systemName: "arrowshape.turn.up.left")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 45))
                    
                })
                .frame(width: 85, height: 85, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color(red: 37/255, green: 33/255, blue: 30/255))
                .cornerRadius(15)
                
                Text(funcTitle[funcView])
                    .foregroundColor(Color(red:253/255, green: 153/255, blue: 74/255))
                    .font(.system(size: 40))
                    .frame(width: 230, height: 85, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color(red: 37/255, green: 33/255, blue: 30/255))
                    .cornerRadius(15)
                
                Button(action: {
                    if funcView != 3{
                        funcView += 1
                    }
                }, label: {
                    Image(systemName: "arrowshape.turn.up.right")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 45))
                    
                })
                .frame(width: 85, height: 85, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color(red: 37/255, green: 33/255, blue: 30/255))
                .cornerRadius(15)
                Spacer()
                
            }
            
            .padding(.leading,50)
            .padding(.trailing,45)
            HStack(alignment: .top, spacing: 60, content: {
                
                // second part
                if funcView==1 {
                    HotCuePage()
                    
                }
                else if funcView==2{
                    SamplerPage()
                }
                else if funcView==3{
                    
                }
                
                VStack {
                    Text("Volume")
                        .foregroundColor(Color(red:253/255, green: 153/255, blue: 74/255))
                        .font(.system(size: 40))
                        .frame(width: 230, height: 85, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color(red: 37/255, green: 33/255, blue: 30/255))
                        .cornerRadius(15)
                    CustomSlider(percentage: $leftVolSlider)
                        .accentColor(.orange)
                        .frame(width: 300, height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(.top,70)
                    CustomSlider(percentage: $leftVolSlider)
                        .accentColor(.orange)
                        .frame(width: 300, height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(.top,100)
                    
                }
                Image("CD")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 400, height: 400
                           , alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .shadow(radius: 100)
                    .padding(.bottom,25)
                    
                    .rotationEffect(Angle(degrees:self.isAnimating ? 360.0:0.0))
                    .animation(isAnimating ? Animation.linear(duration: 2.0)
                    .repeatForever(autoreverses: false) : .default)
//
                Spacer()
                    .padding()
                
                
            })
            
            //under part
            HStack {
//                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//                    Image("start")
//                        .resizable()
//                        .foregroundColor(.gray)
//                        .frame(width: 180, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                })
//                .frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                .background(Color(red: 37/255, green: 33/255, blue: 30/255))
//                .cornerRadius(8)
//
//
//                Button(action: {}, label: {
//                    Text("Cue")
//                        .foregroundColor(.gray)
//                        .font(.system(size: 60))
//                    
//                })
//                .frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                .background(Color(red: 37/255, green: 33/255, blue: 30/255))
//                .cornerRadius(8)
                
                Spacer()
                
                Button(action: {
                    isAnimating = isAnimating ? false : true
                }, label: {
                    Image("start")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 180, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                })
                .frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color(red: 37/255, green: 33/255, blue: 30/255))
                .cornerRadius(8)
                
                
                Button(action: {}, label: {
                    Text("Cue")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 60))
                    
                })
                .frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color(red: 37/255, green: 33/255, blue: 30/255))
                .cornerRadius(8)
            }
            .padding(.trailing,75)
            .padding(.leading,53)
            .padding(.top,40)
        }
    }
    func playSong(){
        let storage = Storage.storage().reference(forURL: self.song.file)
        storage.downloadURL{(url,error) in
            if error != nil{
                print(error)
            }else{
                
                do{
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                }
                catch{
                    
                }
                
                player = AVPlayer(playerItem: AVPlayerItem(url: url!))
                player.play()
            }
            
        }
    }

    func playPause(){
        self.isPlaying.toggle()
        if isPlaying == false{
            player.pause()
        }else{
            player.play()
        }
        
    }

}

//struct MixerView_Previews: PreviewProvider {
//    static var previews: some View {
//        MixerView(album: "", song: "").previewLayout(.fixed(width: 1366, height: 1024))
//    }
//}
struct CustomSlider: View {
    
    @Binding var percentage: Float // or some value binded
    
    var body: some View {
        GeometryReader { geometry in
            // TODO: - there might be a need for horizontal and vertical alignments
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.gray)
                Rectangle()
                    .foregroundColor(.accentColor)
                    .frame(width: geometry.size.width * CGFloat(self.percentage / 100))
            }
            .cornerRadius(12)
            .gesture(DragGesture(minimumDistance: 0)
                        .onChanged({ value in
                            // TODO: - maybe use other logic here
                            self.percentage = min(max(0, Float(value.location.x / geometry.size.width * 100)), 100)
                        }))
        }
    }
}

struct HotCueButton: View {
    var body: some View {
        Button(action: {
//            samplerSound(sound: "airhorn", type: "mp3")
        }, label: {
            Text("")
                .frame(width:170,height:150)
                .padding()
                .background(Color.black)
                .cornerRadius(10)
            
        })
    }
}
struct HotCuePage: View {
    var body: some View {
        VStack {
            
            HStack {
                HotCueButton()
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.orange,lineWidth: 4))
                HotCueButton()
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.green,lineWidth: 4))
                
            }
            .padding(.bottom,0)
            .padding(.leading,70)
            HStack {
                HotCueButton()
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue,lineWidth: 4))
                HotCueButton()
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.purple,lineWidth: 4))
            }
            .padding(.top,0)
            .padding(.leading,70)
        }
    }
}
struct SamplerPage: View {
    var body: some View {
        VStack {
            
            HStack {
                Button(action: {
                    samplerSound(sound: "bass", type: "mp3")
                }, label: {
                    Text("Bass")
                        .foregroundColor(.black)
                        .font(.system(size: 40))
                        .frame(width:170,height:150)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                    
                })
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.orange,lineWidth: 4))
                Button(action: {
                    samplerSound(sound: "Djing", type: "mp3")
                }, label: {
                    Text("Scratch")
                        .foregroundColor(.black)
                        .font(.system(size: 40))
                        .frame(width:170,height:150)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                    
                })
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.green,lineWidth: 4))
                
            }
            .padding(.bottom,0)
            .padding(.leading,70)
            HStack {
                Button(action: {
                    samplerSound(sound: "disc", type: "mp3")
                }, label: {
                    Text("Disco")
                        .foregroundColor(.black)
                        .font(.system(size: 40))
                        .frame(width:170,height:150)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                    
                })
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue,lineWidth: 4))
                Button(action: {
                    samplerSound(sound: "mlg-airhorn", type: "mp3")
                }, label: {
                    Text("Airhorn")
                        .foregroundColor(.black)
                        .font(.system(size: 40))
                        .frame(width:170,height:150)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                    
                })
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.purple,lineWidth: 4))
            }
            .padding(.top,0)
            .padding(.leading,70)
        }
    }
}
