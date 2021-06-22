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
    @State var startBlock : Bool = false
    
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
                    if funcView != 2{
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
            
            .padding(.leading,75)
            .padding(.trailing,45)
            HStack(alignment: .top, spacing: 60, content: {
                
                // second part
                if funcView==1 {
                    HotCuePage(player: $player)
                    
                }
                if funcView==2{
                    SamplerPage()
                }
                
                if funcView == 3{
                    LoopPage(player: $player)
                }
//                VStack {
//                    Text("Volume")
//                        .foregroundColor(Color(red:253/255, green: 153/255, blue: 74/255))
//                        .font(.system(size: 40))
//                        .frame(width: 230, height: 85, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                        .background(Color(red: 37/255, green: 33/255, blue: 30/255))
//                        .cornerRadius(15)
//                    CustomSlider(percentage: $leftVolSlider)
//                        .accentColor(.orange)
//                        .frame(width: 300, height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                        .padding(.top,70)
//                    CustomSlider(percentage: $leftVolSlider)
//                        .accentColor(.orange)
//                        .frame(width: 300, height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                        .padding(.top,100)
//
//                }
                Image("CD")
                    
                    .resizable()
                    .scaledToFill()
                    .frame(width: 400, height: 400
                           , alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .shadow(radius: 100)
//                    .padding(.bottom,25)
//                    .padding(.leading,150)

                    .rotationEffect(Angle(degrees:self.isAnimating ? 360.0:0.0))
                    .animation(isAnimating ? Animation.linear(duration: 2.0)
                    .repeatForever(autoreverses: false) : .default)
                    .onTapGesture {
                        samplerSound(sound: "Djing", type: "mp3")
                    }
                    .overlay(
                        Image("line")
                                    .offset(x:130,y:-40)
                    )
                    
//                Button(action: {
//                    samplerSound(sound: "Djing", type: "mp3")
//
//                }, label: {
//                    Image("CD")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 400, height: 400
//                               , alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
//                        .shadow(radius: 100)
//    //                    .padding(.bottom,25)
//    //                    .padding(.leading,150)
//
//                        .rotationEffect(Angle(degrees:self.isAnimating ? 360.0:0.0))
//                        .animation(isAnimating ? Animation.linear(duration: 2.0)
//                        .repeatForever(autoreverses: false) : .default)
//                        .overlay(
//                            Image("line")
//                                        .offset(x:130,y:-40)
//                        )
//                })
                
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
                
//                Spacer()
//                
                Button(action: {
                    
                    if startBlock==true{
                        self.playPause()
                        isAnimating = isAnimating ? false : true
                    }
                    else if startBlock==false{
                        isPlaying=true
                        self.playSong()
                        isAnimating = true
                    }
                    startBlock=true
                }, label: {
                    Image("start")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 180, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                })
                .frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color(red: 37/255, green: 33/255, blue: 30/255))
                .cornerRadius(8)
                
                
                Button(action: {
                    self.player.seek(to: CMTimeMakeWithSeconds(0.0, preferredTimescale: 60000))
                }, label: {
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
                print("error")
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
//        MixerView(album: , song: <#Song#>).previewLayout(.fixed(width: 1366, height: 1024))
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


struct HotCuePage: View {
    @Binding var player:AVPlayer
    @State var hotCue_1:Bool=false
    @State var hotCue_1_seekTime : Float64 = 0.0
    @State var hotCue_2:Bool=false
    @State var hotCue_2_seekTime : Float64 = 0.0
    @State var hotCue_3:Bool=false
    @State var hotCue_3_seekTime : Float64 = 0.0
    @State var hotCue_4:Bool=false
    @State var hotCue_4_seekTime : Float64 = 0.0
    var body: some View {
        VStack {
            
            HStack {
                Button(action: {
                   
                    if hotCue_1{
                        
                        self.player.seek(to: CMTimeMakeWithSeconds(hotCue_1_seekTime, preferredTimescale: 60000))
                         
                    }else{
                        let seekTime = player.currentTime()
                        hotCue_1_seekTime=CMTimeGetSeconds(seekTime)
                        hotCue_1=true
                    }
                    
                    
                    
                }, label: {
                    Text("")
                        .frame(width:170,height:150)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                    
                })
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.orange,lineWidth: 4))
                Button(action: {
                    if hotCue_2{
                        
                        self.player.seek(to: CMTimeMakeWithSeconds(hotCue_2_seekTime, preferredTimescale: 60000))
                         
                    }else{
                        let seekTime = player.currentTime()
                        hotCue_2_seekTime=CMTimeGetSeconds(seekTime)
                        hotCue_2=true
                    }
                }, label: {
                    Text("")
                        .frame(width:170,height:150)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                    
                })
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.green,lineWidth: 4))
                
            }
            .padding(.bottom,0)
            .padding(.leading,70)
            HStack {
                Button(action: {
                    if hotCue_3{
                        
                        self.player.seek(to: CMTimeMakeWithSeconds(hotCue_3_seekTime, preferredTimescale: 60000))
                         
                    }else{
                        let seekTime = player.currentTime()
                        hotCue_3_seekTime=CMTimeGetSeconds(seekTime)
                        hotCue_3=true
                    }
                }, label: {
                    Text("")
                        .frame(width:170,height:150)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                    
                })
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue,lineWidth: 4))
                Button(action: {
                        if hotCue_4{
                            
                            self.player.seek(to: CMTimeMakeWithSeconds(hotCue_4_seekTime, preferredTimescale: 60000))
                             
                        }else{
                            let seekTime = player.currentTime()
                            hotCue_4_seekTime=CMTimeGetSeconds(seekTime)
                            hotCue_4=true
                        }
                    
                }, label: {
                    Text("")
                        .frame(width:170,height:150)
                        .padding()
                        .background(Color.black)
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
                    samplerSound(sound: "electronic", type: "mp3")
                }, label: {
                    Text("Electronic")
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
struct LoopPage: View {
    @Binding var player:AVPlayer
    @State var inTime : Float64 = 0.0
    @State var outTime : Float64 = 0.0
    
    var body: some View {
        VStack {
            
            HStack {
                Button(action: {
                    inTime=CMTimeGetSeconds(player.currentTime())
                }, label: {
                    Text("IN")
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                        .frame(width:170,height:150)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                    
                })
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.green,lineWidth: 4))
                Button(action: {
                    outTime=CMTimeGetSeconds(player.currentTime())
                }, label: {
                    Text("OUT")
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                        .frame(width:170,height:150)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                    
                })
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.red,lineWidth: 4))
                
            }
            .padding(.bottom,0)
            .padding(.leading,70)
            HStack {
                Button(action: {
                    let loopTime=outTime-inTime
//                    let playerLooper = AVPlayerLooper(player: #selector, templateItem: #selector, timeRange: loopTime)
                    self.player.seek(to:CMTimeMakeWithSeconds((outTime-inTime),preferredTimescale: 60000),toleranceBefore: CMTimeMakeWithSeconds(outTime,preferredTimescale: 60000),toleranceAfter: CMTimeMakeWithSeconds(inTime,preferredTimescale: 60000))
                }, label: {
                    Text("START")
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                        .frame(width:370,height:150)
                        .padding()
                        .background(Color.black)
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
