//
//  samplerSound.swift
//  IBand
//
//  Created by Mac on 2021/6/18.
//

import Foundation
import AVFoundation
var audioPlayer: AVAudioPlayer?

func samplerSound(sound:String,type:String){
    
    if let path = Bundle.main.path(forResource:sound,ofType: type){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf:URL(fileURLWithPath: path))
            audioPlayer?.play()
        }catch{
            print("samplerSounds ERROR")
        }
    }
}
