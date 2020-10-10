//
//  ViewController.swift
//  GooglePlacesSearchController
//
//  Created by Dmitry Shmidt on 6/28/15.
//  Copyright (c) 2015 Dmitry Shmidt. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import GooglePlacesSearchController
import AVFoundation

/*Arabic (Saudi Arabia) - ar-SA
Chinese (China) - zh-CN
Chinese (Hong Kong SAR China) - zh-HK
Chinese (Taiwan) - zh-TW
Czech (Czech Republic) - cs-CZ
Danish (Denmark) - da-DK
Dutch (Belgium) - nl-BE
Dutch (Netherlands) - nl-NL
English (Australia) - en-AU
English (Ireland) - en-IE
English (South Africa) - en-ZA
English (United Kingdom) - en-GB
English (United States) - en-US
Finnish (Finland) - fi-FI
French (Canada) - fr-CA
French (France) - fr-FR
German (Germany) - de-DE
Greek (Greece) - el-GR
Hindi (India) - hi-IN
Hungarian (Hungary) - hu-HU
Indonesian (Indonesia) - id-ID
Italian (Italy) - it-IT
Japanese (Japan) - ja-JP
Korean (South Korea) - ko-KR
Norwegian (Norway) - no-NO
Polish (Poland) - pl-PL
Portuguese (Brazil) - pt-BR
Portuguese (Portugal) - pt-PT
Romanian (Romania) - ro-RO
Russian (Russia) - ru-RU
Slovak (Slovakia) - sk-SK
Spanish (Mexico) - es-MX
Spanish (Spain) - es-ES
Swedish (Sweden) - sv-SE
Thai (Thailand) - th-TH
Turkish (Turkey) - tr-TR
*/
class ViewController: UIViewController {
    @IBOutlet weak var address: UILabel!
    
    @IBAction func button(_ sender: Any) {
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: " \(address.text!)")
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
    
    let GoogleMapsAPIServerKey = "AIzaSyBdXLQ3YyLiRoSoeo3J9lw6pGA8KH2CZts"

    lazy var placesSearchController: GooglePlacesSearchController = {
        let controller = GooglePlacesSearchController(delegate: self,
                                                      apiKey: GoogleMapsAPIServerKey,
                                                      placeType: .address,
          coordinate: CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423),
           radius: 10,
           strictBounds: true,
           searchBarPlaceholder: "Start typing..."
        )
       //controller.searchBar.isTranslucent = false
      // controller.searchBar.barStyle = .black
      //controller.searchBar.tintColor = .white
       //controller.searchBar.barTintColor = .black
        return controller
    }()

    @IBAction func searchAddress(_ sender: UIBarButtonItem) {
        present(placesSearchController, animated: true, completion: nil)
   
    }
}

extension ViewController: GooglePlacesAutocompleteViewControllerDelegate {
    func viewController(didAutocompleteWith place: PlaceDetails) {
        print("---> \(place.description) ")
        address.text = "안녕하세요 저는 김도연입니다"
        placesSearchController.isActive = false
        dismiss(animated: true, completion: nil)
 
    }
    
    func viewController(didManualCompleteWith text: String) {
        print(text)
        placesSearchController.isActive = false
 
    }
}
